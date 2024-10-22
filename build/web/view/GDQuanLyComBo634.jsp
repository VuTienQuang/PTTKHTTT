<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="DAO.ComBoDAO634" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Combo</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        h2 {
            text-align: center;
            margin-bottom: 30px;
        }
        .combo-section {
            background-color: #fff;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        .combo-section h3 {
            margin-bottom: 10px;
        }
        .btn {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-align: center;
            border-radius: 5px;
            text-decoration: none;
            display: inline-block;
            margin-top: 20px;
        }
        .btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Quản Lý Combo</h2>

        <!-- Hiển thị danh sách combo -->
        <div class="combo-section">
            <h3>Các Combo Hiện Có</h3>
            <%
                // Khởi tạo DAO
                ComBoDAO634 comboDAO = new ComBoDAO634();
                // Lấy danh sách combo và món ăn đi kèm
                Map<String, List<String>> comboWithDishes = comboDAO.layTatCaComboVaMonAn();

                if (comboWithDishes.isEmpty()) {
            %>
                <p>Hiện tại chưa có combo nào.</p>
            <%
                } else {
                    for (Map.Entry<String, List<String>> entry : comboWithDishes.entrySet()) {
            %>
                <h4>Combo: <%= entry.getKey() %></h4>
                <p>Món ăn: <%= String.join(", ", entry.getValue()) %></p>
            <%
                    }
                }
            %>
        </div>

        <!-- Nút thêm combo mới -->
        <div class="combo-section">
            <h3>Thêm Combo Mới</h3>
            <a href="${pageContext.request.contextPath}/view/GDTaoCombo634.jsp" class="btn">Tạo Combo Mới</a>
        </div>
    </div>
</body>
</html>
