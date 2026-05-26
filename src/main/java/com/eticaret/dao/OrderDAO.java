package com.eticaret.dao;

import java.sql.*;
import com.eticaret.model.*;
import java.util.List;
import java.util.ArrayList; // Yeni eklenen import

public class OrderDAO {
    
    // Veritabanı bağlantısı 
    private Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://mysql_db:3306/eticaret_sistemi", "root", "root");
    }

 // TÜM SİPARİŞLERİ GETİR 
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders ORDER BY id DESC";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("user_id"));
                order.setTotalPrice(rs.getDouble("total_amount"));
                order.setAddress(rs.getString("shipping_address"));
                order.setStatus(rs.getString("status"));
                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    // SİPARİŞ DURUMUNU GÜNCELLE
    public boolean updateOrderStatus(int orderId, String newStatus) {
        String sql = "UPDATE orders SET status = ? WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    // SİPARİŞ VERME METODU 
    public boolean placeOrder(User user, Cart cart, String address) {
        Connection conn = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false);

            // orders tablosuna ana kaydı ekle
            String orderSql = "INSERT INTO orders (user_id, total_amount, status, shipping_address) VALUES (?, ?, ?, ?)";
            PreparedStatement psOrder = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
            psOrder.setInt(1, user.getId());
            psOrder.setDouble(2, cart.getTotalPrice());
            psOrder.setString(3, "Hazırlanıyor");
            psOrder.setString(4, address);
            psOrder.executeUpdate();

            ResultSet rs = psOrder.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) {
                orderId = rs.getInt(1);
            }


            String itemSql = "INSERT INTO order_items (order_id, product_id, quantity, unit_price, subtotal) VALUES (?, ?, ?, ?, ?)";
            String stockSql = "UPDATE products SET stock = stock - ? WHERE id = ? AND stock >= ?";

            for (CartItem item : cart.getItems()) {
                // Sipariş detayı ekleme
                PreparedStatement psItem = conn.prepareStatement(itemSql);
                psItem.setInt(1, orderId);
                psItem.setInt(2, item.getProduct().getId());
                psItem.setInt(3, item.getQuantity());
                psItem.setDouble(4, item.getProduct().getPrice());
                psItem.setDouble(5, item.getQuantity() * item.getProduct().getPrice());
                psItem.executeUpdate();

                // Stok güncelleme 
                PreparedStatement psStock = conn.prepareStatement(stockSql);
                psStock.setInt(1, item.getQuantity());
                psStock.setInt(2, item.getProduct().getId());
                psStock.setInt(3, item.getQuantity());
                
                int affectedRows = psStock.executeUpdate();
                if (affectedRows == 0) {
                    throw new Exception("Yetersiz stok: " + item.getProduct().getName());
                }
            }

            conn.commit();
            return true;

        } catch (Exception e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    }

    // Siparişlerimi Listele
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY id DESC";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setTotalPrice(rs.getDouble("total_amount"));
                    order.setAddress(rs.getString("shipping_address"));
                    order.setStatus(rs.getString("status"));
                    

                    orders.add(order);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }
}