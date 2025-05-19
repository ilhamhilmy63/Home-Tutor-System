<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Tutor Profile</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="mb-4">Edit Tutor Profile</h2>

    <form action="${pageContext.request.contextPath}/editTutor" method="post">
    <div class="mb-3">
            <label for="name" class="form-label">Full Name</label>
            <input type="text" class="form-control" id="name" name="name" value="John Deo">
        </div>
        <div class="mb-3">
            <label for="subjects" class="form-label">Subjects</label>
            <input type="text" class="form-control" id="subjects" name="subjects" value="Math, Physics">
        </div>
        <div class="mb-3">
            <label for="location" class="form-label">Location</label>
            <input type="text" class="form-control" id="location" name="location" value="New York">
        </div>
        <div class="mb-3">
            <label for="bio" class="form-label">Bio</label>
            <textarea class="form-control" id="bio" name="bio" rows="3">Experienced tutor with a passion for teaching.</textarea>
        </div>

        <!-- Availability Inputs -->
        <div class="mb-3">
            <label class="form-label">Availability</label>

            <!-- Slot 1 -->
            <div class="row mb-2">
                <div class="col-md-4">
                    <label for="day0">Day</label>
                    <select class="form-select" id="day0" name="day0">
                        <option>None</option>
                        <option>Monday</option>
                        <option>Tuesday</option>
                        <option>Wednesday</option>
                        <option selected>Thursday</option>
                        <option>Friday</option>
                        <option>Saturday</option>
                        <option>Sunday</option>
                    </select>
                </div>
                <div class="col-md-8">
                    <label for="time0">Time</label>
                    <input type="text" class="form-control" id="time0" name="time0" value="2:00 PM – 5:00 PM">
                </div>
            </div>

            <!-- Slot 2 -->
            <div class="row mb-2">
                <div class="col-md-4">
                    <label for="day1">Day</label>
                    <select class="form-select" id="day1" name="day1">
                        <option>None</option>
                        <option>Monday</option>
                        <option selected>Tuesday</option>
                        <option>Wednesday</option>
                        <option>Thursday</option>
                        <option>Friday</option>
                        <option>Saturday</option>
                        <option>Sunday</option>
                    </select>
                </div>
                <div class="col-md-8">
                    <label for="time1">Time</label>
                    <input type="text" class="form-control" id="time1" name="time1" value="10:00 AM – 1:00 PM">
                </div>
            </div>

            <!-- Slot 3 -->
            <div class="row mb-2">
                <div class="col-md-4">
                    <label for="day2">Day</label>
                    <select class="form-select" id="day2" name="day2">
                        <option>None</option>
                        <option>Monday</option>
                        <option>Tuesday</option>
                        <option>Wednesday</option>
                        <option>Thursday</option>
                        <option>Friday</option>
                        <option selected>Saturday</option>
                        <option>Sunday</option>
                    </select>
                </div>
                <div class="col-md-8">
                    <label for="time2">Time</label>
                    <input type="text" class="form-control" id="time2" name="time2" value="4:00 PM – 6:00 PM">
                </div>
            </div>
        </div>

        <button type="submit" class="btn btn-primary mt-3">Update Profile</button>
    </form>
</div>
</body>
</html>
