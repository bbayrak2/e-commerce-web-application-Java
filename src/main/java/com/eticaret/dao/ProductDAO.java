package com.eticaret.dao;

import com.eticaret.model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
    
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM products WHERE is_active = true";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getDouble("price"));
                p.setImageUrl(rs.getString("image_url"));
                p.setStock(rs.getInt("stock"));
                p.setCategory(rs.getString("category"));
                products.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("Veritabanından çekilen ürün sayısı: " + products.size());
        return products;
    }
    
    public Product getProductById(int id) {
        Product product = null;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM products WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setPrice(rs.getDouble("price"));
                product.setImageUrl(rs.getString("image_url"));
                product.setStock(rs.getInt("stock"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return product;
    }
    public boolean updateProduct(Product product) {
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "UPDATE products SET name=?, price=?, stock=? WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ps.setString(1, product.getName());
            ps.setDouble(2, product.getPrice());
            ps.setInt(3, product.getStock());
            ps.setInt(4, product.getId());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }public boolean deleteProduct(int productId) {
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "UPDATE products SET is_active = false WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ps.setInt(1, productId);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public List<Product> getFilteredProducts(String category, String search) {
        List<Product> products = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
            "SELECT * FROM products WHERE is_active = 1"
        );

        List<String> params = new ArrayList<>();

        boolean hasCategory = category != null &&
                              !category.trim().isEmpty() &&
                              !category.equalsIgnoreCase("Genel");

        boolean hasSearch = search != null &&
                            !search.trim().isEmpty();

        // KATEGORİ
        if (hasCategory) {
            sql.append(" AND LOWER(category) LIKE LOWER(?)");
            params.add("%" + category.trim() + "%");
        }

        // ARAMA 
        if (hasSearch) {

            String[] words = search.trim().split("\\s+");
            sql.append(" AND (");
            for (int i = 0; i < words.length; i++) {
                if (i > 0) {
                    sql.append(" OR ");
                }
                sql.append("LOWER(name) LIKE LOWER(?)");
                params.add("%" + words[i] + "%");
            }
            sql.append(")");
        }

        sql.append(" ORDER BY id DESC");

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql.toString());

            for (int i = 0; i < params.size(); i++) {
                ps.setString(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getDouble("price"));
                p.setImageUrl(rs.getString("image_url"));
                p.setStock(rs.getInt("stock"));
                p.setCategory(rs.getString("category"));

                products.add(p);
            }
            
        } catch (Exception e) {
            System.err.println("Filtreleme hatası:");
            e.printStackTrace();
        }

        return products;
    }

    public boolean addProduct(Product product) {
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO products (name, price, stock, image_url, category) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ps.setString(1, product.getName());
            ps.setDouble(2, product.getPrice());
            ps.setInt(3, product.getStock());
            ps.setString(4, product.getImageUrl()); 
            ps.setString(5, product.getCategory());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}