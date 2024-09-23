<%@page import="Page.Product.ProductDTO"%>
<%@page import="Page.Invoice.InvoiceDTO"%>
<%@page import="Page.Invoice.InvoiceDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Purchase History</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet"/>
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <style>
            .container {
                margin-top: 50px;
            }
            .card {
                margin-bottom: 20px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.15);
            }
            .card-header {
                background-color: #f8f9fa;
                font-weight: bold;
            }
            .card-body {
                padding: 20px;
            }
            .table thead th {
                background-color: #f8f9fa;
                border-color: #dee2e6;
                font-weight: bold;
            }
            .img-fluid {
                max-width: 50px;
                max-height: 50px;
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
        </style>
    </head>
    <body>
        <div class="container mt-5">
            <h2 class="text-center">Purchase History</h2>
            <hr>
            <% List<InvoiceDTO> purchaseHistory = (List<InvoiceDTO>) session.getAttribute("purchaseHistory");
                if (purchaseHistory != null) {
                    for (int i = 0; i < purchaseHistory.size(); i++) {
                        InvoiceDTO invoice = purchaseHistory.get(i);
            %>
            <div class="card">
                <div class="card-header">
                    <strong>Invoice ID:</strong> <%= invoice.getInvoiceID()%>
                    <span class="float-right"><strong>Date:</strong> <%= invoice.getInvoiceDate()%></span>
                </div>
                <div class="card-body">
                    <h5>Shipping Method: <%= invoice.getShippingMethod()%></h5>
                    <hr>
                    <h6>Products:</h6>
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
                            <% List<ProductDTO> products = invoice.getProducts();
                                for (ProductDTO product : products) {
                            %>
                            <tr>
                                <td><img src="<%= "./images/" + product.getProductIMG()%>" class="img-fluid"></td>
                                <td><%= product.getProductName()%></td>
                                <td><%= product.getCompany()%></td>
                                <td>$<%= product.getPrice()%></td>
                                <td><%= product.getQuantity()%></td>
                                <td>$<%= product.getQuantity() * product.getPrice()%></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
            <% }
    } else { %>
            <p class="text-center">No purchase history found.</p>
            <% }%>
        </div>

        <a href="Menu.jsp" class="back-to-shop"><i class='bx bx-chevrons-left'></i>Back to shop</a>

    </body>
</html>
