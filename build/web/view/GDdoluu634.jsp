<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="DAO.ComBoDAO634" %>


<%
    // Khởi tạo đối tượng ComBoDAO634
    ComBoDAO634 comBoDAO = new ComBoDAO634();

    // Lấy dữ liệu từ biểu mẫu
    String tenCombo = request.getParameter("tenCombo");
    String giaCombo = request.getParameter("giaCombo");
    String moTa = request.getParameter("moTa");
    
    // Chuyển đổi chuỗi monAnIds thành danh sách số nguyên
    List<Integer> monAnIds = new ArrayList<>();
    String[] ids = request.getParameterValues("monAnIds") != null ?
            request.getParameterValues("monAnIds")[0].replace("[", "").replace("]", "").split(",") : null;
    

    if (ids != null) {
        for (String id : ids) {
            monAnIds.add(Integer.parseInt(id.replace("\"", "").trim()));  // In ra từng giá trị của ids
        }
    } else {
        out.println("<p>Không có ID nào được truyền.</p>");
    }
            

    // Lưu combo và các món ăn liên quan
    boolean isSuccess = comBoDAO.luuCombo(tenCombo, Double.parseDouble(giaCombo), moTa, monAnIds);

    if (isSuccess) {
        out.println("<h3>Lưu combo thành công!</h3>");
    } else {
        out.println("<h3>Đã xảy ra lỗi trong quá trình lưu combo.</h3>");
    }
%>

<button class="back-button" onclick="window.location.href='${pageContext.request.contextPath}/view/GDTaoCombo634.jsp'">
        Quay lại trang chính
</button>
        
        <style>
    .back-button {
        display: inline-block;
        padding: 12px 24px;
        background-color: #007bff; /* Màu nền */
        color: #fff; /* Màu chữ */
        font-size: 16px;
        font-weight: bold;
        border: none; /* Xóa đường viền */
        border-radius: 5px; /* Bo góc */
        cursor: pointer; /* Con trỏ chuột */
        transition: background-color 0.3s ease; /* Hiệu ứng chuyển màu */
    }

    .back-button:hover {
        background-color: #0056b3; /* Màu nền khi hover */
    }

    .back-button:active {
        background-color: #004494; /* Màu nền khi click */
    }

    .back-button:focus {
        outline: none; /* Xóa đường viền khi focus */
    }
    .success-message {
        color: #28a745; /* Màu xanh lá cho thông báo thành công */
        font-size: 18px;
        font-weight: bold;
        background-color: #d4edda; /* Màu nền nhạt */
        padding: 10px;
        border: 1px solid #c3e6cb; /* Đường viền */
        border-radius: 4px; /* Bo góc */
        text-align: center; /* Căn giữa nội dung */
        margin-top: 20px;
    }

    .error-message {
        color: #dc3545; /* Màu đỏ cho thông báo lỗi */
        font-size: 18px;
        font-weight: bold;
        background-color: #f8d7da; /* Màu nền nhạt */
        padding: 10px;
        border: 1px solid #f5c6cb; /* Đường viền */
        border-radius: 4px; /* Bo góc */
        text-align: center; /* Căn giữa nội dung */
        margin-top: 20px;
    }
</style>