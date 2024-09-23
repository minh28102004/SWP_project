<%@page import="Page.registration.RegistrationDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Page.error_report.RegisterError"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <style>
            body {
                font-family: 'Roboto', sans-serif;
                background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }
            .wrapper {
                background: #fff;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                max-width: 400px;
                width: 100%;
                transition: transform 0.3s ease-in-out;
            }
            .wrapper:hover {
                transform: translateY(-5px);
            }
            h1 {
                text-align: center;
                margin-bottom: 25px;
                color: #333;
                font-size: 24px;
            }
            .form-control {
                padding: 12px 15px;
                border-radius: 6px;
                transition: all 0.3s ease;
            }
            .form-control:focus {
                border-color: #007bff;
                box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
                outline: none;
            }
            .input-icon {
                position: absolute;
                right: 15px;
                top: 50%;
                transform: translateY(-50%);
                color: #bbb;
                transition: color 0.3s ease;
            }
            .form-control:focus + .input-icon {
                color: #007bff;
            }
            .error-message {
                display: block;
                margin-top: -10px;
                margin-bottom: 10px;
                font-size: 0.9em;
                color: red;
            }
            .btn-custom {
                width: 48%;
                padding: 12px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-size: 14px;
                transition: background 0.3s ease;
            }
            .btn-update {
                background: #28a745;
                color: #fff;
            }
            .btn-update:hover {
                background: #218838;
            }
            .btn-reset {
                background: #dc3545;
                color: #fff;
            }
            .btn-reset:hover {
                background: #c82333;
            }
            .sex-container {
                margin-bottom: 20px;
            }
            .sex-container label {
                display: block;
                margin-bottom: 5px;
                color: #333;
            }
            .pt-5 {
                position: absolute;
                bottom: 20px;
                left: 20px;
                text-decoration: none;
                color: black;
                transition: color 0.2s, transform 0.2s ease;
            }

            .pt-5:hover {
                color: #3498db;
                transform: translateX(-3px); /* Hiệu ứng dịch chuyển */
                text-decoration: none;
            }

            .pt-5 i {
                margin-right: 5px;
            }
        </style>
    </head>
    <body>
        <div class="wrapper">
            <h1>UPDATE PROFILE</h1>
            <%
                RegisterError error = (RegisterError) request.getAttribute("ERRORS");
                String confirmNotMatch = "";
                String accountExist = "";
                if (error != null) {
                    confirmNotMatch = error.getConfirmNotMatch();
                    accountExist = error.getAccountExist();
                }
                RegistrationDTO user = (RegistrationDTO) session.getAttribute("USER");
            %>
            <form action="MainController" method="POST">
                <div class="mb-3 position-relative">
                    <input type="hidden" name="txtUserName" value="<%=user.getUserName()%>" required />
                    <input type="text" class="form-control" value="<%=user.getUserName()%>" disabled />
                    <i class='bx bxs-user input-icon'></i>
                </div>
                <div class="mb-3 position-relative">
                    <input type="text" class="form-control" name="txtFullName" placeholder="Full name (2 - 40 chars)" minlength="2" maxlength="40" value="<%=user.getFullName()%>" required/>
                    <i class='bx bxl-meta input-icon'></i>
                </div>
                <div class="mb-3 position-relative">
                    <input type="email" class="form-control" name="txtEmail" placeholder="Email" pattern=".+@gmail.com" value="<%=user.getEmail()%>" required/>
                    <i class='bx bxs-envelope input-icon'></i>
                </div>
                <div class="mb-3 position-relative">
                    <input type="text" class="form-control" name="txtAddress" placeholder="Address" value="<%=user.getAddress()%>" required/>
                    <i class='bx bxs-home input-icon'></i>
                </div>
                <div class="mb-3 position-relative">
                    <input type="tel" class="form-control" name="txtPhoneNumber" placeholder="Phone number (0*********)" pattern="[0]{1}[0-9]{9}" value="<%=user.getPhoneNumber()%>" required/>
                    <i class='bx bxs-phone input-icon'></i>
                </div>
                <% if (accountExist.length() > 0) {%>
                <span class="error-message"><%= accountExist%></span>
                <% }%>
                <div class="mb-3 position-relative">
                    <input type="password" class="form-control" name="txtPassword" value="<%=user.getPassword()%>" placeholder="Password*(4 - 20 chars)" minlength="4" maxlength="20" required/>
                    <i class='bx bxs-lock-alt input-icon'></i>
                </div>
                <div class="mb-3 position-relative">
                    <input type="password" class="form-control" name="txtConfirm" value="<%=user.getPassword()%>" placeholder="Confirm password" required/>
                    <i class='bx bxs-lock-alt input-icon'></i>
                </div>
                <% if (confirmNotMatch.length() > 0) {%>
                <span class="error-message"><%= confirmNotMatch%></span>
                <% }%>
                <div class="sex-container">
                    <label>Sex :</label>
                    <select name="txtSex" class="form-control"> 
                        <option value="M" <%= user.getSex().equals("M") ? "selected" : ""%>>Male</option>
                        <option value="F" <%= user.getSex().equals("F") ? "selected" : ""%>>Female</option>
                    </select>
                </div>
                <div class="d-flex justify-content-between">
                    <input type="submit" name="btAction" class="btn btn-custom btn-update" value="Update" />
                    <input type="reset" class="btn btn-custom btn-reset" value="Reset" />
                </div>
            </form>
        </div>                 
                <a href="Menu.jsp" class="pt-5 back-to-shop"><i class='bx bx-chevrons-left'></i>Back to shop</a>        
    </body>
</html>
