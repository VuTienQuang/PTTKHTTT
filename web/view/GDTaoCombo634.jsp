<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="DAO.ComBoDAO634" %>
<%@ page import="model.MonAn634" %>
<%@ page import="java.util.ArrayList" %>

<%
    ComBoDAO634 comboDAO = new ComBoDAO634();
    List<MonAn634> danhSachMonAn = comboDAO.layTatCaMonAn(); // Lấy danh sách món ăn
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tạo Combo Món Ăn</title>
    <style>
        /* CSS cho giao diện */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #333;
        }

        label {
            font-size: 14px;
            color: #555;
        }

        input[type="text"],
        input[type="number"],
        textarea {
            width: 100%;
            padding: 10px 0px;
            margin-top: 8px;
            margin-bottom: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        textarea {
            height: 80px;
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

        #danhSachKetQua li {
            background-color: #f8f9fa;
            margin: 5px 0;
            padding: 10px;
            border: 1px solid #ddd;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.2s ease;
            position: relative;
        }

        #danhSachKetQua li.selected {
            background-color: #d4edda;
            border-color: #28a745;
        }

        .checkmark {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            display: none;
            color: #28a745;
            font-size: 16px;
        }

        #danhSachKetQua li.selected .checkmark {
            display: inline;
        }
        
        #thongBao {
            color: red;
            font-size: 14px;
            margin-top: 10px;
            display: none;
        }
        
        #danhSachMonDaChon {
            margin-top: 20px;
        }
    </style>
    <script>
        let comboMonAn = []; // Lưu danh sách món ăn đã chọn
        let tenMonDaChon = []; // Lưu tên món ăn đã chọn
        let tongGiaCombo = 0; // Tổng giá combo

        // Hàm tìm món ăn với việc bảo toàn các món ăn đã chọn
        function timMonAn() {
            const tuKhoa = document.getElementById('tuKhoa').value.toLowerCase();
            const danhSachMonAn = document.querySelectorAll('.monAnItem');

            const danhSachKetQua = document.getElementById('danhSachKetQua');
            danhSachKetQua.innerHTML = '';

            danhSachMonAn.forEach(monAn => {
                const tenMon = monAn.textContent.toLowerCase();
                const theLoai = monAn.dataset.theloai.toLowerCase();

                if (tenMon.includes(tuKhoa) || theLoai.includes(tuKhoa)) {
                    const li = document.createElement('li');
                    li.textContent = monAn.textContent;
                    li.dataset.id = monAn.dataset.id;
                    li.dataset.gia = monAn.dataset.gia;

                    if (comboMonAn.includes(monAn.dataset.id)) {
                        li.classList.add('selected');
                    }

                    li.onclick = () => themMonAn(li);
                    const checkmark = document.createElement('span');
                    checkmark.classList.add('checkmark');
                    checkmark.innerHTML = '✔';
                    li.appendChild(checkmark);
                    danhSachKetQua.appendChild(li);
                }
            });
        }

        // Hàm xử lý khi thêm hoặc bỏ chọn món ăn
        function themMonAn(monAnElement) {
            const id = monAnElement.dataset.id;
            const tenMon = monAnElement.textContent.trim();
            const giaMon = parseInt(monAnElement.dataset.gia);

            if (!comboMonAn.includes(id)) {
                comboMonAn.push(id);
                tenMonDaChon.push(tenMon);
                tongGiaCombo += giaMon; // Cộng giá món vào tổng giá combo
                monAnElement.classList.add('selected');
            } else {
                comboMonAn = comboMonAn.filter(monAnId => monAnId !== id);
                tenMonDaChon = tenMonDaChon.filter(mon => mon !== tenMon);
                tongGiaCombo -= giaMon; // Trừ giá món khỏi tổng giá combo
                monAnElement.classList.remove('selected');
            }

            capNhatMonDaChon(); // Cập nhật ô văn bản món đã chọn
            capNhatGiaCombo(); // Cập nhật giá combo
        }

        // Hàm cập nhật danh sách món ăn đã chọn vào ô textarea
        function capNhatMonDaChon() {
            const danhSachMonDaChonTextarea = document.getElementById('danhSachMonDaChon');
            const tenMonDaChonChiTen = tenMonDaChon.map(mon => mon.split('(')[0].trim());
            danhSachMonDaChonTextarea.value = tenMonDaChonChiTen.join(', ');
        }

        // Hàm cập nhật giá combo
        function capNhatGiaCombo() {
            document.getElementById('giaCombo').value = tongGiaCombo;
        }

        // Lưu combo món ăn
        function luuCombo() {
            const tenCombo = document.getElementById('tenCombo').value;
            const giaCombo = document.getElementById('giaCombo').value;
            const moTa = document.getElementById('moTa').value;

            const form = document.createElement('form');
            form.method = 'POST';
            form.action = 'GDdoluu634.jsp';

            const inputTenCombo = document.createElement('input');
            inputTenCombo.type = 'hidden';
            inputTenCombo.name = 'tenCombo';
            inputTenCombo.value = tenCombo;
            form.appendChild(inputTenCombo);

            const inputGiaCombo = document.createElement('input');
            inputGiaCombo.type = 'hidden';
            inputGiaCombo.name = 'giaCombo';
            inputGiaCombo.value = giaCombo;
            form.appendChild(inputGiaCombo);

            const inputMoTa = document.createElement('input');
            inputMoTa.type = 'hidden';
            inputMoTa.name = 'moTa';
            inputMoTa.value = moTa;
            form.appendChild(inputMoTa);

            const monAnIds = JSON.stringify(comboMonAn);
            const inputMonAnIds = document.createElement('input');
            inputMonAnIds.type = 'hidden';
            inputMonAnIds.name = 'monAnIds';
            inputMonAnIds.value = monAnIds;
            form.appendChild(inputMonAnIds);

            document.body.appendChild(form);
            form.submit();
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Tạo Combo Món Ăn</h1>
        <label for="tenCombo">Tên Combo:</label>
        <input type="text" id="tenCombo" required><br>

        <label for="giaCombo">Giá Combo:</label>
        <input type="number" id="giaCombo" ><br>

        <label for="moTa">Mô Tả:</label>
        <textarea id="moTa" required></textarea><br>

        <label for="tuKhoa">Tìm Món:</label>
        <input type="text" id="tuKhoa" onkeyup="timMonAn()">
        <ul id="danhSachKetQua"></ul>
        <p id="thongBao">Không tìm thấy món ăn phù hợp</p>

        <label for="danhSachMonDaChon">Các món đã chọn:</label>
        <textarea id="danhSachMonDaChon" readonly></textarea><br>

        <button onclick="luuCombo()">Lưu Combo</button>

        <ul style="display: none;">
        <% for (MonAn634 monAn : danhSachMonAn) { %>
            <li class="monAnItem" data-id="<%= monAn.getId() %>" data-gia="<%= monAn.getGia() %>" data-theloai="<%= monAn.getTheLoai() %>">
                <%= monAn.getTenMon() %> (Giá: <%= monAn.getGia() %> VNĐ)
            </li>
        <% } %>
        </ul>
       <button class="back-button" onclick="window.location.href='${pageContext.request.contextPath}/view/GDQuanLyComBo634.jsp'">
        Quay lại
        </button>
    </div>
</body>
</html>
