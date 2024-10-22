<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DAO.MonAnDAO634" %>
<%@ page import="model.MonAn634" %>
<%@ page import="java.io.IOException" %>
<%@ page import="jakarta.servlet.ServletException" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<%@ page import="jakarta.servlet.http.HttpServletResponse" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Món Ăn</title>
    <style>
        /* Styles for the detail page */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .back-button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
            margin-top: 20px;
        }
        .back-button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Chi Tiết Món Ăn</h2>
        <%
            String t = request.getParameter("id");
            int id = Integer.parseInt(t);
            MonAnDAO634 monAnDAO = new MonAnDAO634();
            MonAn634 monAn = monAnDAO.getMonAnById(id); // Phương thức để lấy chi tiết món ăn theo ID

            if (monAn != null) {
        %>
            <p><strong>Tên Món:</strong> <%= monAn.getTenMon() %></p>
            <p><strong>Giá:</strong> <%= monAn.getGia() %> VND</p>
            <p><strong>Thể Loại:</strong> <%= monAn.getTheLoai() %></p>
            <p><strong>Mô Tả:</strong> <%= monAn.getMota() %></p> <!-- Giả sử có phương thức getMoTa() -->
        <%
            } else {
        %>
            <p>Không tìm thấy thông tin chi tiết về món ăn.</p>
        <%
            }
        %>
        <a href="${pageContext.request.contextPath}/view/GDTimKiemMonAn634.jsp" class="back-button">Quay lại</a>
    </div>
</body>
</html>
