package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.MonAn634;

public class TimKiemDAO634 extends DAO {
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
    // Phương thức tìm kiếm món ăn theo tên hoặc thể loại
    public List<MonAn634> timKiemMonAn(String keyword) {
        List<MonAn634> dsMonAn = new ArrayList<>();
        String sql = "SELECT * FROM tblmonan634 WHERE tenMon LIKE ? OR theLoai LIKE ?";

        try (Connection connection = getConnection(); // Sử dụng phương thức từ lớp DAO
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            // Sử dụng wildcard '%' cho tìm kiếm tương tự
            String searchPattern = "%" + keyword + "%";
            preparedStatement.setString(1, searchPattern);
            preparedStatement.setString(2, searchPattern);
            
            ResultSet resultSet = preparedStatement.executeQuery();

            // Duyệt qua kết quả và thêm các món ăn vào danh sách
            while (resultSet.next()) {
                MonAn634 monAn = new MonAn634();
                monAn.setId(resultSet.getInt("monan_id"));
                monAn.setTenMon(resultSet.getString("tenMon"));
                monAn.setGia(resultSet.getDouble("gia"));
                monAn.setTheLoai(resultSet.getString("theloai"));
                monAn.setMota(resultSet.getString("moTa"));
                // Các cột khác trong bảng MonAn có thể được lấy nếu cần

                dsMonAn.add(monAn); // Thêm món ăn vào danh sách
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dsMonAn;
    }
    public static void main(String[] args) {
        TimKiemDAO634 timkiem = new TimKiemDAO634();
        List<MonAn634> list = timkiem.timKiemMonAn("pho");
        if(list.isEmpty()){
            System.out.println("KO timthaays");
        }else{
            for(MonAn634 ma : list){
                System.out.println(ma.getTenMon());
            }
        }
    }
}
