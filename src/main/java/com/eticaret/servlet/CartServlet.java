package com.eticaret.servlet;

import com.eticaret.dao.ProductDAO;
import com.eticaret.model.Cart;
import com.eticaret.model.CartItem;
import com.eticaret.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }

 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        int productId = Integer.parseInt(request.getParameter("productId"));

        HttpSession session = request.getSession();


        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null) {
            cart = new Cart();
        }

        // ================= ADD =================
        if ("add".equals(action)) {
            Product product = productDAO.getProductById(productId);

            if (product != null && product.getStock() > 0) {
                cart.addItem(product, 1);
            }
        }
        // ================= UPDATE =================
        else if ("update".equals(action)) {
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            for (CartItem item : cart.getItems()) {
                if (item.getProduct().getId() == productId) {
                    if (quantity > 0 && quantity <= item.getProduct().getStock()) {
                        item.setQuantity(quantity);
                    }
                    break;
                }
            }
        }
        // ================= REMOVE =================
        else if ("remove".equals(action)) {
            cart.getItems().removeIf(
                    item -> item.getProduct().getId() == productId
            );
        }


        session.setAttribute("cart", cart);

        if ("add".equals(action)) {
            String referer = request.getHeader("Referer");
            if (referer != null && !referer.isEmpty()) {
                response.sendRedirect(referer);
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
 
            response.sendRedirect("cart");
        }
    }
}