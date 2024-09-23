<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Login</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <style>
            * {
                box-sizing: border-box;
            }
            body {
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                background: url(./images/background.jpg) no-repeat;
                background-size: cover;
                background-position: center;
            }
            .wrapper {
                background-color: transparent; 
                width: 400px;
                padding: 35px;
                backdrop-filter: blur(15px); 
                border-radius: 10px;
                border: 2px solid rgba(255, 255, 255, .2);
                box-shadow: 0 0 10px rgba(0, 0, 0, .2);
                color: #fff;
                font-family: Montserrat;
            }
            .wrapper h1 {
                display: flex;
                justify-content: center;
            }
            .input-box {
                width: 100%;
                height: 40px;
                margin: 15px 0;
                position: relative;
            }
            .input-box input {
                width: 100%;
                height: 100%;
                outline: none;
                background-color: transparent;
                padding: 0 45px 0 15px; /* Add left padding for the icon */
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
                text-decoration: underline;
                color: #4CAF50;
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
            .google-link {
                display: flex;
                justify-content: center;
                margin: 15px 0;
            }
            .google-button {
                display: inline-block;
                width: 100%;
                max-width: 220px;
                padding: 10px 0px;
                font-size: 13px;
                font-weight: 130;
                color: #333;
                background-color: white;
                text-align: center;
                text-decoration: none;
                border-radius: 50px;
                border: 2px solid rgba(255, 255, 255, .2);
                box-shadow: 0 0 10px rgba(0, 0, 0, .1);
                transition: all 0.3s ease;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .google-button:hover {
                background-color: #4CAF50; /* Google blue color */
                color: white;
                box-shadow: 0 0 15px rgba(66, 133, 244, .5);
                transform: scale(1.05);
            }
            .google-button:hover a {
                transition: all 0.3s ease;
                color: white;
            }
            .google-button:active {
                border: 0.5px solid black;
                outline: activeborder;
            }
            .google-link i {
                margin-left: 10px;
            }
            .google-link a {
                text-decoration: none;
                color: black;
                font-weight: bold;
            }

        </style>
    </head>
    <body>
        <div class="wrapper">
            <form action="MainController" method="POST" id="form">
                <h1>LOGIN</h1>
                <div class="input-box">
                    <input type="text" name="txtUserName"  placeholder="User name" required/>
                    <i class='bx bxs-user'></i>   
                </div>
                <div class="input-box">
                    <input type="password" name="txtPassword"  placeholder="Password" required/>
                    <i class='bx bxs-lock-alt'></i>
                </div>
<!--                <div class="g-recaptcha" data-sitekey="6LfGXQIqAAAAAE_RYX8zjveAk3y_foJiu6gJME6d"></div>-->
                <div id="error"></div>
                <div class="register-link">
                    <span>Do not have an account?</span>
                    <a href="signup.jsp">Register</a>
                </div>
                <div class="btn">
                    <input type="submit" name="btAction" value="Login"/>
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
