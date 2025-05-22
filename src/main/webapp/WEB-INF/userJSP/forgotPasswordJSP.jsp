<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Forgot Password</title>
  <link href="https://fonts.googleapis.com/css2?family=Lora:wght@600;700&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
  <style>
    /* General Reset */
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    /* Body */
    body {
      font-family: 'Open Sans', sans-serif;
      background-color: #ECE2D0;
      color: #4A2C2A;
      line-height: 1.6;
    }

    /* Main Content */
    main {
      max-width: 400px;
      margin: 2rem auto;
      padding: 2rem;
      background-color: #D9C2A7;
      border-radius: 8px;
    }

    h2 {
      font-family: 'Lora', serif;
      font-size: 1.5rem;
      font-weight: 700;
      color: #4A2C2A;
      margin-bottom: 1rem;
      text-align: center;
    }

    p {
      font-size: 1rem;
      color: #4A2C2A;
      margin-bottom: 1rem;
    }

    form {
      display: flex;
      flex-direction: column;
      gap: 1rem;
    }

    input[type="email"], input[type="password"] {
      padding: 0.5rem;
      border: 1px solid #4A2C2A;
      border-radius: 4px;
      font-size: 1rem;
    }

    input[type="submit"] {
      background-color: #4A2C2A;
      color: #F7C8A5;
      padding: 0.75rem;
      border: none;
      border-radius: 6px;
      font-size: 1rem;
      font-weight: 600;
      cursor: pointer;
      transition: background-color 0.2s;
    }

    input[type="submit"]:hover {
      background-color: #5D3A38;
    }

    a {
      color: #F4A261;
      text-decoration: none;
      font-weight: 600;
    }

    a:hover {
      color: #D77A61;
    }

    /* Responsive */
    @media (max-width: 480px) {
      main {
        margin: 1rem;
        padding: 1rem;
      }

      h2 {
        font-size: 1.25rem;
      }
    }
  </style>
</head>
<body>
<main>
  <h2>Forgot Password</h2>

  <% if (request.getAttribute("message") != null) { %>
  <p><%= request.getAttribute("message") %></p>
  <% } %>
  <% if (request.getAttribute("error") != null) { %>
  <p style="color: #D77A61;"><%= request.getAttribute("error") %></p>
  <% } %>

  <form action="forgot-password" method="post">
    Email: <input type="email" name="email" required><br><br>
    New Password: <input type="password" name="newPassword" required><br><br>
    <input type="submit" value="Reset Password">
  </form>

  <p><a href="login">Back to Login</a></p>
</main>
</body>
</html>