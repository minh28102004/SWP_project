<%@page import="Page.Cart.CartDAO"%>
<%@page import="Page.Cart.CartDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Cart</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <style>
            body {
                font-family: Montserrat, sans-serif;
                margin: 20px;
                background-color: #d2c9ff;
                color: #333;
            }

            h1 {
                text-align: center;
                color: #333;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
                background-color: #fff;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            table, th, td {
                border: 1px solid #ddd;
            }

            th, td {
                padding: 15px;
                text-align: center;
            }

            th {
                background-color: #f2f2f2;
                color: #333;
            }

            td img {
                width: 100px;
                height: auto;
            }

            td input[type="number"] {
                width: 60px;
                padding: 5px;
                text-align: center;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            td .btn-group {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 5px;
            }

            td .btn {
                padding: 5px 10px; /* Adjust padding inside buttons */
                margin-right: 5px; /* Adjust spacing between buttons */
            }

            td .remove-btn, td .update-btn {
                background-color: transparent;
                border: none;
                cursor: pointer;
                margin-right: 5px;
            }

            td .remove-btn:hover {
                color: #e74c3c;
            }

            td .update-btn:hover {
                color: #3498db;
            }

            tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            tr:hover {
                background-color: #f1f1f1;
            }

            .form-control.form-control-sm{
                width: 35px;
            }

            .num-of-books {
                display: block;
                font-size: 1.2em;
                margin-top: 10px;
            }

            .back-to-shop {
                display: inline-block;
                margin-top: 15px;
                text-decoration: none;
                color: black;
                transition: color 0.2s, transform 0.2s ease;
            }

            .back-to-shop:hover {
                color: #3498db;
                transform: translateX(-3px); /* Hiệu ứng dịch chuyển */
            }

            .back-to-shop i {
                margin-right: 5px;
            }

            .card-registration-2 .bg-grey {
                background-color: #eae8e8;
                border-top-right-radius: 16px;
                border-bottom-right-radius: 16px;
                padding: 30px;
            }

            .summary h3 {
                font-weight: bold;
            }

            .summary .select {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            .summary .form-outline {
                margin-bottom: 20px;
            }

            .summary .form-outline input {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            .summary .form-outline label {
                margin-top: 10px;
                display: block;
                color: #333;
            }

            .summary button {
                width: 100%;
                padding: 15px;
                border: none;
                border-radius: 5px;
                background-color: #000;
                color: #fff;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .summary button:hover {
                background-color: #333;
            }
        </style>
    </head>
    <body>
        <%
            List<CartDTO> cartList = (List<CartDTO>) session.getAttribute("CART");
            if (cartList != null && cartList.size() > 0) {
                double shippingCost = 0.00;
        %>

        <section class="h-120 h-custom">
            <div class="container py-5 h-100">
                <div class="row d-flex justify-content-center align-items-center ">
                    <div class="col-12">
                        <div class="card card-registration card-registration-2" style="border-radius: 15px;">
                            <div class="card-body p-0">
                                <div class="row g-0">
                                    <div class="col-lg-8">
                                        <div class="p-5">
                                            <div class="d-flex justify-content-center align-items-center mb-5">
                                                <h1 class="fw-bold mb-0 text-center text-black">Shopping Cart</h1>
                                            </div>
                                            <hr class="my-4">

                                            <div class="table-responsive">
                                                <table class="table">
                                                    <thead>
                                                        <tr>
                                                            <th>Select</th>
                                                            <th>Image</th>
                                                            <th>Name</th>
                                                            <th>Quantity</th>
                                                            <th>Price</th>
                                                            <th>Subtotal</th>
                                                            <th>Action</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%
                                                            for (int i = 0; i < cartList.size(); i++) {
                                                                CartDTO cartItem = cartList.get(i);
                                                                int availableQuantity = CartDAO.getAvailableQuantity(cartItem.getProductId());
                                                        %>
                                                    <form action="MainController" method="POST">  
                                                        <tr>
                                                            <td><input type="checkbox" name="selectedItems" value="<%= cartItem.getProductId()%>" data-cart-id="<%= cartItem.getCartId()%>" onchange="updateCheckedSubtotal(<%= i%>, <%= cartItem.getPrice()%>, <%= cartItem.getQuantity()%>)"></td>
                                                            <td><img src="<%= "./images/" + cartItem.getProductImg()%>" class="img-fluid rounded-3" alt="Product Image"></td>
                                                            <td><%= cartItem.getProductName()%></td>
                                                            <td>
                                                                <div class="btn-group">
                                                                    <button class="btn btn-link px-2" type="button" onclick="decrementQuantity(<%= i%>, <%= cartItem.getPrice()%>)"><i class="fas fa-minus"></i></button>
                                                                    <input id="quantity_<%= i%>" min="1" max="<%= availableQuantity%>" name="txtQuantity" value="<%= cartItem.getQuantity()%>" type="number" class="form-control form-control-sm quantity-input" required />
                                                                    <button class="btn btn-link px-2" type="button" onclick="incrementQuantity(<%= i%>, <%= cartItem.getPrice()%>, <%= availableQuantity%>)"><i class="fas fa-plus"></i></button>
                                                                </div>
                                                            </td>
                                                            <td>$<%= cartItem.getPrice()%></td>
                                                            <td id="subtotal_<%= i%>">$<%= cartItem.getSubTotal()%></td>
                                                            <td>
                                                                <input type="hidden" name="CartID" value="<%= cartItem.getCartId()%>">
                                                                <input type="hidden" name="productID" value="<%= cartItem.getProductId()%>" />
                                                                <button type="submit" name="btAction" value="Remove_From_Cart" class="remove-btn"><i class="fas fa-trash-alt"></i></button>
                                                                <button type="submit" name="btAction" value="Update_Cart" class="update-btn"><i class="fas fa-check"></i></button>
                                                            </td>
                                                        </tr>
                                                    </form>
                                                    <%
                                                        }
                                                    %>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <hr class="my-4">
                                            <div class="pt-5">
                                                <a href="ListProduct" class="text-body back-to-shop"><i class='bx bx-chevrons-left'></i>Back to shop</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 bg-grey">
                                        <div class="p-5 summary">
                                            <form action="BuyCartServlet" method="POST" onsubmit="return validatePurchase()">
                                                <h3 class="fw-bold text-uppercase text-center mb-5 mt-2 pt-1">Summary</h3>
                                                <hr class="my-4">
                                                <div class="d-flex justify-content-between mb-4">
                                                    <h5 class="text-uppercase">Items: <span id="checkedItemsCount">0</span></h5>
                                                    <h5 class="text-uppercase" id="checkedSubtotal">$0.00</h5>
                                                </div>
                                                <h5 class="text-uppercase mb-3">Shipping: </h5>
                                                <div class="mb-4 pb-2">
                                                    <select name="shipping" class="select" onchange="updateShipping(this)">
                                                        <option value="" disabled selected>Choose your shipping</option>
                                                        <option value="5.00">Standard-Delivery- $5.00</option>
                                                        <option value="15.00">Express-Delivery- $15.00</option>
                                                        <option value="25.00">Overnight-Delivery- $25.00</option>
                                                    </select>
                                                </div>
                                                <hr class="my-4">
                                                <div class="d-flex justify-content-between mb-5">
                                                    <h5 class="text-uppercase">Total price: </h5>
                                                    <h5 id="total_Price">$0.00</h5>
                                                </div>
                                                <input type="hidden" name="checkedItemsCount" id="hiddenCheckedItemsCount">
                                                <input type="hidden" name="checkedSubtotal" id="hiddenCheckedSubtotal">
                                                <input type="hidden" name="totalPrice" id="hiddenTotalPrice">
                                                <input type="hidden" name="selectedCartIDs" id="hiddenSelectedCartIDs"> 
                                                <button type="submit" name="btAction" value="Buy" class="btn btn-primary">Buy</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <% } else { %>
        <h1>Your cart is empty</h1>
        <%  }%>

        <script>
            function updateSubtotal(inputElement, unitPrice) {
                const quantity = parseInt(inputElement.value);
                const rowIndex = inputElement.closest('tr').rowIndex - 1; // Find row index relative to the table
                const subtotalElement = document.getElementById("subtotal_" + rowIndex);
                subtotalElement.textContent = '$' + (quantity * unitPrice).toFixed(2);
                updateCheckedSubtotal();
            }

            function updateCheckedSubtotal() {
                let checkedSubtotal = 0;
                let checkedItemsCount = 0;
                const checkboxes = document.querySelectorAll('input[name="selectedItems"]:checked');
                let selectedCartIDs = [];
                checkboxes.forEach(checkbox => {
                    const row = checkbox.closest('tr');
                    const subtotalCell = row.querySelector('td[id^="subtotal_"]');
                    const quantityInput = row.querySelector('input[name="txtQuantity"]');
                    checkedItemsCount += parseInt(quantityInput.value);
                    checkedSubtotal += parseFloat(subtotalCell.textContent.substring(1));
                    selectedCartIDs.push(checkbox.dataset.cartId);
                });
                document.getElementById('checkedItemsCount').textContent = checkedItemsCount;
                document.getElementById('checkedSubtotal').textContent = '$' + checkedSubtotal.toFixed(2);

                document.getElementById('hiddenCheckedItemsCount').value = checkedItemsCount;
                document.getElementById('hiddenCheckedSubtotal').value = checkedSubtotal.toFixed(2);
                document.getElementById('hiddenSelectedCartIDs').value = selectedCartIDs.join(',');

                updateTotalPrice();
            }

            function updateShipping(selectElement) {
                shippingCost = parseFloat(selectElement.value);
                updateTotalPrice();
            }

            function updateTotalPrice() {
                const checkedSubtotal = parseFloat(document.getElementById('checkedSubtotal').textContent.substring(1));
                const total = checkedSubtotal + shippingCost;
                document.getElementById('total_Price').textContent = '$' + total.toFixed(2);
                document.getElementById('hiddenTotalPrice').value = total.toFixed(2);
            }

            function updateQuantityInput(index) {
                const quantity = document.getElementById("quantity_" + index).value;
                document.getElementById("quantityInput_" + index).value = quantity;
            }

            function incrementQuantity(index, price, availableQuantity) {
                const input = document.getElementById("quantity_" + index);
                if (parseInt(input.value) < availableQuantity) {
                    input.stepUp();
                    updateQuantityInput(index);
                    updateSubtotal(input, price);
                } else {
                    alert("Cannot add more than available quantity.");
                }
            }

            function decrementQuantity(index, price) {
                const input = document.getElementById("quantity_" + index);
                if (parseInt(input.value) > 1) {
                    input.stepDown();
                    updateQuantityInput(index);
                    updateSubtotal(input, price);
                }
            }

            function validatePurchase() {
                const checkedItemsCount = parseInt(document.getElementById('hiddenCheckedItemsCount').value);
                if (checkedItemsCount === 0) {
                    alert("Please select at least one item to purchase.");
                    return false;
                }

                const shippingSelect = document.querySelector('select[name="shipping"]');
                if (!shippingSelect.value) {
                    alert("Please choose a shipping method.");
                    return false;
                }

                return true;
            }
        </script>
    </body>
</html>
