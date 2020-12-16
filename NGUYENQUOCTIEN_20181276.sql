
FROM CAUTHU;

SELECT *
FROM HUANLUYENVIEN;

SELECT *
FROM QUOCGIA;

SELECT *
FROM SANVD;

SELECT *


SELECT *
FROM HLV_CLB;

--Bai thuc hanh so 2
--1a.Cho biết thông tin (mã cầu thủ, họ tên, số áo, vị trí, ngày sinh, địa chỉ) của tất cả các cầu thủ
SELECT MACT, HOTEN, SO, VITRI, NGAYSINH, DIACHI
FROM CAUTHU;

--2a.Hiển thị thông tin tất cả các cầu thủ có số áo là 7 chơi ở vị trí Tiền vệ.
SELECT *
FROM CAUTHU
WHERE SO = 7 AND VITRI = N'Tiền vệ';

--3a.Cho biết tên, ngày sinh, địa chỉ, điện thoại của tất cả các huấn luyện viên.
SELECT TENHLV, NGAYSINH, DIACHI, DIENTHOAI
FROM HUANLUYENVIEN;

--4a.Hiển thi thông tin tất cả các cầu thủ có quốc tịch Việt Nam thuộc câu lạc bộ Becamex Bình Dương
SELECT ct.*
FROM CAUTHU as ct, CAULACBO as clb
WHERE ct.MACLB = clb.MACLB AND clb.TENCLB = N'Becamex Bình Dương';

--5a.Cho biết mã số, họ tên, ngày sinh, địa chỉ và vị trí của các cầu thủ thuộc đội bóng ‘SHB Đà Nẵng’ có quốc tịch “Bra-xin”
SELECT ct.MACT, ct.HOTEN, ct.NGAYSINH, ct.DIACHI, ct.VITRI
FROM CAUTHU as ct, CAULACBO as clb, QUOCGIA as qg
WHERE ct.MACLB = clb.MACLB AND clb.TENCLB = N'SHB Đà Nẵng' AND ct.MAQG = qg.MAQG AND qg.TENQG = N'Brazil';

--6a.Hiển thị thông tin tất cả các cầu thủ đang thi đấu trong câu lạc bộ có sân nhà là “Long An”
SELECT ct.*
FROM CAUTHU as ct, CAULACBO as clb, SANVD as svd
WHERE ct.MACLB = clb.MACLB AND clb.MASAN = svd.MASAN AND svd.TENSAN = N'Sân Long An';

--7a.Cho biết kết quả (MATRAN, NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) các trận đấu vòng 2 của mùa bóng năm 2009
SELECT td.MATRAN, td.NGAYTD, svd.TENSAN, clb1.TENCLB, clb2.TENCLB
FROM TRANDAU as td, CAULACBO as clb1, CAULACBO as clb2, SANVD as svd
WHERE td.VONG = 2 AND td.NAM = 2009 AND clb1.MACLB = td.MACLB1 AND clb2.MACLB = td.MACLB2 AND td.MASAN = svd.MASAN;

-- 8a. Cho biết mã huấn luyện viên, họ tên, ngày sinh, địa chỉ, vai trò và tên CLB đang làm veiecj của các huấn luyện viên có quốc tịch “ViệtNam”
SELECT hlv.MAHLV, hlv.TENHLV, hlv.NGAYSINH, hlv.DIACHI, HLV_CLB.VAITRO, clb.TENCLB
FROM HUANLUYENVIEN as hlv, HLV_CLB, QUOCGIA as qg, CAULACBO as clb
WHERE hlv.MAHLV = HLV_CLB.MAHLV AND hlv.MAQG = qg.MAQG AND qg.TENQG LIKE N'Việt Nam' AND HLV_CLB.MACLB = clb.MACLB;
-- 9a. Lấy tên 3 câu lạc bộ có điểm cao nhất sau vòng 3 năm 2009
SELECT TOP 3 clb.TENCLB
FROM CAULACBO as clb, BANGXH as bxh
WHERE bxh.MACLB = clb.MACLB AND bxh.VONG = 3
ORDER BY bxh.DIEM DESC

-- 10a. Cho biết mã huấn luyện viên, họ tên, ngày sinh, địa chỉ, vai trò và tên CLB đang làm việc mà câu lạc bộ đó đóng ở tỉnh Binh Dương.
SELECT hlv.MAHLV, hlv.TENHLV, hlv.NGAYSINH, hlv.DIACHI, HLV_CLB.VAITRO, clb.TENCLB
FROM HUANLUYENVIEN as hlv, HLV_CLB, TINH, CAULACBO as clb
WHERE hlv.MAHLV = HLV_CLB.MAHLV AND HLV_CLB.MACLB = clb.MACLB AND clb.MATINH = TINH.MATINH AND TINH.TENTINH LIKE N'Bình Dương';

