<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Product</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <style>
            body {
                font-family: 'Roboto', sans-serif;
                font-size: 14px;
                color: #333;
            }
            .container {
                max-width: 600px;
                margin: 50px auto;
                padding: 20px;
                background-color: rgba(255, 255, 255, 0.8);
                border-radius: 8px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
            }
            .card {
                border: none;
                border-radius: 8px;
                transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
                overflow: hidden;
            }
            .card:hover {
                transform: translateY(-10px);
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
            }
            .card-header {
                background-color: #007bff;
                color: #fff;
                padding: 15px;
                text-align: center;
            }
            .card-title {
                font-size: 24px;
                margin: 0;
            }
            .card-body {
                padding: 20px;
            }
            .form-group {
                margin-bottom: 20px;
            }
            .form-control {
                width: 100%;
                border-radius: 4px;
                border: 1px solid #ccc;
                padding: 10px;
                transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
            }
            .form-control:focus {
                border-color: #007bff;
                outline: 0;
                box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
            }
            .btn-container {
                display: flex;
                justify-content: space-between;
                margin-top: 20px;
            }
            .btn-container input[type="submit"],
            .btn-container input[type="reset"] {
                flex: 1;
                height: 40px;
                border-radius: 20px;
                border: none;
                box-shadow: 0 0 10px rgba(0, 0, 0, .1);
                cursor: pointer;
                background-color: #007bff;
                color: white;
                font-weight: 600;
                transition: all 0.3s ease;
                max-width: 45%;
            }
            .btn-container input[type="submit"]:hover,
            .btn-container input[type="reset"]:hover {
                background-color: #0056b3;
                box-shadow: 0 0 15px rgba(0, 123, 255, 0.5);
                transform: scale(1.05);
            }
            .btn-container input:active {
                border: 0.5px solid black;
                outline: activeborder;
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
        <div class="container">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Add Product</h3>
                </div>
                <div class="card-body">
                    <form action="MainController" method="POST">
                        <div class="form-group">
                            <label for="txtProductName">Product Name:</label>
                            <input type="text" class="form-control" id="txtProductName" name="txtProductName" placeholder="Enter Product Name"/>
                        </div>
                        <div class="form-group">
                            <label for="txtProductIMG">Image Source:</label>
                            <input type="text" class="form-control" id="txtProductIMG" name="txtProductIMG" placeholder="Enter IMG Source"/>
                        </div>
                        <div class="form-group">
                            <label for="txtCompany">Company:</label>
                            <select class="form-control" id="txtCompany" name="txtCompany">
                                <option value="Nike">Nike</option>
                                <option value="Onitsuka">Onitsuka</option>
                                <option value="Adidas">Adidas</option>
                                <option value="Vans">Vans</option>
                                <option value="New Balance">New Balance</option>
                                <option value="MLB">MLB</option>
                                <option value="Converse">Converse</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="txtPrice">Price:</label>
                            <input type="text" class="form-control" id="txtPrice" name="txtPrice" placeholder="Enter Price"/>
                        </div>
                        <div class="form-group">
                            <label for="txtQuantity">Quantity:</label>
                            <input type="number" class="form-control" id="txtQuantity" name="txtQuantity" placeholder="Enter Quantity"/>
                        </div>
                        <div class="btn-container">
                            <input type="submit" name="btAction" value="Add Product"/>
                            <input type="reset" value="Reset"/>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <a href="Menu.jsp" class="pt-5 back-to-shop"><i class='bx bx-chevrons-left'></i>Back to shop</a>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
        <script type="text/javascript">
            window.onload = function () {
                var showMessage = "<%= request.getAttribute("showMessage")%>";
                if (showMessage !== null && showMessage === "true") {
                    var message = "<%= request.getAttribute("message")%>";
                    if (message !== null && message !== "") {
                        alert(message);
                    }
                }
            };
        </script>
    </body>
</html>
