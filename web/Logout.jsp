<%@page import="Page.Product.ProductDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logout Page</title>
        <script type="text/javascript">
            window.onload = function () {
                alert("You have been logged out.");
                window.location.href = "ListProduct";
            };
        </script>
    </head>
    <body>
        <%
            // Retrieve the product list from the session
            List<ProductDTO> productList = (List<ProductDTO>) session.getAttribute("PRODUCT_PAGING");

            // Clear all cookies
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    cookie.setMaxAge(0); // Set cookie max age to 0 to delete it
                    response.addCookie(cookie);
                }
            }

            // Invalidate the current session
            session.invalidate();

            // Create a new session
            session = request.getSession(true);

            // Restore the product list in the new session
            if (productList != null) {
                session.setAttribute("PRODUCT_PAGING", productList);
            }
        %>
    </body>
</html>
