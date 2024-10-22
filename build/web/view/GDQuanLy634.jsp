<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Nhà Hàng</title>
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
        .section {
            background-color: #fff;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .btn {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-align: center;
            border-radius: 5px;
            text-decoration: none;
            display: inline-block;
            margin: 10px;
            width: 300px;
        }
        .btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Bảng Điều Khiển Quản Lý Nhà Hàng</h2>

        <!-- Chức năng Xem Thống Kê -->
        <div class="section">
            <h3>Chức Năng Quản Lý</h3>
            <a href="${pageContext.request.contextPath}/GDXemThongKe.jsp" class="btn">Xem Thống Kê</a>
            <a href="${pageContext.request.contextPath}/GDQuanLyMonAn.jsp" class="btn">Quản Lý Thông Tin Món Ăn</a>
            <a href="${pageContext.request.contextPath}/view/GDQuanLyComBo634.jsp" class="btn">Quản Lý Combo</a>
        </div>
    </div>
</body>
</html>
