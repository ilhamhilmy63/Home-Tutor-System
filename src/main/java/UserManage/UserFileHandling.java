package UserManage;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.locks.ReentrantReadWriteLock;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserFileHandling {
    private static final Logger logger = Logger.getLogger(UserFileHandling.class.getName());
    private static final String DATA_DIR = "C:\\OOP Project\\Home-Tutor-System\\src\\main\\resources";
    private static final String DATA_FILE = DATA_DIR + "C:\\OOP Project\\Home-Tutor-System\\src\\main\\resources";
    private static final String BACKUP_FILE = DATA_DIR + "\\User.backup.json";

    private static final ReentrantReadWriteLock lock = new ReentrantReadWriteLock();
    private static final ObjectMapper objectMapper = new ObjectMapper()
            .enable(SerializationFeature.INDENT_OUTPUT)
            .registerModule(new JavaTimeModule());

    static {
        ensureDataDirectoryExists();
    }

    private static void ensureDataDirectoryExists() {
        try {
            Path path = Paths.get(DATA_DIR);
            if (!Files.exists(path)) {
                Files.createDirectories(path);
                logger.info("Created data directory: " + DATA_DIR);
            }
        } catch (IOException e) {
            logger.log(Level.SEVERE, "Failed to create data directory", e);
        }
    }

    public static boolean saveUsers(List<User> users) {
        lock.writeLock().lock();
        try {
            // Create backup first
            if (Files.exists(Paths.get(DATA_FILE))) {
                Files.copy(Paths.get(DATA_FILE), Paths.get(BACKUP_FILE),
                        StandardCopyOption.REPLACE_EXISTING);
            }

            // Write new data
            objectMapper.writeValue(new File(DATA_FILE), users);
            logger.info("Successfully saved " + users.size() + " users to " + DATA_FILE);
            return true;
        } catch (IOException e) {
            logger.log(Level.SEVERE, "Error saving users", e);

            // Attempt to restore from backup if save failed
            try {
                if (Files.exists(Paths.get(BACKUP_FILE))) {
                    Files.copy(Paths.get(BACKUP_FILE), Paths.get(DATA_FILE),
                            StandardCopyOption.REPLACE_EXISTING);
                    logger.info("Restored data from backup after failed save");
                }
            } catch (IOException ex) {
                logger.log(Level.SEVERE, "Failed to restore from backup", ex);
            }

            return false;
        } finally {
            lock.writeLock().unlock();
        }
    }

    public static List<User> loadUsers() {
        lock.readLock().lock();
        try {
            File file = new File(DATA_FILE);
            if (!file.exists()) {
                logger.info("No data file found, starting with empty user list");
                return new ArrayList<>();
            }

            List<User> users = objectMapper.readValue(
                    file,
                    objectMapper.getTypeFactory().constructCollectionType(List.class, User.class)
            );
            logger.info("Loaded " + users.size() + " users from " + DATA_FILE);
            return users;
        } catch (IOException e) {
            logger.log(Level.SEVERE, "Error loading users", e);

            // Attempt to load from backup if main file is corrupted
            try {
                File backupFile = new File(BACKUP_FILE);
                if (backupFile.exists()) {
                    List<User> users = objectMapper.readValue(
                            backupFile,
                            objectMapper.getTypeFactory().constructCollectionType(List.class, User.class)
                    );
                    logger.info("Loaded " + users.size() + " users from backup");
                    return users;
                }
            } catch (IOException ex) {
                logger.log(Level.SEVERE, "Error loading from backup", ex);
            }

            return new ArrayList<>();
        } finally {
            lock.readLock().unlock();
        }
    }

    public static boolean exportToReadableFormat(String outputPath) {
        lock.readLock().lock();
        try {
            List<User> users = loadUsers();
            StringBuilder sb = new StringBuilder();
            sb.append("User Data Export\n");
            sb.append("================\n\n");
            sb.append("Total Users: ").append(users.size()).append("\n\n");

            for (User user : users) {
                sb.append("User ID: ").append(user.getEmail()).append("\n");
                sb.append("Name: ").append(user.getName()).append("\n");
                sb.append("Phone: ").append(user.getPhone()).append("\n");
                sb.append("Role: ").append(user.getRole()).append("\n");

                if (user instanceof Tutor) {
                    Tutor tutor = (Tutor) user;
                    sb.append("Primary Subject: ").append(tutor.getPrimarySubject()).append("\n");
                    sb.append("Hourly Rate: ").append(tutor.getHourlyRate()).append("\n");
                    sb.append("Qualifications: ").append(tutor.getQualification()).append("\n");
                }

                sb.append("\n");
            }

            Files.write(Paths.get(outputPath), sb.toString().getBytes());
            logger.info("Exported user data to " + outputPath);
            return true;
        } catch (IOException e) {
            logger.log(Level.SEVERE, "Error exporting user data", e);
            return false;
        } finally {
            lock.readLock().unlock();
        }
    }
}