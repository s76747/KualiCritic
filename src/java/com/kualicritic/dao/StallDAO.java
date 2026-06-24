package com.kualicritic.dao;

import com.kualicritic.model.Stall;
import com.kualicritic.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StallDAO {

    public List<Stall> getAllStalls() {
        List<Stall> stalls = new ArrayList<>();
        String sql = "SELECT * FROM stalls";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Stall stall = new Stall();
                stall.setId(rs.getInt("id"));
                stall.setName(rs.getString("name"));
                stall.setDescription(rs.getString("description"));
                stall.setImagePath(rs.getString("image_path"));
                stalls.add(stall);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stalls;
    }

    // Get one page of stalls (for pagination)
    public List<Stall> getStalls(int offset, int pageSize) {
        List<Stall> stalls = new ArrayList<>();
        String sql = "SELECT * FROM stalls ORDER BY id LIMIT ? OFFSET ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, pageSize);
            stmt.setInt(2, offset);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Stall stall = new Stall();
                    stall.setId(rs.getInt("id"));
                    stall.setName(rs.getString("name"));
                    stall.setDescription(rs.getString("description"));
                    stall.setImagePath(rs.getString("image_path"));
                    stalls.add(stall);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stalls;
    }

    // Total number of stalls (for calculating total pages)
    public int countStalls() {
        String sql = "SELECT COUNT(*) FROM stalls";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Add this to com.kualicritic.dao.StallDAO.java
    public Stall getStallById(int id) {
        Stall stall = null;
        String sql = "SELECT * FROM stalls WHERE id = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                stall = new Stall();
                stall.setId(rs.getInt("id"));
                stall.setName(rs.getString("name"));
                stall.setDescription(rs.getString("description"));
                stall.setImagePath(rs.getString("image_path"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stall;
    }

    // Delete a stall
    public void deleteStall(int id) {
        String sql = "DELETE FROM stalls WHERE id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Add this inside com.kualicritic.dao.StallDAO.java
    public void insertStall(Stall stall) {
        String sql = "INSERT INTO stalls (name, description, image_path) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, stall.getName());
            stmt.setString(2, stall.getDescription());
            stmt.setString(3, stall.getImagePath()); // Can be null

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Update the stall. Notice we check if the imagePath is null!
    public void updateStall(Stall stall) {
        String sql;
        // If they uploaded a new image, update the image path too. If not, leave the old image alone.
        if (stall.getImagePath() != null) {
            sql = "UPDATE stalls SET name = ?, description = ?, image_path = ? WHERE id = ?";
        } else {
            sql = "UPDATE stalls SET name = ?, description = ? WHERE id = ?";
        }

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, stall.getName());
            stmt.setString(2, stall.getDescription());

            if (stall.getImagePath() != null) {
                stmt.setString(3, stall.getImagePath());
                stmt.setInt(4, stall.getId());
            } else {
                stmt.setInt(3, stall.getId());
            }
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
