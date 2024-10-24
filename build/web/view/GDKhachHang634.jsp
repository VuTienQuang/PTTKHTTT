<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giao diện khách hàng</title>
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
        }
        .section h3 {
            margin-bottom: 10px;
        }
        input[type="text"], input[type="date"], input[type="time"], select {
            width: 100%;
            padding: 10px 0px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        
        input[type="submit"] {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        .button {
            display: inline-block;
            padding: 10px 20px;
            margin-top: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            text-align: center;
        }
        .button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Giao diện khách hàng</h2>
        
        <!-- Tìm kiếm món ăn -->
        <div class="section">
            <h3>Tìm Kiếm Món Ăn</h3>
            <a href="${pageContext.request.contextPath}/view/GDTimKiemMonAn634.jsp" class="button">Tìm Kiếm Món Ăn</a>
        </div>

        <!-- Đặt bàn -->
        <div class="section">
            <h3>Đặt Bàn</h3>
            <a href="" class="button">Đặt Bàn</a>
        </div>

        <!-- Đặt món ăn -->
        <div class="section">
            <h3>Đặt Món Ăn</h3>
            <a href="" class="button">Đặt Món Ăn</a>
        </div>
    </div>
</body>
</html>
