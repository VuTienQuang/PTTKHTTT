<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="DAO.MonAnDAO634" %>
<%@ page import="model.MonAn634" %>
<%@ page import="java.util.ArrayList" %>

<%
    MonAnDAO634 monAnDAO = new MonAnDAO634();
    List<MonAn634> danhSachMonAn = monAnDAO.layTatCaMonAn(); // Lấy danh sách món ăn
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tạo Combo Món Ăn</title>
    <style>
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

        #tuKhoa {
            width: calc(100% - 26px);
        }

        #danhSachKetQua {
            list-style-type: none;
            padding: 0;
        }

        #danhSachKetQua li {
            background-color: #f8f9fa;
            margin: 5px 0;
            padding: 10px;
            border: 1px solid #ddd;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.2s ease;
            position: relative; /* Để định vị dấu tích */
        }

        #danhSachKetQua li:hover {
            background-color: #e9ecef;
        }

        #danhSachKetQua li.selected {
            background-color: #d4edda;
            border-color: #28a745;
        }

        /* Định dạng dấu tích */
        #danhSachKetQua li .checkmark {
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

        // Hàm tìm món ăn với việc bảo toàn các món ăn đã chọn
        function timMonAn() {
    const tuKhoa = document.getElementById('tuKhoa').value.toLowerCase();
    const danhSachMonAn = document.querySelectorAll('.monAnItem'); // Lấy danh sách từ HTML

    const danhSachKetQua = document.getElementById('danhSachKetQua');
    danhSachKetQua.innerHTML = ''; // Xóa danh sách trước khi tìm kiếm mới

    danhSachMonAn.forEach(monAn => {
        const tenMon = monAn.textContent.toLowerCase();
        const theLoai = monAn.dataset.theloai.toLowerCase();

        // Kiểm tra nếu từ khóa nằm trong tên hoặc thể loại của món ăn
        if (tenMon.includes(tuKhoa) || theLoai.includes(tuKhoa)) {
            const li = document.createElement('li');
            li.textContent = monAn.textContent; // Hiển thị tên món ăn và thể loại
            li.dataset.id = monAn.dataset.id;

            // Kiểm tra nếu món ăn đã được chọn trước đó
            if (comboMonAn.includes(monAn.dataset.id)) {
                li.classList.add('selected'); // Đánh dấu món ăn đã được chọn
            }

            li.onclick = () => themMonAn(li); // Thêm sự kiện chọn món
            const checkmark = document.createElement('span');
            checkmark.classList.add('checkmark');
            checkmark.innerHTML = '✔'; // Dấu tích
            li.appendChild(checkmark);
            danhSachKetQua.appendChild(li);
        }
    });
     const thongBao = document.getElementById('thongBao');
            if (!timThayMonAn) {
                thongBao.style.display = 'block';
                thongBao.innerText = 'Không tìm thấy món ăn phù hợp';
            } else {
                thongBao.style.display = 'none';
            }
    
}


        // Hàm xử lý khi thêm hoặc bỏ chọn món ăn
        function themMonAn(monAnElement) {
            const id = monAnElement.dataset.id;
            const tenMon = monAnElement.textContent.trim();

            // Kiểm tra xem món ăn đã được chọn chưa
            if (!comboMonAn.includes(id)) {
                comboMonAn.push(id); // Thêm id món ăn vào danh sách combo
                tenMonDaChon.push(tenMon); // Thêm tên món ăn vào danh sách
                monAnElement.classList.add('selected'); // Đánh dấu món ăn đã chọn
            } else {
                // Nếu món ăn đã được chọn thì bỏ chọn
                comboMonAn = comboMonAn.filter(monAnId => monAnId !== id); // Loại bỏ món ăn khỏi danh sách
                tenMonDaChon = tenMonDaChon.filter(mon => mon !== tenMon); // Loại bỏ tên món ăn khỏi danh sách
                monAnElement.classList.remove('selected'); // Bỏ đánh dấu
            }

            capNhatMonDaChon(); // Cập nhật ô văn bản món đã chọn
        }

        // Hàm cập nhật danh sách món ăn đã chọn vào ô textarea
            function capNhatMonDaChon() {
            const danhSachMonDaChonTextarea = document.getElementById('danhSachMonDaChon');

            // Chỉ lấy tên món, không lấy phần thể loại (phần trong dấu ngoặc)
            const tenMonDaChonChiTen = tenMonDaChon.map(mon => {
                // Lấy phần trước dấu ngoặc, nếu có
                return mon.split('(')[0].trim();
            });

            // Cập nhật lại textarea chỉ với tên món ăn
            danhSachMonDaChonTextarea.value = tenMonDaChonChiTen.join(', ');
    }


        // Lưu combo món ăn
        function luuCombo() {
            const tenCombo = document.getElementById('tenCombo').value;
            const giaCombo = document.getElementById('giaCombo').value;
            const moTa = document.getElementById('moTa').value;

            // Chuyển hướng đến trang GDdoluu634.jsp để lưu combo
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

            // Chuyển đổi comboMonAn thành chuỗi JSON
            const monAnIds = JSON.stringify(comboMonAn);
            const inputMonAnIds = document.createElement('input');
            inputMonAnIds.type = 'hidden';
            inputMonAnIds.name = 'monAnIds';
            inputMonAnIds.value = monAnIds;
            form.appendChild(inputMonAnIds);

            document.body.appendChild(form); // Thêm form vào body
            form.submit(); // Gửi form
        }
    </script>
</head>
<body>
    <div class="container">
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
        <p id="thongBao">Không tìm thấy món ăn phù hợp</p>
        <!-- Ô textarea để hiển thị các món đã chọn -->
        <label for="danhSachMonDaChon">Các món đã chọn:</label>
        <textarea id="danhSachMonDaChon" readonly></textarea><br>

        <button onclick="luuCombo()">Lưu Combo</button>

        <!-- Danh sách món ăn (ẩn trong HTML) -->
        <ul style="display: none;">
        <% for (MonAn634 monAn : danhSachMonAn) { %>
            <li class="monAnItem" data-id="<%= monAn.getId() %>" data-theloai="<%= monAn.getTheLoai() %>">
                <%= monAn.getTenMon() %> (<%= monAn.getTheLoai() %>)
            </li>
        <% } %>
    </ul>

        <button class="back-button" onclick="window.location.href='${pageContext.request.contextPath}/view/GDQuanLyComBo634.jsp'">
        Quay lại
        </button>

    </div>
</body>
</html>
