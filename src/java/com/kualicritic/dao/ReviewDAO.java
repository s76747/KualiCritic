package com.kualicritic.dao;

import com.kualicritic.model.Review;
import com.kualicritic.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {

    // 1. Add a new review (Includes image_path)
    public void addReview(Review review) {
        String sql = "INSERT INTO reviews (user_id, stall_id, rating, comment, image_path) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, review.getUserId()); // Fixed: use int userId, not String reviewerId
            stmt.setInt(2, review.getStallId());
            stmt.setInt(3, review.getRating());
            stmt.setString(4, review.getComment());
            stmt.setString(5, review.getImagePath());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 2. Fetch all reviews for the Admin Dashboard (Includes image_path fix)
    public List<Review> getAllReviews() {
        List<Review> reviews = new ArrayList<>();

        String sql
                = "SELECT r.*, u.student_id "
                + "FROM reviews r "
                + "JOIN users u ON r.user_id = u.id "
                + "ORDER BY r.id DESC";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Review r = new Review();
                r.setId(rs.getInt("id"));
                r.setReviewerId(rs.getString("student_id")); // ← now student ID
                r.setStallId(rs.getInt("stall_id"));
                r.setRating(rs.getInt("rating"));
                r.setComment(rs.getString("comment"));
                r.setImagePath(rs.getString("image_path"));

                reviews.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return reviews;
    }

    // Get one page of reviews, joined with student ID (for pagination)
    public List<Review> getReviews(int offset, int pageSize) {
        List<Review> reviews = new ArrayList<>();

        String sql
                = "SELECT r.*, u.student_id "
                + "FROM reviews r "
                + "JOIN users u ON r.user_id = u.id "
                + "ORDER BY r.id DESC LIMIT ? OFFSET ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, pageSize);
            stmt.setInt(2, offset);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Review r = new Review();
                    r.setId(rs.getInt("id"));
                    r.setReviewerId(rs.getString("student_id"));
                    r.setStallId(rs.getInt("stall_id"));
                    r.setRating(rs.getInt("rating"));
                    r.setComment(rs.getString("comment"));
                    r.setImagePath(rs.getString("image_path"));

                    reviews.add(r);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return reviews;
    }

    // Total number of reviews (for calculating total pages)
    public int countReviews() {
        String sql = "SELECT COUNT(*) FROM reviews";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // 3. Fetch reviews for a specific stall on the Stall Details page (Includes image_path fix)
    public List<Review> getReviewsByStallId(int stallId) {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT * FROM reviews WHERE stall_id = ? ORDER BY id DESC";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, stallId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Review r = new Review();
                r.setId(rs.getInt("id"));
                r.setReviewerId(rs.getString("user_id"));
                r.setStallId(rs.getInt("stall_id"));
                r.setRating(rs.getInt("rating"));
                r.setComment(rs.getString("comment"));
                r.setImagePath(rs.getString("image_path")); // Fixed missing image path

                reviews.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reviews;
    }

    // 4. Delete a review from the Admin Dashboard
    public void deleteReview(int id) {
        String sql = "DELETE FROM reviews WHERE id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 5. Fetch reviews by a specific user for the 'My Reviews' page
    public List<Review> getReviewsByUser(int userId) {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT * FROM reviews WHERE user_id = ? ORDER BY id DESC";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Review r = new Review();
                r.setId(rs.getInt("id"));
                r.setReviewerId(rs.getString("user_id"));
                r.setStallId(rs.getInt("stall_id"));
                r.setRating(rs.getInt("rating"));
                r.setComment(rs.getString("comment"));
                r.setImagePath(rs.getString("image_path"));

                reviews.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reviews;
    }

    // 6. Fetch a single review by ID (Used for Editing)
    public Review getReviewById(int id) {
        Review review = null;
        String sql = "SELECT * FROM reviews WHERE id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                review = new Review();
                review.setId(rs.getInt("id"));
                review.setReviewerId(rs.getString("user_id"));
                review.setStallId(rs.getInt("stall_id"));
                review.setRating(rs.getInt("rating"));
                review.setComment(rs.getString("comment"));
                review.setImagePath(rs.getString("image_path"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return review;
    }

    // 7. Update an existing review
    public void updateReview(Review review) {
        String sql;
        if (review.getImagePath() != null) {
            sql = "UPDATE reviews SET rating = ?, comment = ?, image_path = ? WHERE id = ?";
        } else {
            sql = "UPDATE reviews SET rating = ?, comment = ? WHERE id = ?";
        }

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, review.getRating());
            stmt.setString(2, review.getComment());

            if (review.getImagePath() != null) {
                stmt.setString(3, review.getImagePath());
                stmt.setInt(4, review.getId());
            } else {
                stmt.setInt(3, review.getId());
            }
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
