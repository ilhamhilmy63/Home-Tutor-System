<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, javax.mail.*, javax.mail.internet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Form Submission - HomeTutor.lk</title>
    <style>
        :root {
            --primary-blue: #1a73e8;
            --light-blue: #e8f0fe;
            --dark-blue: #0d47a1;
            --white: #ffffff;
            --light-gray: #f5f5f5;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: var(--light-gray);
            color: #333;
            line-height: 1.6;
        }

        .container {
            max-width: 800px;
            margin: 50px auto;
            padding: 30px;
            background-color: var(--white);
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .success-message {
            text-align: center;
            padding: 30px;
        }

        .success-icon {
            font-size: 60px;
            color: #4CAF50;
            margin-bottom: 20px;
        }

        .success-message h2 {
            color: var(--primary-blue);
            margin-bottom: 15px;
        }

        .success-message p {
            margin-bottom: 25px;
            font-size: 18px;
        }

        .btn {
            display: inline-block;
            background-color: var(--primary-blue);
            color: var(--white);
            padding: 12px 25px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 500;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: var(--dark-blue);
        }

        .error-message {
            text-align: center;
            padding: 30px;
        }

        .error-icon {
            font-size: 60px;
            color: #f44336;
            margin-bottom: 20px;
        }

        .error-message h2 {
            color: #f44336;
            margin-bottom: 15px;
        }

        .submission-details {
            margin-top: 30px;
            padding: 20px;
            background-color: var(--light-gray);
            border-radius: 5px;
        }

        .submission-details h3 {
            margin-bottom: 15px;
            color: var(--primary-blue);
        }

        .detail-row {
            display: flex;
            margin-bottom: 10px;
        }

        .detail-label {
            font-weight: 500;
            width: 150px;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
<%
    // Set character encoding
    request.setCharacterEncoding("UTF-8");

    // Get form parameters
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String subject = request.getParameter("subject");
    String message = request.getParameter("message");

    // Server-side validation
    boolean isValid = true;
    String errorMessage = "";

    if (name == null || name.trim().isEmpty()) {
        isValid = false;
        errorMessage = "Name is required";
    } else if (email == null || email.trim().isEmpty() || !email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
        isValid = false;
        errorMessage = "Valid email is required";
    } else if (message == null || message.trim().isEmpty()) {
        isValid = false;
        errorMessage = "Message is required";
    }

    if (isValid) {
        try {
            // Save to database (you would replace this with your actual database code)
            // Class.forName("com.mysql.jdbc.Driver");
            // Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/yourdb","username","password");
            // PreparedStatement ps = con.prepareStatement("INSERT INTO contacts(name,email,phone,subject,message) VALUES(?,?,?,?,?)");
            // ps.setString(1, name);
            // ps.setString(2, email);
            // ps.setString(3, phone);
            // ps.setString(4, subject);
            // ps.setString(5, message);
            // ps.executeUpdate();
            // con.close();

            // Send email notification (configure your SMTP settings)
            final String username = "your-email@example.com";
            final String password = "your-email-password";

            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", "smtp.example.com");
            props.put("mail.smtp.port", "587");

            Session mailSession = Session.getInstance(props,
                    new javax.mail.Authenticator() {
                        protected PasswordAuthentication getPasswordAuthentication() {
                            return new PasswordAuthentication(username, password);
                        }
                    });

            try {
                Message mailMessage = new MimeMessage(mailSession);
                mailMessage.setFrom(new InternetAddress(username));
                mailMessage.setRecipients(Message.RecipientType.TO, InternetAddress.parse("admin@hometutor.lk"));
                mailMessage.setSubject("New Contact Form Submission: " + subject);

                String emailContent = "You have received a new contact form submission:\n\n" +
                        "Name: " + name + "\n" +
                        "Email: " + email + "\n" +
                        "Phone: " + phone + "\n" +
                        "Subject: " + subject + "\n\n" +
                        "Message:\n" + message;

                mailMessage.setText(emailContent);

                Transport.send(mailMessage);

                // Send confirmation email to user
                Message userMail = new MimeMessage(mailSession);
                userMail.setFrom(new InternetAddress(username));
                userMail.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
                userMail.setSubject("Thank you for contacting HomeTutor.lk");

                String userContent = "Dear " + name + ",\n\n" +
                        "Thank you for contacting HomeTutor.lk. We have received your message and our team will get back to you within 24-48 hours.\n\n" +
                        "Here's a copy of your submission:\n\n" +
                        "Subject: " + subject + "\n" +
                        "Message: " + message + "\n\n" +
                        "If you have any urgent inquiries, please call our hotline at +94 77 123 4567.\n\n" +
                        "Best regards,\n" +
                        "The HomeTutor.lk Team";

                userMail.setText(userContent);
                Transport.send(userMail);
            } catch (MessagingException e) {
                // Email sending failed, but we'll still show success to user
                System.err.println("Email sending failed: " + e.getMessage());
            }
%>
<div class="container">
    <div class="success-message">
        <div class="success-icon">
            <i class="fas fa-check-circle"></i>
        </div>
        <h2>Thank You for Contacting Us!</h2>
        <p>We have received your message and will get back to you within 24-48 hours.</p>
        <a href="index.jsp" class="btn">Return to Home</a>

        <div class="submission-details">
            <h3>Your Submission Details</h3>
            <div class="detail-row">
                <div class="detail-label">Name:</div>
                <div><%= name %></div>
            </div>
            <div class="detail-row">
                <div class="detail-label">Email:</div>
                <div><%= email %></div>
            </div>
            <div class="detail-row">
                <div class="detail-label">Phone:</div>
                <div><%= (phone != null && !phone.isEmpty()) ? phone : "Not provided" %></div>
            </div>
            <div class="detail-row">
                <div class="detail-label">Subject:</div>
                <div><%= subject %></div>
            </div>
            <div class="detail-row">
                <div class="detail-label">Message:</div>
                <div><%= message %></div>
            </div>
        </div>
    </div>
</div>
<%
} catch (Exception e) {
    errorMessage = "An error occurred while processing your request. Please try again later.";
%>
<div class="container">
    <div class="error-message">
        <div class="error-icon">
            <i class="fas fa-exclamation-circle"></i>
        </div>
        <h2>Submission Failed</h2>
        <p><%= errorMessage %></p>
        <p>Error details: <%= e.getMessage() %></p>
        <a href="contact.jsp" class="btn">Back to Contact Form</a>
    </div>
</div>
<%
    }
} else {
%>
<div class="container">
    <div class="error-message">
        <div class="error-icon">
            <i class="fas fa-exclamation-circle"></i>
        </div>
        <h2>Submission Failed</h2>
        <p><%= errorMessage %></p>
        <a href="contact.jsp" class="btn">Back to Contact Form</a>
    </div>
</div>
<%
    }
%>
</body>
</html>