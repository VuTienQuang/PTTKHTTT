<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="DAO.MonAnDAO634" %>
<%@ page import="DAO.ComBoDAO634" %>
<%@ page import="model.MonAn634" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.ArrayList" %>

<%
    MonAnDAO634 monAnDAO = new MonAnDAO634();
    ComBoDAO634 comboDAO = new ComBoDAO634();
    List<MonAn634> danhSachMonAn = monAnDAO.layTatCaMonAn(); // Lấy danh sách món ăn
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tạo Combo Món Ăn</title>
    <script>
        let comboMonAn = []; // Lưu danh sách món ăn đã chọn

        function timMonAn() {
            const tuKhoa = document.getElementById('tuKhoa').value.toLowerCase();
            const danhSachMonAn = <%= new Gson().toJson(danhSachMonAn) %>; // Chuyển đổi danh sách món ăn sang JSON

            const ketQuaTimKiem = danhSachMonAn.filter(monAn => {
                return monAn.getTenMon().toLowerCase().includes(tuKhoa);
            });

            const danhSachKetQua = document.getElementById('danhSachKetQua');
            danhSachKetQua.innerHTML = ''; // Xóa danh sách trước khi tìm kiếm mới

            ketQuaTimKiem.forEach((monAn, index) => {
                const li = document.createElement('li');
                li.textContent = `${monAn.getTenMon()}`;
                li.onclick = () => themMonAn(monAn.getId()); // Thêm sự kiện cho mỗi món ăn
                danhSachKetQua.appendChild(li);
            });
        }

        function themMonAn(id) {
            comboMonAn.push(id);
            alert("Món ăn đã được thêm vào combo.");
        }

        function luuCombo() {
            const tenCombo = document.getElementById('tenCombo').value;
            const giaCombo = document.getElementById('giaCombo').value;
            const moTa = document.getElementById('moTa').value;

            // Gọi phương thức lưu trong ComBoDAO634
            const success = <%= comboDAO.luuCombo(tenCombo, 0, moTa, comboMonAn) %>; // Giá Combo tạm thời là 0

            if (success) {
                alert("Combo đã được lưu thành công.");
                window.location.reload(); // Tải lại trang
            } else {
                alert("Lưu combo thất bại.");
            }
        }
    </script>
</head>
<body>
    <h1>Tạo Combo Món Ăn</h1>
    <label for="tenCombo">Tên Combo:</label>
    <input type="text" id="tenCombo" required><br>

    <label for="giaCombo">Giá Combo:</label>
    <input type="number" id="giaCombo" required><br>

    <label for="moTa">Mô Tả:</label>
    <textarea id="moTa" required></textarea><br>

    <label for="tuKhoa">Tìm Món:</label>
    <input type="text" id="tuKhoa" onkeyup="timMonAn()">
    <ul id="danhSachKetQua"></ul>

    <button onclick="luuCombo()">Lưu Combo</button>
</body>
</html>
