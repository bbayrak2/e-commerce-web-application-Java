package com.eticaret.servlet;

import java.util.List;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.eticaret.dao.ProductDAO;
import com.eticaret.model.Product;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String category = request.getParameter("category");
        String search = request.getParameter("search");
        
        List<Product> productList = productDAO.getFilteredProducts(category, search);
        
        request.setAttribute("products", productList);
        request.setAttribute("selectedCategory", category);
        request.setAttribute("selectedSearch", search);
        
        request.getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);
    }
}