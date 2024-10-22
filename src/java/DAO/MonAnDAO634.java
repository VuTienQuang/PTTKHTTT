package DAO;

import model.MonAn634;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MonAnDAO634 extends DAO {

   
    // Lấy chi tiết món ăn theo ID
    public MonAn634 getMonAnById(int id) {
        MonAn634 monAn = null;
        String sql = "SELECT * FROM MonAn634 WHERE monan_id = ?";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, id);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    monAn = new MonAn634();
                    monAn.setId(resultSet.getInt("monan_id"));
                    monAn.setTenMon(resultSet.getString("tenMon"));
                    monAn.setGia(resultSet.getDouble("gia"));
                    monAn.setTheLoai(resultSet.getString("theLoai"));
                    monAn.setMota(resultSet.getString("moTa"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return monAn;
    }
    public static void main(String[] args) {
         MonAnDAO634 monAnDao = new MonAnDAO634();
        int idMonAn = 1; // Thay đổi ID của món ăn nếu cần
        System.out.println("\nChi tiết món ăn có ID = " + idMonAn + ":");
        MonAn634 monAnDetails = monAnDao.getMonAnById(idMonAn);
        if (monAnDetails != null) {
            System.out.println("ID: " + monAnDetails.getId());
            System.out.println("Tên: " + monAnDetails.getTenMon());
            System.out.println("Giá: " + monAnDetails.getGia());
            System.out.println("Thể loại: " + monAnDetails.getTheLoai());
            System.out.println("Mô tả: " + monAnDetails.getMota());
        } else {
            System.out.println("Không tìm thấy món ăn với ID = " + idMonAn);
        }
    }
}

