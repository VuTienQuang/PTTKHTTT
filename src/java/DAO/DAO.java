package DAO;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DAO {

    // Thông tin về cơ sở dữ liệu
    private static final String URL = "jdbc:mysql://localhost:3306/restman";
    private static final String USER = "root";
    private static final String PASSWORD = "Toanthang2003";

    // Phương thức tạo kết nối đến cơ sở dữ liệu
    public static Connection getConnection() throws SQLException {
        Connection connection = null;
        try {
            // Tải driver JDBC
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Kết nối với cơ sở dữ liệu
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            throw new SQLException("Unable to connect to the database.");
        }
        return connection;
    }
//     public static void testConnection() {
//        try (Connection connection = getConnection()) {
//            if (connection != null) {
//                System.out.println("Kết nối đến cơ sở dữ liệu thành công!");
//            }
//        } catch (SQLException e) {
//            System.out.println("Kết nối đến cơ sở dữ liệu thất bại: " + e.getMessage());
//        }
//    }
//
//    public static void main(String[] args) {
//        testConnection();
//    }
    
}

