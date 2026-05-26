package com.eticaret.dao;

import com.eticaret.model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // 1. Kullanıcı Girişi (Login) İşlemi
    public User loginUser(String email, String password) {
        User user = null;
        try {
            Connection conn = DBConnection.getConnection();
            // E-posta ve şifresi eşleşen kullanıcıyı arıyoruz
            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password); // Not: İleride şifreleri hash'lersen burası değişecek
            
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role")); // 'admin' veya 'customer'
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user; // Eğer kullanıcı bulunamazsa null döner
    }

    // 2. Yeni Kullanıcı Kaydı (Register) İşlemi
    public boolean registerUser(User user) {
        boolean isRegistered = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO users (full_name, email, password, phone, address, role) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getAddress());
            ps.setString(6, "customer"); // Yeni kayıt olan herkes varsayılan olarak müşteri rolündedir
            
            isRegistered = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isRegistered;
    }

    // 3. E-posta Kayıtlı Mı Kontrolü (Proje isterindeki hata mesajı için)
    public boolean isEmailExists(String email) {
        boolean exists = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT id FROM users WHERE email = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                exists = true; // Kayıt bulundu, bu e-posta alınmış!
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return exists;
    }

    // 4. Tüm Kullanıcıları Listeleme (Yalnızca Admin Paneli İçin)
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM users";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setFullName(rs.getString("full_name"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                u.setAddress(rs.getString("address"));
                u.setRole(rs.getString("role"));
                // Şifreyi listeye eklememize gerek yok, güvenlik açısından admin bile görmese iyi olur
                users.add(u);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }
}