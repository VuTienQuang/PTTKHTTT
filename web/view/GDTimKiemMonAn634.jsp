<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="DAO.TimKiemDAO634" %>
<%@ page import="model.MonAn634" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tìm Kiếm Món Ăn</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
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
        input[type="text"] {
            width: 100%;
            padding: 10px 5px;
            margin-bottom: 10px;
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
        .result {
            margin-top: 20px;
        }
        .dish {
            padding: 10px;
            border-bottom: 1px solid #ccc;
        }
        .dish a {
            text-decoration: none;
            color: #4CAF50;
        }
        .dish a:hover {
            text-decoration: underline;
        }
        button {
            background-color: #28a745;
            color: #fff;
            border: none;
            padding: 12px 20px;
            cursor: pointer;
            font-size: 16px;
            border-radius: 4px;
            transition: background-color 0.3s ease;
            display: inline-block;
        }

        button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Tìm Kiếm Món Ăn</h2>
        <form action="" method="get">
            <input type="text" name="search" placeholder="Nhập tên món ăn hoặc thể loại..." required>
            <input type="submit" value="Tìm Kiếm">
        </form>

        <div class="result">
            <%
                String search = request.getParameter("search");
                if (search != null && !search.trim().isEmpty()) {
                    TimKiemDAO634 timKiemDAO = new TimKiemDAO634();
                    List<MonAn634> dsMonAn = timKiemDAO.timKiemMonAn(search);

                    if (dsMonAn.isEmpty()) {
            %>
                        <p>Không tìm thấy món ăn nào với từ khóa: <%= search %></p>
            <%
                    } else {
            %>
                        <h3>Kết quả tìm kiếm cho từ khóa: <%= search %></h3>
            <%
                        for (MonAn634 monAn : dsMonAn) {
                            int monAnId = monAn.getId(); // Giả sử MonAn có phương thức getId() để lấy ID
            %>
                            <div class="dish">
                                <a href="${pageContext.request.contextPath}/view/GDchiTietMonAn634.jsp?id=<%= monAnId %>">
                                    <%= monAn.getTenMon() %>
                                </a>
                            </div>
            <%
                        }
                    }
                }
            %>
        </div>
        <button class="back-button" onclick="window.location.href='${pageContext.request.contextPath}/view/GDKhachHang634.jsp'">
        Quay lại
        </button>
    </div>
</body>
</html>
