package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.MonAn634;

public class TimKiemDAO634 extends DAO {

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
