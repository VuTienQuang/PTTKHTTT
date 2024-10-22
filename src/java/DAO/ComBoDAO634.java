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
        String sqlCombo = "SELECT tenCombo, combo_id FROM Combo634";
        String sqlMonAn = "SELECT ma.tenMon " +
                          "FROM Combo_MonAn634 cm " +
                          "JOIN MonAn634 ma ON cm.monan_id = ma.monan_id " +
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
