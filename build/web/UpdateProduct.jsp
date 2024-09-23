<%-- 
    Document   : UpdateProduct
    Created on : Jun 29, 2024, 2:40:16 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <title>UPDATE PRODUCT</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <style>
        body, html {
            height: 100%;
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }

        body {
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            position: relative;
            min-height: 100vh;
        }

        section {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            width: 100%;
            max-width: 1200px;
            background-color: #e9ecef;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            width: 100%;
            max-width: 1200px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .form-inline {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .form-inline input[type="text"] {
            flex: 1;
            margin-right: 10px;
        }

        .table-wrapper {
            height: 400px; /* Adjust this value as needed */
            overflow-y: auto;
            margin-bottom: 20px;
            border: solid 1px;
            border-radius: 5px;
        }

        table {
            width: 100%;
            margin: 0;
            font-size: 16px;
            text-align: left;
            background-color: #fff;
            border-radius: 5px;
            overflow: hidden;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-collapse: collapse;
            border: 1px solid black;
            position: relative;
        }

        th, td {
            padding: 12px;
            border-bottom: 1px solid #dee2e6;
            text-align: center;
        }

        thead th {
            background-color: #007bff;
            color: #fff;
            text-transform: uppercase;
            position: sticky;
            top: 0;
            z-index: 1;
        }

        tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tbody tr:hover {
            background-color: #f1f1f1;
        }

        td img {
            width: 100px;
            height: auto;
            border-radius: 5px;
        }

        input[type="text"], input[type="number"], select {
            width: 100%;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 3px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #28a745;
            color: white;
            padding: 8px 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #218838;
        }

        a {
            color: #dc3545;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        .btn-add {
            background-color: #007bff;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
            display: inline-block;
            text-decoration: none;
            text-align: center;
        }

        .btn-add:hover {
            background-color: #0056b3;
            text-decoration: none;
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
<section>
    <div class="container">
        <form action="MainController" method="POST" class="form-inline mb-3">
            <input class="form-control me-2" type="text" name="txtSearchValue" placeholder="Search product or category" value="${param.txtSearchValue}"/>
            <input class="btn btn-primary" type="submit" name="btAction" value="Search Product"/>
        </form>

        <c:set var="productList" value="${empty param.txtSearchValue ? sessionScope.PRODUCTS1 : requestScope.SEARCHED_PRODUCTS}"/>
        <c:if test="${not empty productList}">
            <div class="table-wrapper">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>Id</th>
                        <th>IMG</th>
                        <th>Product Name</th>
                        <th>Company</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Delete</th>
                        <th>Update</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="product" items="${productList}" varStatus="i">
                        <form action="MainController" method="POST">
                            <tr>
                                <td>${product.productID}<input type="hidden" name="txtProductId" value="${product.productID}"/> </td>
                                <td><img src="./images/${product.productIMG}" alt="Product Image"></td>
                                <td><input type="text" name="txtProductName" value="${product.productName}" /></td>
                                <td>
                                    <select name="txtCompany" class="form-select">
                                        <option value="${product.company}">${product.company}</option>
                                        <option value="Nike">Nike</option>
                                        <option value="Onitsuka">Onitsuka</option>
                                        <option value="Adidas">Adidas</option>
                                        <option value="Vans">Vans</option>
                                        <option value="New Balance">New Balance</option>
                                        <option value="MLB">MLB</option>
                                        <option value="Converse">Converse</option>
                                    </select>
                                </td>
                                <td><input type="text" name="txtPrice" value="${product.price}" /></td>
                                <td><input type="number" name="txtQuantity" value="${product.quantity}" /></td>
                                <td>
                                    <a href="MainController?btAction=Delete&txtDeleteValue=${product.productID}&txtLastSearchValue=${param.txtSearchValue}" class="btn btn-danger">Delete</a>
                                </td>
                                <td>
                                    <input type="hidden" name="txtLastSearchValue" value="${param.txtSearchValue}"/>
                                    <input type="submit" name="btAction" value="Update Product" class="btn btn-success"/>
                                </td>
                            </tr>
                        </form>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
        <a href="AddProduct.jsp" class="btn-add">Add New Product</a>
    </div>
</section>
<a href="Menu.jsp" class="pt-5 back-to-shop"><i class='bx bx-chevrons-left'></i>Back to shop</a>
</body>
</html>
