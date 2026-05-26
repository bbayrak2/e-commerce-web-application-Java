package com.eticaret.servlet;

import java.io.IOException;

// Tomcat 10+ kullandığın için 'jakarta' paketlerini kullanıyoruz
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// Kendi oluşturduğun sınıfları buraya dahil ediyoruz
import com.eticaret.dao.OrderDAO;
import com.eticaret.model.Cart;
import com.eticaret.model.User;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedInUser");
        Cart cart = (Cart) session.getAttribute("cart");
        

        String address = request.getParameter("address");


        if (user == null) {
            response.sendRedirect("login.jsp?error=login_required");
            return;
        }

        if (cart != null && !cart.getItems().isEmpty()) {
            OrderDAO orderDAO = new OrderDAO();
            
            boolean result = orderDAO.placeOrder(user, cart, address);

            if (result) {
                session.setAttribute("cart", new Cart()); 
                response.sendRedirect("order-success.jsp");
            } else {
                response.sendRedirect("cart.jsp?error=db_error");
            }
        } else {
            response.sendRedirect("index.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("cart.jsp");
    }
}