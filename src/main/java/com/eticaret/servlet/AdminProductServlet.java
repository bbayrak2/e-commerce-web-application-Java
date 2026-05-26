package com.eticaret.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

import com.eticaret.dao.ProductDAO;
import com.eticaret.model.Product;

@WebServlet("/admin-product")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class AdminProductServlet extends HttpServlet {
    
    private static final String UPLOAD_DIR = "images";
 // ---------------------------------------------------------
    // SİLME İŞLEMİ 
    // ---------------------------------------------------------
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String idParam = request.getParameter("id");

        if ("delete".equals(action) && idParam != null && !idParam.trim().isEmpty()) {
            try {
                int productId = Integer.parseInt(idParam);
                ProductDAO productDAO = new ProductDAO();
                productDAO.deleteProduct(productId);
            } catch (Exception e) {
                e.printStackTrace();
            }
             response.sendRedirect("admin.jsp?success=deleted");
            return;
        }
       
        
        response.sendRedirect("admin.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
            
        request.setCharacterEncoding("UTF-8");
        
        ProductDAO productDAO = new ProductDAO();
        String idParam = request.getParameter("id");
        
        String applicationPath = request.getServletContext().getRealPath("");
        String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadFilePath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        // ---------------------------------------------------------
        //  GÜNCELLEME İŞLEMİ 
        // ---------------------------------------------------------
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int productId = Integer.parseInt(idParam);
                double price = Double.parseDouble(request.getParameter("price"));
                int stock = Integer.parseInt(request.getParameter("stock"));
                
                Product existingProduct = productDAO.getProductById(productId);
                
                if (existingProduct != null) {
                    existingProduct.setPrice(price);
                    existingProduct.setStock(stock);
                    
                    Part filePart = request.getPart("image");
                    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    
                    if (fileName != null && !fileName.isEmpty()) {
                        filePart.write(uploadFilePath + File.separator + fileName);
                        existingProduct.setImageUrl(UPLOAD_DIR + "/" + fileName);
                    }
                    
                    
                    productDAO.updateProduct(existingProduct);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            
            response.sendRedirect("admin.jsp?success=updated");
            return; 
        }

        // ---------------------------------------------------------
        // YENİ ÜRÜN EKLEME İŞLEMİ 
        // ---------------------------------------------------------
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        String category = request.getParameter("category");
        
        Part filePart = request.getPart("image");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        
        String imagePath = "images/default.jpg"; 
        
        if (fileName != null && !fileName.isEmpty()) {
            filePart.write(uploadFilePath + File.separator + fileName);
            imagePath = UPLOAD_DIR + "/" + fileName; 
        }

        Product newProduct = new Product();
        newProduct.setName(name);
        newProduct.setPrice(price);
        newProduct.setStock(stock);
        newProduct.setCategory(category);
        newProduct.setImageUrl(imagePath);

        productDAO.addProduct(newProduct);

        response.sendRedirect("admin.jsp?success=added");
    }
}