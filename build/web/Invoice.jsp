<%-- 
    Document   : Invoice
    Created on : Jul 9, 2024, 1:34:19 AM
    Author     : Nhat Hung
--%>

<%@page import="Page.registration.RegistrationDTO"%>
<%@page import="Page.Product.ProductDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Invoice</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet"/>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <style>
            .container {
                margin-top: 50px;
            }
            .invoice-header {
                text-align: center;
                margin-bottom: 30px;
            }
            .invoice-info, .invoice-products {
                margin-bottom: 20px;
            }
            .table thead th {
                background-color: #f8f9fa;
            }
            .back-to-shop {
                display: block;
                margin-top: 10px;
                margin-left: 5px;
                margin-bottom: 10px;/* Khoảng cách từ cuối danh sách hóa đơn */
                text-decoration: none;
                text-align: left; /* Căn trái */
                color: black;
                transition: color 0.2s, transform 0.2s ease;
            }

            .back-to-shop:hover {
                color: #3498db;
                transform: translateX(-3px); /* Hiệu ứng dịch chuyển */
                text-decoration: none;
            }

            .back-to-shop i {
                margin-right: 5px;
            }
            .receipt {
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.15);
            }
            .billing h4 {
                border-bottom: 2px solid #f8f9fa;
                padding-bottom: 5px;
            }
            .footer {
                background-color: #f8f9fa;
                padding: 10px;
                border-radius: 5px;
            }
            .footer .thanks {
                font-size: 18px;
            }
        </style>
    </head>
    <body>
        <div class="container mt-5 mb-5">
            <div class="d-flex justify-content-center row">
                <div class="col-md-10">
                    <div class="receipt bg-white p-3 rounded">
                        <img src="./images/logo-black.png" width="100" height="100" alt=""/>
                        <%
                            // Lấy thông tin user từ session
                            RegistrationDTO user = (RegistrationDTO) session.getAttribute("USER");
                        %>
                        <h4 class="mt-2 mb-3 text-center">Your order is confirmed!</h4>
                        <h6 class="name text-center">Hello <%= user.getFullName()%>,</h6>
                        <p class="text-center text-black-50">Your order has been confirmed and will be shipped in two days</p>
                        <hr>
                        <div class="d-flex flex-row justify-content-between align-items-center order-details">
                            <div><span class="d-block fs-12">Order date</span><span class="font-weight-bold"><%= request.getAttribute("invoiceDate")%></span></div>
                            <div><span class="d-block fs-12">Order number</span><span class="font-weight-bold"><%= request.getAttribute("invoiceID")%></span></div>
                            <div><span class="d-block fs-12">Payment method</span><span class="font-weight-bold">Credit card</span><img class="ml-1 mb-1" src="https://i.imgur.com/ZZr3Yqj.png" width="20"></div>
                            <div><span class="d-block fs-12">Shipping Address</span><span class="font-weight-bold text-success"><%= user.getAddress()%></span></div>
                        </div>
                        <hr>
                        <div class="card invoice-products">
                            <div class="card-body">
                                <h4 class="text-center">Products</h4>
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Image</th>
                                            <th>Product Name</th>
                                            <th>Company</th>
                                            <th>Price</th>
                                            <th>Quantity</th>
                                            <th>Subtotal</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            List<ProductDTO> products = (List<ProductDTO>) request.getAttribute("PRODUCTS");
                                            if (products != null) {
                                                for (ProductDTO product : products) {
                                        %>
                                        <tr>
                                            <td><img src="<%= "./images/" + product.getProductIMG()%>" width="50" height="50" class="img-fluid"></td>
                                            <td><%= product.getProductName()%></td>
                                            <td><%= product.getCompany()%></td>
                                            <td>$<%= product.getPrice()%></td>
                                            <td><%= product.getQuantity()%></td>
                                            <td>$<%= product.getQuantity() * product.getPrice()%></td>
                                        </tr>
                                        <%
                                            }
                                        } else {
                                        %>
                                        <tr>
                                            <td colspan="6" class="text-center">No products found</td>
                                        </tr>
                                        <% }%>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="mt-5 row">
                            <div class="col-md-6 d-flex justify-content-center">
                                <img src="https://i.imgur.com/AXdWCWr.gif" width="250" height="100" class="img-fluid">
                            </div>
                            <div class="col-md-6">
                                <div class="billing">
                                    <h4>Invoice Information</h4>
                                    <p><strong>Invoice ID:</strong> <%= request.getAttribute("invoiceID")%></p>
                                    <p><strong>Date:</strong> <%= request.getAttribute("invoiceDate")%></p>
                                    <p><strong>Shipping Method:</strong> <%= request.getAttribute("shippingMethod")%></p>
                                    <p><strong>Total Amount:</strong> $<%= request.getAttribute("totalAmount")%></p>
                                </div>
                            </div>
                        </div>
                        <p class="d-block">Expected delivery date</p>
                        <p class="font-weight-bold text-success"><%= request.getAttribute("invoiceDate2")%></p>
                        <p class="d-block mt-3 text-black-50 fs-15">We will be sending a shipping confirmation email when the item is shipped!</p>
                        <hr>
                        <div class="d-flex justify-content-between align-items-center footer">
                            <div class="thanks"><span class="d-block font-weight-bold">Thanks for shopping</span><span>ShopHangHieu team</span></div>
                            <div class="d-flex flex-column justify-content-end align-items-end"><span class="d-block font-weight-bold">Need Help?</span><span>Call: +83 66 750 106</span></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <a href="Menu.jsp" class="pt-5 back-to-shop"><i class='bx bx-chevrons-left'></i>Back to shop</a>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
