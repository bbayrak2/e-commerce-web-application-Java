package com.eticaret.dao;

import com.eticaret.model.Category;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    // Aktif kategoriler
	public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM categories WHERE is_active = true";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Category c = new Category();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                c.setDescription(rs.getString("description"));
                c.setActive(rs.getBoolean("is_active")); 
                
                categories.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        System.out.println("Veritabanından çekilen kategori sayısı: " + categories.size());
        return categories;
    }



    // Kategori Ekleme 
    public boolean insertCategory(Category category) {
        boolean rowInserted = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO categories (name, description, is_active) VALUES (?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ps.setString(1, category.getName());
            ps.setString(2, category.getDescription());
            ps.setBoolean(3, category.isActive());
            
            rowInserted = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rowInserted;
    }

    // Kategoriyi ID ile çekme
    public Category getCategoryById(int id) {
        Category category = null;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM categories WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                category = new Category();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                category.setDescription(rs.getString("description"));
                category.setActive(rs.getBoolean("is_active"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return category;
    }
}