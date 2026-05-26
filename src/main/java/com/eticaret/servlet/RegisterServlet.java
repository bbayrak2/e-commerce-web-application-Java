package com.eticaret.servlet;
import com.eticaret.dao.UserDAO;
import com.eticaret.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Formdan gelen Türkçe karakterleri düzgün almak için
        request.setCharacterEncoding("UTF-8");

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // 1. Kural: E-posta sistemde kayıtlı mı?
        if (userDAO.isEmailExists(email)) {
            request.setAttribute("errorMessage", "Bu e-posta adresi zaten kullanılıyor!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return; // İşlemi burada kes
        }

        // 2. Yeni User nesnesi oluştur ve içini doldur
        User newUser = new User();
        newUser.setFullName(fullName);
        newUser.setEmail(email);
        newUser.setPassword(password);
        newUser.setPhone(phone);
        newUser.setAddress(address);

        // 3. Veritabanına kaydet
        boolean isRegistered = userDAO.registerUser(newUser);

        if (isRegistered) {
            // Kayıt başarılıysa login sayfasına yönlendir
            request.setAttribute("successMessage", "Kayıt başarılı! Şimdi giriş yapabilirsiniz.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Kayıt sırasında bir hata oluştu. Lütfen tekrar deneyin.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}