-- 1b. Thống kê số lượng cầu thủ của mỗi câu lạc bộ
SELECT COUNT(*), clb.MACLB
FROM CAULACBO as clb, CAUTHU as ct
WHERE clb.MACLB = ct.MACLB
GROUP BY clb.MACLB;
-- 2b. Thống kê số lượng cầu thủ nước ngoài (có quốc tịch Việt Nam) của mỗi câu lạc bộ
SELECT COUNT(*), clb.MACLB
FROM CAULACBO as clb, CAUTHU as ct, QUOCGIA as qg
WHERE clb.MACLB = ct.MACLB AND qg.MAQG = ct.MAQG AND qg.TENQG != N'Việt Nam'
GROUP BY clb.MACLB;
-- 3b. Cho biết mã câu lạc bộ, tên câu lạc bộ, tên sân vận động, địa chỉ và số lượng cầu thủ nước ngoài (có quốc tịch khác Việt Nam) tương ứng của các câu lạc bộ có nhiều hơn 2 cầu thủ nước ngoài.
SELECT clb.MACLB, clb.TENCLB, svd.TENSAN, TINH.TENTINH, COUNT(*)
FROM CAULACBO as clb, CAUTHU as ct, TINH, SANVD as svd, QUOCGIA as qg
WHERE clb.MACLB = ct.MACLB AND svd.MASAN = clb.MASAN AND qg.MAQG = ct.MAQG AND qg.TENQG != N'Việt Nam' AND TINH.MATINH = clb.MATINH
GROUP BY clb.MACLB, clb.TENCLB, svd.TENSAN, TINH.TENTINH
HAVING COUNT(*) > 2;
/*4.  Cho biết tên tỉnh, số lượng cầu thủ đang t hi đấu ở vị trí tiền đạo trong các câu lạc
bộ thuộc địa bàn tỉnh đó quản l */
	select TINH.TENTINH , COUNT(CAUTHU.MACT) AS SoCT
	FROM TINH 
	JOIN CAULACBO
	ON TINH.MATINH = CAULACBO.MATINH
	JOIN CAUTHU
	ON CAULACBO.MACLB = CAUTHU.MACLB AND CAUTHU.VITRI LIKE N'Tiền đạo'
	group by CAULACBO.MACLB,TINH.TENTINH;

/*5. Cho biết tên câu lạc bộ, tên tỉnh mà CLB đang đóng nằm ở vị trí cao nhất của bảng
xếp hạng vòng 3, năm 2009*/
	select TENCLB, TENTINH
	from CAULACBO, TINH, BANGXH
	where BANGXH.HANG=1 and BANGXH.VONG=3
	and BANGXH.MACLB = CAULACBO.MACLB
	and CAULACBO.MATINH = TINH.MATINH;

/*c. Các toán tử nâng cao
1. Cho biết tên huấn luyện viên đang nắm giữ một vị trí trong một câu lạc bộ mà
chưa có số điện thoại
*/
	select TENHLV
	from HUANLUYENVIEN , HLV_CLB
	where HUANLUYENVIEN.MAHLV = HLV_CLB.MAHLV
	and HLV_CLB.VAITRO is not null
	and HUANLUYENVIEN.DIENTHOAI is null;

/*2. Liệt kê các huấn luyện viên thuộc quốc gia Việt Nam chưa làm công tác huấn luyện
tại bất kỳ một câu lạc bộ nào*/
	select *
	from HUANLUYENVIEN 
	left join HLV_CLB
	on HUANLUYENVIEN.MAHLV = HLV_CLB.MAHLV
	where HUANLUYENVIEN.MAQG = 'VN'
	and HLV_CLB.VAITRO is null;

/*3. Liệt kê các cầu thủ đang thi đấu trong các câu lạc bộ có thứ hạng ở vòng 3 năm 2009
lớn hơn 6 hoặc nhỏ hơn 3 */
	select CAUTHU.MACT, CAUTHU.HOTEN , CAUTHU.MACLB
	from BANGXH
	join CAULACBO 
	on BANGXH.VONG =3 and (BANGXH.HANG>6 or BANGXH.HANG<3)
	join CAUTHU
	on CAULACBO.MACLB = CAUTHU.MACLB;
/*4. Cho biết danh sách các trận đấu (NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA)
của câu lạc bộ (CLB) đang xếp hạng cao nhất tính đến hết vòng 3 năm 2009 .*/
	select NGAYTD, SANVD.TENSAN, CLB1.TENCLB, CLB2.TENCLB, KETQUA
	from TRANDAU, SANVD, CAULACBO CLB1, CAULACBO CLB2, 
		(select top(1) MACLB, sum(DIEM) as DIEM from BANGXH 
					where BANGXH.VONG <4
					group by MACLB 
					order by DIEM DESC) as XHCLB 
	where (TRANDAU.MACLB1 = XHCLB.MACLB or TRANDAU.MACLB2=XHCLB.MACLB)
	and TRANDAU.MASAN = SANVD.MASAN
	and TRANDAU.MACLB1 = CLB1.MACLB
	and TRANDAU.MACLB2 = CLB2.MACLB;
