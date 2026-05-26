package com.eticaret.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.eticaret.dao.OrderDAO;

@WebServlet("/admin-orders")
public class AdminOrdersServlet extends HttpServlet {
    private final OrderDAO orderDAO = new OrderDAO();

    // Siparişleri Listeleme
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setAttribute("orders", orderDAO.getAllOrders());
        request.getRequestDispatcher("adminOrders.jsp").forward(request, response);
    }

    // Sipariş Durumu Güncelleme
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String status = request.getParameter("status");
        
        orderDAO.updateOrderStatus(orderId, status);
        response.sendRedirect("admin-orders");
    }
}