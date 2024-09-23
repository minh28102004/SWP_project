<%-- 
    Document   : Menu
    Created on : Jun 13, 2024, 2:20:43 PM
    Author     : HP
--%>

<%@page import="Page.registration.RegistrationDTO"%>
<%@page import="Page.Product.ProductDTO"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menu</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: Montserrat, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
                overflow-x: hidden; /* Ẩn phần thừa khi kéo ngang */
            }


            .Header {
                position: fixed;
                top: 0;
                width: 100%;
                background-color: white;
                z-index: 1000;
            }

            .title-head {
                font-family: Montserrat, sans-serif;
                text-align: center;
                background-color: #333333;
                color: #fefefe;
                line-height: 70px;
            }

            .menu-body {
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 10px 50px;
            }

            .menu-body .logo {
                display: flex;
                justify-content: flex-start;
                align-items: center;
            }

            .menu-body .logo img {
                width: 100px;
                height: 100px;
            }

            .menu-body .input-form {
                display: flex;
                justify-content: center;
                align-items: center;
                width: 60%;
            }

            .menu-body .input-form .txtText {
                width: 70%;
                height: 40px;
                padding: 0 10px;
                border: 1px solid #ccc;
                border-radius: 4px 0 0 4px; /* Round left side */
            }

            .menu-body .input-form .btn {
                background-color: #333333;
                color: #fefefe;
                height: 40px;
                width: 20%;
                text-align: center;
                cursor: pointer;
                border: none;
                border-radius: 0 4px 4px 0; /* Round right side */
            }

            .menu-body .menu-cart {
                display: flex;
                align-items: center;
                justify-content: space-around;
            }

            .menu-body .menu-cart div {
                font-family: Montserrat, sans-serif;
                font-size: 16px;
                font-weight: 600;
                color: #333333;
                margin-right: 10px;
            }

            .menu-body .menu-cart a {
                color: #333333;
            }

            .menu-body .menu-cart a:hover {
                color: black;
            }

            .menu_bar {
                background-color: #333333;
                height: 60px;
                width: 100%;
                display: flex;
                align-items: center;
                justify-content: center;
                align-content: center;
                z-index: 999; /* Đảm bảo dropdown không bị che bởi thanh navbar */
            }

            .menu_bar ul {
                display: flex;
                list-style-type: none;
                width: 100%;
                height: 100%;
                align-items: center;
                padding: 0;
                margin: 0;
            }

            .menu_bar ul li {
                padding: 10px 20px;
                border-left: 1px solid #fefefe;
                width: 100%;
                height: 100%;
                position: relative;
            }

            .menu_bar ul li a {
                text-decoration: none;
                color: #fefefe;
                font-size: 14px;
                display: block;
                width: 100%;
                display: flex;
                align-items: center;
                justify-content: center;
                height: 100%;
                position: relative;
            }

            .menu_bar ul li a:before {
                content: "";
                position: absolute;
                width: 0;
                height: 1px;
                background-color: #fefefe;
                top: 110%;
                left: 0;
                transition: 0.5s ease;
            }

            .menu_bar ul li a:hover:before {
                width: 100%;
            }

            .dropdown_menu {
                display: none;
                position: absolute;
                left: 0;
                top: 100%;
                background-color: #333333;
                opacity: 0;
                visibility: hidden;
                transition: all 0.25s ease;
                z-index: 1001; /* Đảm bảo dropdown hiển thị trên cùng */
            }

            .dropdown_menu ul {
                display: block;
                margin: 10px;
            }

            .dropdown_menu ul li {
                width: 200px;
                padding: 10px;
                border: 0;
            }

            .menu_bar ul li:hover .dropdown_menu {
                display: block;
                opacity: 1;
                visibility: visible;
            }

            /* Các phần còn lại của CSS */

            .product-container {
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
                padding: 20px;
                margin-top: 40px; /* Tùy chỉnh lại nếu cần thiết */
            }

            .product-card {
                width: calc(25% - 20px); /* Đặt width theo tỷ lệ phần trăm hoặc giá trị cố định để các sản phẩm có cùng kích thước */
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                transition: transform 0.3s ease;
                margin-bottom: 20px; /* Xóa dòng này để loại bỏ khoảng cách dư thừa */
            }

            .product-card:hover {
                transform: translateY(-5px);
            }

            .product-card .product-img {
                width: 100%;
                height: 300px;
                border-top-left-radius: 8px;
                border-top-right-radius: 8px;
            }

            .product-card .product-info {
                padding: 10px;
            }

            .product-card .product-name {
                font-size: 16px;
                margin-bottom: 5px;
            }

            .product-card .company-name {
                font-size: 14px;
                color: #777;
                margin-bottom: 5px;
            }

            .product-card .price {
                font-size: 16px;
                font-weight: bold;
                color: #333;
                margin-bottom: 10px;
            }
            /* Paging */
            .pagination {
                display: flex;
                justify-content: center; /* Center align the pagination links */
                margin-top: 20px; /* Add some space above the pagination */
            }

            .pagination .page-item {
                margin: 0 5px; /* Space between the pagination links */
            }

            .pagination .page-link {
                padding: 10px 15px; /* Adjust padding for better spacing */
                text-decoration: none;
                color: #007bff; /* Link color */
                border: 1px solid #007bff; /* Border color same as link */
                border-radius: 5px; /* Rounded corners */
                transition: background-color 0.3s ease, color 0.3s ease, transform 0.3s ease; /* Smooth transitions */
            }

            .pagination .page-link:hover {
                background-color: #007bff; /* Hover background color */
                color: #fff; /* Hover text color */
                transform: scale(1.05); /* Slightly enlarge the link on hover */
            }

            .pagination .page-item.active .page-link {
                background-color: #007bff; /* Active background color */
                color: #fff; /* Active text color */
                border-color: #007bff; /* Active border color */
                cursor: default; /* Disable cursor for the active link */
                pointer-events: none; /* Disable click for the active link */
            }

            .quantity-input {
                width: 60px;
                height: 30px;
                padding: 0 5px;
                border: 1px solid #ccc;
                border-radius: 4px;
                margin-right: 10px;
            }

            .add-to-cart-btn {
                background-color: #333333;
                color: #fefefe;
                border: none;
                padding: 8px 15px;
                cursor: pointer;
                border-radius: 4px;
                transition: background-color 0.3s ease;
            }

            .add-to-cart-btn:hover {
                background-color: #555;
            }

            /* Profile dropdown styling */
            .profile-dropdown {
                position: absolute;
                top: 10px;
                right: 0;
                display: flex;
                align-items: center;
                background-color: #333;
                color: #fff;
                padding: 0 10px;
                z-index: 1002; /* Đảm bảo dropdown hiển thị trên cùng */
            }

            .profile-dropdown-list {
                position: absolute;
                top: 60px;
                width: 180px;
                right: 0;
                padding-left: 10px;
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                max-height: 0;
                overflow: hidden;
                transition: max-height 0.5s;
            }

            .profile-dropdown-list.active {
                max-height: 500px;
            }

            .profile-dropdown-list-item {
                display: flex;
                align-items: center;
                padding: 0.5rem 0.5rem;
                transition: background-color 0.2s, padding-left 0.2s;
                list-style: none;
                padding-left: 0;
            }

            .profile-dropdown-list-item:hover {
                padding-left: 0.8rem;
                background-color: #f1f1f1;
            }

            .profile-dropdown-list-item a {
                display: inline-flex;
                align-items: center;
                text-decoration: none;
                font-size: 0.9rem;
                font-weight: 500;
                color: #333;
                margin-left: 0;
            }

            .profile-dropdown-list-item a i {
                margin-right: 0.8rem;
                font-size: 1.1rem;
                width: 2.3rem;
                height: 2.3rem;
                background-color: #333333;
                color: #fff;
                line-height: 2.3rem;
                text-align: center;
                border-radius: 50%;
            }

            .profile-dropdown-list hr {
                border: none;
                border-top: 3px solid #ffc107;
                margin: 0.5rem 0;
                width: 100%; /* Chiều rộng ngang hết dropdown */
            }

            .profile-dropdown-btn {
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding-right: 1rem;
                font-size: 0.9rem;                    
                font-weight: 500;
                width: 150px;
                border: 1px solid #333333;
                border-radius: 50px;
                cursor: pointer;
                transition: background-color 0.5s, box-shadow 0.5s;
            }

            .profile-dropdown-btn:hover {
                background-color: #555555; /* Màu nền hover */
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Đổ bóng mờ khi hover */
            }

            .profile-img {
                width: 3rem;
                height: 3rem;
                background-image: url(https://t3.ftcdn.net/jpg/05/14/18/46/360_F_514184651_W5rVCabKKRH6H3mVb62jYWfuXio8c8si.jpg);
                background-size: cover;
                border-radius: 50%;
            }

            /* từ đây là footer*/
            .btn-floating {
                display: inline-block;
                width: 2.5rem;
                height: 2.5rem;
                border-radius: 50%;
                background-color: #333;
                color: #fff;
                text-align: center;
                line-height: 2.5rem;
            }

            .btn-floating:hover {
                background-color: #555;
                color: #fff;
            }

            .footer-link {
                color: white;
                text-decoration: none;
                position: relative;
                transition: color 0.3s, border-bottom-color 0.3s;
            }

            .footer-link:hover {
                color: #ffc107;
            }

            .footer-link:hover::after {
                background-color: #ffc107;
            }

            .footer-link::before {
                content: '';
                position: absolute;
                width: 0%;
                height: 1px;
                bottom: -1px;
                left: 50%;
                background-color: #ffc107;
                transition: width 0.3s ease-in-out, left 0.3s ease-in-out;
            }

            .footer-link:hover::before {
                width: 100%;
                left: 0;
            }

            .contact-item p i {
                margin-right: 10px;
            }

        </style>
    </head>
    <body>
        <header class="header">
            <form action="MainController" method="POST"> 
                <div class="text_user">
                    <h3 class="title-head" >GIAYHANGHIEU.VN ONLY AUTHENTIC - CHUYÊN HÀNG CHÍNH HÃNG</h3>
                    <%
                        // Lấy thông tin user từ session
                        RegistrationDTO user = (RegistrationDTO) session.getAttribute("USER");
                    %>

                    <div class="profile-dropdown">
                        <div class="profile-dropdown-btn" onclick="toggle()">
                            <div class="profile-img"></div>
                            <span style="font-weight: bold;">
                                <%= (user != null) ? user.getUserName() : "Unknown"%>
                                <i class="fa-solid fa-angle-down"></i>
                            </span>
                        </div>
                        <ul id="dropdownMenu" class="profile-dropdown-list">
                            <% if (user != null) { %>
                            <% if (user.getRoleID().equals("US")) { %>
                            <li class="profile-dropdown-list-item">
                                <a href="UpdateProfile.jsp">
                                    <i class="fa-regular fa-user"></i>
                                    Edit Profile
                                </a>
                            </li>
                            <li class="profile-dropdown-list-item">
                                <a href="PurchaseHistory">
                                    <i class="fa-solid fa-cart-shopping"></i>
                                    Bill List
                                </a>
                            </li>
                            <hr>
                            <li class="profile-dropdown-list-item">
                                <a href="Logout.jsp">
                                    <i class="fa-solid fa-arrow-right-from-bracket" style="font-size: 20px;"></i>
                                    Log Out
                                </a>
                            </li>
                            <% } else if (user.getRoleID().equals("AD")) { %>
                            <li class="profile-dropdown-list-item">
                                <a href="UpdateProfile.jsp">
                                    <i class="fa-regular fa-user"></i>
                                    Edit Profile
                                </a>
                            </li>
                            <li class="profile-dropdown-list-item">
                                <a href="PurchaseHistory">
                                    <i class="fa-solid fa-cart-shopping"></i>
                                    Bill List
                                </a>
                            </li>
                            <li class="profile-dropdown-list-item">
                                <a href="SearchProductServlet">
                                    <i class="fa-solid fa-shop"></i>
                                    Update Product
                                </a>
                            </li>            
                            <li class="profile-dropdown-list-item">
                                <a href="UpdateUserServlet">
                                    <i class="fa-solid fa-layer-group"></i>
                                    Update User
                                </a>
                            </li>
                            <hr>
                            <li class="profile-dropdown-list-item">
                                <a href="Logout.jsp">
                                    <i class="fa-solid fa-arrow-right-from-bracket" style="font-size: 20px;"></i>
                                    Log Out
                                </a>
                            </li>
                            <% } else {
                                    System.out.println("No user exist!");
                                }
                            } else { %>
                            <li class="profile-dropdown-list-item">
                                <a href="Login.jsp">
                                    <i class="fa-solid fa-arrow-right-from-bracket"></i>
                                    Log In
                                </a>
                            </li>
                            <li class="profile-dropdown-list-item">
                                <a href="signup.jsp">
                                    <i class="fa-solid fa-address-book"></i>
                                    Register
                                </a>
                            </li>
                            <% } %>
                        </ul>
                    </div>
                    <!--navbar-->
                    <div class="top">
                        <div class="menu-body row">
                            <div class="logo col-md-2">
                                <img src="./images/logo-black.png" width="100" height="100" alt=""/>
                            </div>
                            <div class="input-form col-md-8">
                                <input class="txtText" type="text" name="txtSearchValue" placeholder="Tìm kiếm sản phẩm hoặc danh mục" />
                                <input class="btn" type="submit" name="btAction" value="Search"/>
                            </div>
                            <% if (user != null) { %>
                            <div class="menu-cart col-md-2">                   
                                <div>HOTLINE 0764164531</div>
                                <a href="ViewCartServlet"><i class='bx bx-cart bx-lg'></i></a>
                            </div>
                            <%} else {%>
                            <div class="menu-cart col-md-2">                   
                                <div>HOTLINE 0764164531</div>
                                <a href="Login.jsp"><i class='bx bx-cart bx-lg'></i></a>
                            </div>
                            <%}%>
                        </div>
                    </div>
                    <div class="menu_bar">
                        <ul>
                            <li><a href="ListBrandProduct?brandAction=Onitsuka">Giày Sneaker Nam</a></li>
                            <li><a href="ListBrandProduct?brandAction=Onitsuka">Giày Sneaker Nữ</a></li>
                            <li>
                                <a href="ListBrandProduct?brandAction=Nike">Giày Nike Chính Hãng <i class='bx bxs-down-arrow'></i></a>
                                <div class="dropdown_menu">
                                    <ul>
                                        <li><a href="ListBrandProduct?brandAction=Nike&productLineAction=Zoom">Nike Zoom</a></li>
                                        <li><a href="ListBrandProduct?brandAction=Nike&productLineAction=Air Force 1">Nike Air Force 1</a></li>
                                        <li><a href="ListBrandProduct?brandAction=Nike&productLineAction=Air Max">Nike Air Max</a></li>
                                        <li><a href="ListBrandProduct?brandAction=Nike&productLineAction=Jordan">Nike Jordan</a></li>
                                        <li><a href="ListBrandProduct?brandAction=Nike&productLineAction=Running">Nike Running</a></li>
                                        <li><a href="ListBrandProduct?brandAction=Nike&productLineAction=Cortez">Nike Cortez</a></li>
                                        <li><a href="ListBrandProduct?brandAction=Nike&productLineAction=Flyknit">Nike Flyknit</a></li>
                                    </ul>
                                </div>                          
                            </li>
                            <li>
                                <a href="ListBrandProduct?brandAction=Adidas">Adidas </a>
                            </li>
                            <li>
                                <a href="ListBrandProduct?brandAction=Vans">Vans </a>
                            </li>
                            <li>
                                <a href="ListBrandProduct?brandAction=New Balance">New Balance </i> </a>
                            </li>
                            <li>
                                <a href="ListBrandProduct?brandAction=MLB">MLB </a>
                            </li>
                            <li>
                                <a href="ListBrandProduct?brandAction=Converse">Converse</i></a>
                            </li>
                        </ul>
                    </div>
                </div>
            </form>
        </header>
        <main class="product-container"> 
            <%
                List<ProductDTO> productList = (List<ProductDTO>) session.getAttribute("PRODUCT_PAGING");
                if (productList != null && productList.size() > 0) {
                    Integer currentPage = (Integer) request.getAttribute("currentPage");
            %>
            <% for (int i = 0; i < productList.size(); i++) {%>
            <div class="product-card">
                <img src="<%="./images/" + productList.get(i).getProductIMG()%>" alt="Product Image" class="product-img">
                <div class="product-info">
                    <h2 class="product-name"><%=productList.get(i).getProductName()%></h2>
                    <p class="company-name">Company: <%=productList.get(i).getCompany()%></p>
                    <p class="price">Price: $<%=productList.get(i).getPrice()%></p>
                    <form action="MainController" method="post">
                        <input type="hidden" name="txtId" value="<%=productList.get(i).getProductID()%>"/>
                        <input type="hidden" name="txtIMG" value="<%=productList.get(i).getProductIMG()%>"/>
                        <input type="hidden" name="txtName" value="<%=productList.get(i).getProductName()%>"/>
                        <input type="hidden" name="txtPrice" value="<%=productList.get(i).getPrice()%>"/>
                        <input type="hidden" name="index" value="<%= currentPage%>"/>
                        <% if (user != null) {%>
                        <input type="submit" name="btAction" value="Add To Cart" class="add-to-cart-btn" >
                        <%} else {%>
                        <input type="submit" name="btAction" value="ADD TO CART" class="add-to-cart-btn" >
                        <%}%>
                        <script type="text/javascript">
                            window.onload = function () {
                                var showMessage = "<%= request.getAttribute("showMessages")%>";
                                if (showMessage !== null && showMessage === "true") {
                                    var message = "<%= request.getAttribute("messages")%>";
                                    if (message !== null && message !== "") {
                                        alert(message);
                                    }
                                }
                            };
                        </script>
                    </form>
                </div>
            </div>
            <% } %>
            <% }%>

            <nav aria-label="Page navigation" class="w-100">
                <ul class="pagination">
                    <%
                        Integer endPage = (Integer) request.getAttribute("endP");
                        Integer currentPage = (Integer) request.getAttribute("currentPage");

                        if (endPage != null && endPage > 0) {
                            for (int i = 1; i <= endPage; i++) {
                                if (i == currentPage) {
                    %>
                    <li class="page-item active" aria-current="page">
                        <span class="page-link"><%= i%></span>
                    </li>
                    <%
                    } else {
                    %>
                    <li class="page-item"><a class="page-link" href="ListProduct?index=<%= i%>"><%= i%></a></li>
                        <%
                                    }
                                }
                            }
                        %>
                </ul>
            </nav>

            <%
                if (user != null) {
                    if (user.getRoleID().equals("US")) {
            %>
            <script type="text/javascript">
                window.onload = function () {
                    if (!sessionStorage.getItem('alertDisplayed')) {
                        alert("Welcome, <%= user.getFullName()%>");
                        sessionStorage.setItem('alertDisplayed', 'true');
                    }
                };
            </script>
            <%} else if (user.getRoleID().equals("AD")) {%>
            <script type="text/javascript">
                window.onload = function () {
                    if (!sessionStorage.getItem('alertDisplayed')) {
                        alert("Welcome Admin, <%= user.getFullName()%>");
                        sessionStorage.setItem('alertDisplayed', 'true');
                    }
                };
            </script>          
            <%}%>
            <%}%>
        </main>

        <footer class="bg-dark text-white pt-5 pb-4">
            <div class="container text-md-left">
                <div class="row text-md-left">
                    <div class="col-md-3 col-lg-3 col-xl-3 mx-auto mt-3">
                        <h5 class="text-uppercase mb-4 font-weight-bold text-warning">Shop Hang Hieu</h5>
                        <p>Welcome to GIAYHANGHIEU.VN, which provides genuine footwear products from famous brands around the world. We are proud to bring customers quality, reputable products and guarantee 100% authenticity.</p>
                    </div>
                    <div class="col-md-2 col-lg-2 col-xl-2 mx-auto mt-3">
                        <h5 class="text-uppercase mb-4 font-weight-bold text-warning">Products</h5>
                        <p><a href="#" class="footer-link" style="text-decoration: none;">TheProviders</a></p>
                        <p><a href="#" class="footer-link" style="text-decoration: none;">Creativity</a></p>
                        <p><a href="#" class="footer-link" style="text-decoration: none;">SourceFiles</a></p>
                        <p><a href="#" class="footer-link" style="text-decoration: none;">Bootstrap 5 Alpha</a></p>
                    </div>
                    <div class="col-md-3 col-lg-2 col-xl-2 mx-auto mt-3">
                        <h5 class="text-uppercase mb-4 font-weight-bold text-warning">Useful links</h5>
                        <p><a href="#" class="footer-link" style="text-decoration: none;">Your Account</a></p>
                        <p><a href="#" class="footer-link" style="text-decoration: none;">Become an Affiliate</a></p>
                        <p><a href="#" class="footer-link" style="text-decoration: none;">Shipping Rates</a></p>
                        <p><a href="#" class="footer-link" style="text-decoration: none;">Help</a></p>
                    </div>
                    <div class="col-md-4 col-lg-3 col-xl-3 mx-auto mt-3">
                        <h5 class="text-uppercase mb-4 font-weight-bold text-warning">Contact</h5>
                        <div class="contact-item">
                            <p><i class="fas fa-home mr-3"></i> FPT University, Q9, TP.HCM</p>
                        </div>
                        <div class="contact-item">
                            <p><i class="fas fa-envelope mr-3"></i> Shophanghieu@gmail.com</p>
                        </div>
                        <div class="contact-item">
                            <p><i class="fas fa-phone mr-3"></i> +83 918 350 548</p>
                        </div>
                        <div class="contact-item">
                            <p><i class="fas fa-print mr-3"></i> +83 66 750 106</p>
                        </div>
                    </div>
                </div>
                <hr class="mb-4">
                <div class="row align-items-center">
                    <div class="col-md-7 col-lg-8">
                        <p>ShopHangHieu 2024© All right reserved by: 
                            <a href="#" style="text-decoration: none;">
                                <strong class="text-warning">Xuân Minh</strong>
                            </a>
                        </p>
                    </div>
                    <div class="col-md-5 col-lg-4">
                        <div class="text-center text-md-right">
                            <ul class="list-unstyled list-inline footer-social">
                                <li class="list-inline-item">
                                    <a href="#" class="btn-floating btn-sm text-white" style="font-size: 25px;"><i class='fab fa-facebook-f'></i></a>
                                </li>
                                <li class="list-inline-item">
                                    <a href="#" class="btn-floating btn-sm text-white" style="font-size: 25px;"><i class='fab fa-twitter'></i></a>
                                </li>
                                <li class="list-inline-item">
                                    <a href="#" class="btn-floating btn-sm text-white" style="font-size: 25px;"><i class='fab fa-google'></i></a>
                                </li>
                                <li class="list-inline-item">
                                    <a href="#" class="btn-floating btn-sm text-white" style="font-size: 25px;"><i class="fab fa-linkedin-in"></i></a>
                                </li>
                                <li class="list-inline-item">
                                    <a href="#" class="btn-floating btn-sm text-white" style="font-size: 25px;"><i class="fab fa-youtube"></i></a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </footer>

        <script>
            let profileDropdownList = document.querySelector(".profile-dropdown-list");
            let btn = document.querySelector(".profile-dropdown-btn");
            const toggle = () => profileDropdownList.classList.toggle("active");
            window.addEventListener('click', function (e) {

                if (!btn.contains(e.target))
                    profileDropdownList.classList.remove("active");

            });
        </script>
    </body>
</html>
