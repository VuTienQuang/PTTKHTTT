package DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ComBoDAO634 extends DAO {
    
    // Phương thức lấy tất cả combo và món ăn đi kèm
    public Map<String, List<String>> layTatCaComboVaMonAn() {
        Map<String, List<String>> comboMap = new HashMap<>();
        String sqlCombo = "SELECT tenCombo, combo_id FROM tblCombo634";
        String sqlMonAn = "SELECT ma.tenMon " +
                          "FROM tblCombo_MonAn634 cm " +
                          "JOIN tblMonAn634 ma ON cm.monan_id = ma.monan_id " +
                          "WHERE cm.combo_id = ?";

        try (Connection connection = getConnection();
             PreparedStatement psCombo = connection.prepareStatement(sqlCombo);
             ResultSet resultSet = psCombo.executeQuery()) {

            while (resultSet.next()) {
                String comboName = resultSet.getString("tenCombo");
                int comboId = resultSet.getInt("combo_id");
                List<String> dishList = new ArrayList<>();

                // Lấy danh sách món ăn cho combo hiện tại
                try (PreparedStatement psMonAn = connection.prepareStatement(sqlMonAn)) {
                    psMonAn.setInt(1, comboId);
                    ResultSet dishResultSet = psMonAn.executeQuery();

                    while (dishResultSet.next()) {
                        dishList.add(dishResultSet.getString("tenMon"));
                    }
                }

                comboMap.put(comboName, dishList); // Lưu combo và danh sách món ăn
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return comboMap;
    }
    
    
    public boolean luuCombo(String tenCombo, double giaCombo, String moTa, List<Integer> monAnIds) {
        String sqlCombo = "INSERT INTO tblCombo634 (tenCombo, giaCombo, moTa) VALUES (?, ?, ?)";
        String sqlComboMonAn = "INSERT INTO tblCombo_MonAn634 (combo_id, monan_id) VALUES (?, ?)";
        boolean isSuccess = false;

        try (Connection connection = getConnection();
             PreparedStatement psCombo = connection.prepareStatement(sqlCombo, Statement.RETURN_GENERATED_KEYS)) {

            // Thêm combo vào bảng Combo634
            psCombo.setString(1, tenCombo);
            psCombo.setDouble(2, giaCombo);
            psCombo.setString(3, moTa);
            int rowsAffected = psCombo.executeUpdate();

            if (rowsAffected > 0) {
                // Lấy ID của combo vừa thêm
                try (ResultSet generatedKeys = psCombo.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int comboId = generatedKeys.getInt(1);

                        // Thêm các món ăn vào bảng Combo_MonAn634
                        try (PreparedStatement psMonAn = connection.prepareStatement(sqlComboMonAn)) {
                            for (Integer monAnId : monAnIds) {
                                psMonAn.setInt(1, comboId);
                                psMonAn.setInt(2, monAnId);
                                psMonAn.addBatch(); // Thêm vào batch
                            }
                            psMonAn.executeBatch(); // Thực hiện batch
                        }
                        isSuccess = true; // Lưu thành công
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isSuccess;
    }
    
    
    public static void main(String[] args) {
        ComBoDAO634 comboDAO = new ComBoDAO634();
        Map<String, List<String>> comboWithDishes = comboDAO.layTatCaComboVaMonAn();

// Ví dụ hiển thị kết quả
            for (Map.Entry<String, List<String>> entry : comboWithDishes.entrySet()) {
                System.out.println("Combo: " + entry.getKey());
                System.out.println("Món ăn: " + String.join(", ", entry.getValue()));
            }
    }
}
