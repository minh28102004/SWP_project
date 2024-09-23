<%-- 
    Document   : signup
    Created on : Jun 12, 2024, 1:47:55 PM
    Author     : HP
--%>

<%@page import="Page.error_report.RegisterError"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>SIGN UP</title>
        <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet"/>
        <style>
            * {
                box-sizing: border-box;
                padding: 0;
                margin: 0;
            }
            body {
                overflow-x: hidden;
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                background-image: url(./images/background.jpg); 
                background-repeat: no-repeat;
                background-size: cover;
                background-position: center;
                font-family: Montserrat;
            }
            h1 {
                color: white;
                text-align: center;
                margin-bottom: 20px;
            }
            .wrapper {
                background-color: transparent; 
                width: 400px;
                padding: 35px;
                backdrop-filter: blur(100px); 
                border-radius: 10px;
                border: 2px solid rgba(255, 255, 255, .2);
                box-shadow: 0 0 10px rgba(0, 0, 0, .2);
                color: #fff;
            }
            .input-box {
                position: relative;
                width: 100%;
                height: 40px;
                margin: 15px 0;
            }
            .input-box input {
                width: 100%;
                height: 100%;
                outline: none;
                background-color: transparent;
                padding: 0 40px 0 15px; /* Adjusted padding for the icon */
                font-size: 16px;
                border-radius: 50px;
                border: 2px solid rgba(255, 255, 255, .2);
                color: white;
            }
            .input-box select {
                width: 100%; /* Adjusted width for input and select */
                height: 100%;
                outline: none;
                background-color: transparent;
                padding: 0 15px;
                font-size: 16px;
                border-radius: 50px;
                border: 2px solid rgba(255, 255, 255, .2);
                color: white;
            }
            .input-box i {
                position: absolute;
                top: 50%;
                right: 15px;
                transform: translateY(-50%);
                color: white;
                font-size: 20px;
            }
            .input-box input::placeholder {
                color: white;
            }
            .btn {
                height: 40px;
                display: flex;
                justify-content: space-around;
            }
            .btn input {
                width: 150px;
                border-radius: 50px; 
                border: none;
                box-shadow: 0 0 10px rgba(0, 0, 0, .1);
                cursor: pointer;
                color: #333;
                font-weight: 600;
                transition: all 0.3s ease;
            }
            .btn input[type="submit"]:hover,
            .btn input[type="reset"]:hover {
                background-color: #4CAF50; /* Change background color on hover */
                color: white; /* Change text color on hover */
                box-shadow: 0 0 15px rgba(76, 175, 80, .5); /* Increase shadow for effect */
                transform: scale(1.05); /* Slightly enlarge the button */
            }
            .btn input:active {
                border: 0.5px solid black;
                outline: activeborder;
            }
            .register-link {
                text-align: center;
                font-size: 16px;
                margin: 20px 0 15px;
            }
            .register-link a {
                color: #fff;
                text-decoration: none;
                font-weight: 600;
            }
            .register-link a:hover {
                color: #4CAF50;
                text-decoration: underline;
            }
            /* Style for the Sex label and select */
            .sex-container {
                display: flex;
                align-items: center;
                margin-bottom: 15px; /* Adjusted margin for spacing */
            }
            .sex-container label {
                flex: 1;
                color: white;
                font-size: 20px;
                position: relative;
                left: 17px;
                bottom: 2px;
            }
            .sex-container select {
                flex: 3; 
                justify-content: flex-start;
                height: 40px;
                outline: none;
                background-color: transparent;
                padding: 0 20px;
                font-size: 16px;
                border-radius: 50px;
                border: 2px solid rgba(255, 255, 255, .2);
                color: white;
            }
            .sex-container select option {
                color: black;
            }
            /* Style for error messages */
            .error-message {
                color: red;
                font-size: 15px;
                margin-bottom: 1px;
            }
            .g-recaptcha {
                display: flex;
                justify-content: center;
                margin: 15px 0;
            }
            #error {
                color: red;
                text-align: center;
                margin-top: 10px;
            }
        </style>
    </head>
    <body>
        <%
            RegisterError error = (RegisterError) request.getAttribute("ERRORS");
            String confirmNotMatch = "";
            String accountExist = "";
            if (error != null) {
                confirmNotMatch = error.getConfirmNotMatch();
                accountExist = error.getAccountExist();
            }
        %>
        <div class="wrapper">
            <h1>Registration</h1>
            <form action="MainController" method="POST" id="form">
                <div class="input-box">
                    <input type="text" name="txtFullName" placeholder="Full name (2 - 40 chars)" minlength="2" maxlength="40" required/>
                    <i class='bx bxl-meta'></i>
                </div>
                <div class="input-box">
                    <input  type="email" name="txtEmail" placeholder="Email" pattern=".+@gmail.com" required/>
                    <i class='bx bxs-envelope'></i>
                </div>
                <div class="input-box">
                    <input type="text" name="txtAddress" placeholder="Address" required/>
                    <i class='bx bxs-home'></i>
                </div>
                <div class="input-box">
                    <input type="tel" name="txtPhoneNumber" placeholder="Phone number (0*********)" pattern="[0]{1}[0-9]{9}" required/>
                    <i class='bx bxs-phone'></i>
                </div>
                <div class="input-box">
                    <input type="text" name="txtUserName" placeholder="User name (6 - 12 chars)" minlength="6" maxlength="12" required/>
                    <i class='bx bxs-user'></i>                   
                </div>
                <% if (accountExist.length() > 0) {%>
                <span class="error-message" style="color: red"><%= accountExist%></span>
                <% } %>
                <div class="input-box">
                    <input type="password" name="txtPassword" placeholder="Password*(4 - 20 chars)" minlength="4" maxlength="20" required/>
                    <i class='bx bxs-lock-alt'></i>
                </div>
                <div class="input-box">
                    <input type="password" name="txtConfirm" placeholder="Confirm password" required/>
                    <i class='bx bxs-lock-alt'></i>
                </div>
                <% if (confirmNotMatch.length() > 0) {%>
                <span class="error-message" style="color: red"><%= confirmNotMatch%></span>
                <% }%>
                <div class="sex-container">
                    <label>Sex :</label>
                    <select name="txtSex"> 
                        <option value="M" style="color: black">Male</option>
                        <option value="F" style="color: black">Female</option>
                    </select>       
                </div>
                <div class="g-recaptcha" data-sitekey="6LfGXQIqAAAAAE_RYX8zjveAk3y_foJiu6gJME6d"></div>
                <div id="error"></div>
                <div class="register-link">
                    <p>
                        Already have an account?
                        <a href="Login.jsp" class="login-link">Login</a>
                    </p>
                </div>
                <div class="btn">
                    <input type="submit" name="btAction" value="Register"/>
                    <input type="reset" value="Reset"/>
                </div>
            </form>
            <script src="https://www.google.com/recaptcha/api.js" async defer></script>
            <script>
                window.onload = function () {
                    const form = document.getElementById("form");
                    const error = document.getElementById("error");

                    form.addEventListener("submit", function (event) {
                        const response = grecaptcha.getResponse();
                        if (!response) {
                            event.preventDefault();
                            error.innerHTML = "Please complete the reCAPTCHA!";
                        }
                    });
                }
            </script>
        </div>
    </body>
</html>
