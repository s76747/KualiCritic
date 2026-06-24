package com.kualicritic.dao;

import com.kualicritic.model.Menu;
import com.kualicritic.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MenuDAO {

    public List<Menu> getMenusByStall(int stallId) {
        List<Menu> menus = new ArrayList<>();
        String sql = "SELECT * FROM menus WHERE stall_id = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, stallId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Menu menu = new Menu();
                menu.setId(rs.getInt("id"));
                menu.setStallId(rs.getInt("stall_id"));
                menu.setItemName(rs.getString("item_name"));
                menu.setPrice(rs.getDouble("price"));
                menu.setImagePath(rs.getString("image_path"));
                menus.add(menu);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menus;
    }

    // Add inside com.kualicritic.dao.MenuDAO.java
    public void insertMenu(Menu menu) {
        String sql = "INSERT INTO menus (stall_id, item_name, price, image_path) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, menu.getStallId());
            stmt.setString(2, menu.getItemName());
            stmt.setDouble(3, menu.getPrice());
            stmt.setString(4, menu.getImagePath());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Fetch all menus for the Admin Dashboard
    public List<Menu> getAllMenus() {
        List<Menu> menus = new ArrayList<>();
        String sql
                = "SELECT m.*, s.name AS stall_name "
                + "FROM menus m "
                + "LEFT JOIN stalls s ON m.stall_id = s.id";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Menu menu = new Menu();
                menu.setId(rs.getInt("id"));
                menu.setStallId(rs.getInt("stall_id"));
                menu.setStallName(rs.getString("stall_name"));
                menu.setItemName(rs.getString("item_name"));
                menu.setPrice(rs.getDouble("price"));
                menu.setImagePath(rs.getString("image_path"));
                menus.add(menu);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menus;
    }

    // Get one page of menus, joined with stall name (for pagination)
    public List<Menu> getMenus(int offset, int pageSize) {
        List<Menu> menus = new ArrayList<>();
        String sql
                = "SELECT m.*, s.name AS stall_name "
                + "FROM menus m "
                + "LEFT JOIN stalls s ON m.stall_id = s.id "
                + "ORDER BY m.id LIMIT ? OFFSET ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, pageSize);
            stmt.setInt(2, offset);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Menu menu = new Menu();
                    menu.setId(rs.getInt("id"));
                    menu.setStallId(rs.getInt("stall_id"));
                    menu.setStallName(rs.getString("stall_name"));
                    menu.setItemName(rs.getString("item_name"));
                    menu.setPrice(rs.getDouble("price"));
                    menu.setImagePath(rs.getString("image_path"));
                    menus.add(menu);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menus;
    }

    // Total number of menu items (for calculating total pages)
    public int countMenus() {
        String sql = "SELECT COUNT(*) FROM menus";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Delete a specific menu item
    public void deleteMenu(int id) {
        String sql = "DELETE FROM menus WHERE id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Fetch a single menu item by ID
    public Menu getMenuById(int id) {
        Menu menu = null;
        String sql = "SELECT * FROM menus WHERE id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                menu = new Menu();
                menu.setId(rs.getInt("id"));
                menu.setStallId(rs.getInt("stall_id"));
                menu.setItemName(rs.getString("item_name"));
                menu.setPrice(rs.getDouble("price"));
                menu.setImagePath(rs.getString("image_path"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menu;
    }

    // Update the menu item
    public void updateMenu(Menu menu) {
        String sql;
        if (menu.getImagePath() != null) {
            sql = "UPDATE menus SET stall_id = ?, item_name = ?, price = ?, image_path = ? WHERE id = ?";
        } else {
            sql = "UPDATE menus SET stall_id = ?, item_name = ?, price = ? WHERE id = ?";
        }
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, menu.getStallId());
            stmt.setString(2, menu.getItemName());
            stmt.setDouble(3, menu.getPrice());
            if (menu.getImagePath() != null) {
                stmt.setString(4, menu.getImagePath());
                stmt.setInt(5, menu.getId());
            } else {
                stmt.setInt(4, menu.getId());
            }
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
