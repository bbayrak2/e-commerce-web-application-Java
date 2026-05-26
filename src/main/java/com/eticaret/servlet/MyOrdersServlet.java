


package com.eticaret.servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.eticaret.dao.OrderDAO;
import com.eticaret.model.Order;
import com.eticaret.model.User;

@WebServlet("/my-orders")
public class MyOrdersServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedInUser");
        
        if (user == null) {
            response.sendRedirect("login.jsp?error=login_required");
            return;
        }
        
        OrderDAO orderDAO = new OrderDAO();
        List<Order> userOrders = orderDAO.getOrdersByUserId(user.getId());
        request.setAttribute("orders", userOrders);
        request.getRequestDispatcher("my-orders.jsp").forward(request, response);
    }
}