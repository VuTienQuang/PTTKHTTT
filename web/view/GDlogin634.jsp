<%@ page import="DAO.LoginDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }
        .login-container {
            width: 400px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            margin-top: 100px;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px 0px;
            margin: 5px 0 20px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        .error {
            color: red;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Login</h2>
        <form action="" method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" placeholder="Enter your username" required>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" placeholder="Enter your password" required>
            <input type="submit" value="Login">
            <!-- Hiển thị thông báo lỗi nếu có -->
            <%
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null) {
            %>
                <p class="error"><%= errorMessage %></p>
            <%
                }
            %>
        </form>
        <%
            // Xử lý đăng nhập khi form được submit
            if (request.getMethod().equalsIgnoreCase("POST")) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");

                LoginDAO loginDAO = new LoginDAO();
                String vitri = loginDAO.login(username, password);
      
            if (vitri.compareTo("KH") == 0 ) {
                // Nếu xác thực thành công, chuyển hướng đến trang khách hàng
                response.sendRedirect("view/GDKhachHang634.jsp");
            }else if(vitri.compareTo("QL") == 0){
                response.sendRedirect("view/GDQuanLy634.jsp");
            }
            else {
                // Nếu đăng nhập thất bại, quay lại trang login với thông báo lỗi
                response.sendRedirect("view/login.jsp");
            }
            }
        %>
        
    </div>
</body>
</html>
