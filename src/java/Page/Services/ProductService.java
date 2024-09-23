/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Page.Services;

import Page.Product.ProductDTO;
import Page.registration.RegistrationDAO;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Nhat Hung
 */
public class ProductService {

    private final RegistrationDAO dao;

    public ProductService() {
        dao = new RegistrationDAO();
    }

    public void paginateProducts(HttpServletRequest request, int currentPage) throws SQLException, ClassNotFoundException {
        int count = dao.getTotalProducts();
        int endPage = (int) Math.ceil(count / 12.0);

        List<ProductDTO> productList = dao.pagingProduct(currentPage);

        HttpSession session = request.getSession();
        session.setAttribute("PRODUCT_PAGING", productList);
        request.setAttribute("endP", endPage);
        request.setAttribute("currentPage", currentPage);
    }
}
