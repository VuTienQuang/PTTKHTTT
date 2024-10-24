package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author laptop hoangkhuong
 */
public class LoginDAO extends DAO{
     public String login(String username, String password) {
        String vitri = null; // Biến lưu trữ vị trí nếu đăng nhập thành công
        String sql = "SELECT vitri FROM tblTaiKhoan634 WHERE username = ? AND password = ?";

        try (Connection connection = DAO.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);
            ResultSet resultSet = preparedStatement.executeQuery();

            // Kiểm tra xem có kết quả trả về không
            if (resultSet.next()) {
                vitri = resultSet.getString("vitri"); // Đăng nhập thành công, lấy giá trị vị trí
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vitri; // Trả về vị trí nếu thành công, null nếu không thành công
    }
     public static void main(String[] args) {
        LoginDAO logindao = new LoginDAO();
        String username = "KH"; // Thay đổi theo tên tài khoản bạn muốn kiểm tra
        String password = "KH"; // Thay đổi theo mật khẩu bạn muốn kiểm tra

        String vitri = logindao.login(username, password);
        if (vitri != null) {
            System.out.println("Đăng nhập thành công! Vị trí: " + vitri);
        } else {
            System.out.println("Tên đăng nhập hoặc mật khẩu không đúng.");
        }
    }
}
