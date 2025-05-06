document.addEventListener('DOMContentLoaded', function() {
    // Mobile menu toggle
    const navbarToggle = document.querySelector('.navbar-toggle');
    const navbarLinks = document.querySelector('.navbar-links');

    if (navbarToggle && navbarLinks) {
        navbarToggle.addEventListener('click', function() {
            navbarLinks.classList.toggle('active');
        });
    }

    // Close dropdown when clicking outside
    document.addEventListener('click', function(event) {
        const dropdowns = document.querySelectorAll('.dropdown');
        dropdowns.forEach(dropdown => {
            if (!dropdown.contains(event.target)) {
                const content = dropdown.querySelector('.dropdown-content');
                if (content) content.classList.remove('show');
            }
        });
    });

    // Form validation for password match
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        if (form.querySelector('#newPassword') && form.querySelector('#confirmPassword')) {
            form.addEventListener('submit', function(e) {
                const newPassword = form.querySelector('#newPassword').value;
                const confirmPassword = form.querySelector('#confirmPassword').value;

                if (newPassword !== confirmPassword) {
                    e.preventDefault();
                    alert('Passwords do not match!');
                }
            });
        }
    });
});