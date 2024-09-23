package Main.servlets;

import Page.Services.ProductService;
import Page.registration.RegistrationDAO;
import Page.registration.RegistrationDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CookieServlet extends HttpServlet {

    private final String LOGIN_PAGE = "Login.jsp";
    private final String MENU_PAGE = "ListProduct";
    private final String US = "US";
    private final String AD = "AD";
    
    private final ProductService productService = new ProductService();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String url = LOGIN_PAGE;

        try {
            Cookie[] cookies = request.getCookies();
            String userName = "";
            String password = "";
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    String key = cookie.getName();
                    String val = cookie.getValue();
                    if (key.equals("USERNAME")) {
                        userName = val;
                    }
                    if (key.equals("PASSWORD")) {
                        password = val;
                    }
                }
                if (!userName.isEmpty() && !password.isEmpty()) {
                    RegistrationDAO dao = new RegistrationDAO();
                    RegistrationDTO isValid = dao.authenticate(userName, password);
                    if (isValid != null) {
                        String roleId = isValid.getRoleID();
                        if (AD.equals(roleId) || US.equals(roleId)) {
                            url = MENU_PAGE;
                        }
                        productService.paginateProducts(request, 1);

                        Cookie userCookie = new Cookie("USERNAME", userName);
                        Cookie passCookie = new Cookie("PASSWORD", password);
                        response.addCookie(userCookie);
                        response.addCookie(passCookie);
                    } else {
                        clearSessionAndCookies(request, response);
                    }
                } else {
                    clearSessionAndCookies(request, response);
                }
            } else {
                clearSessionAndCookies(request, response);
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            response.sendRedirect(url);
            out.close();
        }
    }

    private void clearSessionAndCookies(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                cookie.setValue("");
                cookie.setMaxAge(0);
                response.addCookie(cookie);
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Cookie Servlet";
    }
}
