document.addEventListener('DOMContentLoaded', function() {
    // User type selection functionality
    function selectUserType(type) {
        const studentOption = document.getElementById('studentOption');
        const tutorOption = document.getElementById('tutorOption');
        const tutorFields = document.getElementById('tutorFields');

        studentOption.classList.remove('selected');
        tutorOption.classList.remove('selected');
        tutorFields.style.display = 'none';

        if (type === 'student') {
            studentOption.classList.add('selected');
            document.querySelector('input[name="userType"][value="student"]').checked = true;
        } else {
            tutorOption.classList.add('selected');
            document.querySelector('input[name="userType"][value="tutor"]').checked = true;
            tutorFields.style.display = 'block';
        }
    }

    // Initialize with student selected
    selectUserType('student');

    // Set up event listeners for user type selection
    document.getElementById('studentOption').addEventListener('click', () => selectUserType('student'));
    document.getElementById('tutorOption').addEventListener('click', () => selectUserType('tutor'));

    // Display error message from URL if exists
    const urlParams = new URLSearchParams(window.location.search);
    const error = urlParams.get('error');
    if (error) {
        const errorMessage = document.getElementById('errorMessage');
        errorMessage.textContent = error;
        errorMessage.style.display = 'block';
    }

    // Enhanced form validation for registration
    const registerForm = document.getElementById('registerForm');
    if (registerForm) {
        registerForm.addEventListener('submit', function(e) {
            let isValid = true;

            // Reset errors
            document.querySelectorAll('.error-message').forEach(el => el.textContent = '');

            // Validate first name
            const firstName = document.getElementById('firstName').value.trim();
            if (!firstName) {
                document.getElementById('firstNameError').textContent = 'First name is required';
                isValid = false;
            }

            // Validate last name
            const lastName = document.getElementById('lastName').value.trim();
            if (!lastName) {
                document.getElementById('lastNameError').textContent = 'Last name is required';
                isValid = false;
            }

            // Validate email
            const email = document.getElementById('email').value.trim();
            if (!email) {
                document.getElementById('emailError').textContent = 'Email is required';
                isValid = false;
            } else if (!/^[^\s@]+@([^\s@]+\.)+[^\s@]+$/.test(email)) {
                document.getElementById('emailError').textContent = 'Invalid email format';
                isValid = false;
            }

            // Validate phone
            const phone = document.getElementById('phone').value.trim();
            if (!phone) {
                document.getElementById('phoneError').textContent = 'Phone number is required';
                isValid = false;
            } else if (!/^[0-9]{10,15}$/.test(phone)) {
                document.getElementById('phoneError').textContent = 'Phone must be 10-15 digits';
                isValid = false;
            }

            // Validate password
            const password = document.getElementById('password').value;
            if (!password) {
                document.getElementById('passwordError').textContent = 'Password is required';
                isValid = false;
            } else if (password.length < 8) {
                document.getElementById('passwordError').textContent = 'Password must be at least 8 characters';
                isValid = false;
            }

            // Validate password confirmation
            const confirmPassword = document.getElementById('confirmPassword').value;
            if (!confirmPassword) {
                document.getElementById('confirmPasswordError').textContent = 'Please confirm your password';
                isValid = false;
            } else if (password !== confirmPassword) {
                document.getElementById('confirmPasswordError').textContent = 'Passwords do not match';
                isValid = false;
            }

            // Validate tutor-specific fields if tutor is selected
            if (document.querySelector('input[name="userType"]:checked').value === 'tutor') {
                const primarySubject = document.getElementById('primarySubject').value.trim();
                if (!primarySubject) {
                    alert('Primary subject is required for tutors');
                    isValid = false;
                }
            }

            // Validate terms checkbox
            if (!document.getElementById('terms').checked) {
                alert('You must accept the Terms & Conditions');
                isValid = false;
            }

            if (!isValid) {
                e.preventDefault();
            } else {
                // Auto-generate username from email (before domain)
                const username = email.split('@')[0];
                const hiddenUsernameField = document.createElement('input');
                hiddenUsernameField.type = 'hidden';
                hiddenUsernameField.name = 'username';
                hiddenUsernameField.value = username;
                this.appendChild(hiddenUsernameField);
            }
        });
    }

    // Mobile menu toggle (if you have one in your layout)
    const navbarToggle = document.querySelector('.navbar-toggle');
    const navbarLinks = document.querySelector('.navbar-links');

    if (navbarToggle && navbarLinks) {
        navbarToggle.addEventListener('click', function() {
            navbarLinks.classList.toggle('active');
        });
    }

    // Close dropdown when clicking outside (if you have dropdowns)
    document.addEventListener('click', function(event) {
        const dropdowns = document.querySelectorAll('.dropdown');
        dropdowns.forEach(dropdown => {
            if (!dropdown.contains(event.target)) {
                const content = dropdown.querySelector('.dropdown-content');
                if (content) content.classList.remove('show');
            }
        });
    });
});