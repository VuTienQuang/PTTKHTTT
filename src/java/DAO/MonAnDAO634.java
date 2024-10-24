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
        String sql = "SELECT * FROM tblMonAn634 WHERE monan_id = ?";

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
    
    
    public List<MonAn634> layTatCaMonAn() {
        List<MonAn634> danhSachMonAn = new ArrayList<>();
        String sql = "SELECT * FROM tblmonan634"; // Giả sử bảng là MonAn634

        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet resultSet = ps.executeQuery()) {

            while (resultSet.next()) {
                // Giả sử các cột trong bảng là monan_id, tenMon, gia, moTa
                int id = resultSet.getInt("monan_id");
                String tenMon = resultSet.getString("tenMon");
                double gia = resultSet.getDouble("gia");
                String theLoai = resultSet.getString("theLoai");
                String moTa = resultSet.getString("moTa");

                // Tạo đối tượng MonAn634 và thêm vào danh sách
                MonAn634 monAn = new MonAn634(id, tenMon, gia, theLoai, moTa);
                danhSachMonAn.add(monAn);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return danhSachMonAn;
    }
     public static void main(String[] args) {
        // Tạo đối tượng MonAnDAO634
        MonAnDAO634 monAnDAO = new MonAnDAO634();

        // Gọi phương thức layTatCaMonAn để lấy danh sách món ăn
        List<MonAn634> danhSachMonAn = monAnDAO.layTatCaMonAn();

        // In ra danh sách món ăn
        
        System.out.println("Danh sách món ăn:");
        for (MonAn634 monAn : danhSachMonAn) {
            System.out.println("ID: " + monAn.getId() + ", Tên: " + monAn.getTenMon() + 
                               ", Giá: " + monAn.getGia() + ", Mô tả: " + monAn.getMota());
           
        }
    }
}

