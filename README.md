# 9LabOfTrinhDuyHieu

Bộ 9 bài Flutter của Trịnh Duy Hiếu, tùy chỉnh giao diện từ repository mẫu
https://github.com/abtplinh/9LabDaNenTang (commit 26ff05e).

## Các bài

| Thư mục | Ứng dụng | Điều chỉnh |
| --- | --- | --- |
| im_rich | I Am Rich | Thẻ ảnh, nền sáng, tiêu đề gọn |
| micard | Danh thiếp | Tên Trịnh Duy Hiếu, avatar chữ DH |
| dicee_app | Xúc xắc | Hai xúc xắc co theo màn hình, tổng điểm |
| magic_8_ball | Quả cầu | Thẻ màu nhẹ, nút hỏi lại |
| xylophone | Đàn nhạc | Phím bo góc có tên nốt, giải phóng audio khi đóng |
| quizzler | Trắc nghiệm | Tiến độ, chọn đáp án rồi tiếp tục, kết quả |
| boss_level_challenge2 | Destini | Thẻ truyện dễ đọc, nút lựa chọn rõ ràng |
| bmi_calculator | BMI | Thẻ nhập liệu, giới hạn số dương, kết quả gọn |
| clima | Thời tiết | Thẻ thời tiết, tìm thành phố, trạng thái tải/lỗi |

## Chạy

Cần Flutter có Dart >= 3.7.2 và < 4.0.0. Mỗi thư mục là một ứng dụng riêng.
Mở file `9LabOfTrinhDuyHieu.code-workspace` bằng VS Code/Cursor để mở cả 9 bài.

Trong terminal của ứng dụng muốn chạy:

```powershell
cd dicee_app
flutter pub get
flutter run
```

Hoặc từ thư mục bộ bài, chạy `.\setup.ps1` để tải dependencies cho cả 9 bài.
Chọn thiết bị bằng IDE hoặc `flutter devices`.

Clima sử dụng dịch vụ OpenWeatherMap như bản mẫu, cần Internet, API key hợp lệ
qua `--dart-define=OPENWEATHER_API_KEY=YOUR_KEY` khi chạy Flutter và quyền vị trí nếu dùng GPS.
Có thể tìm thành phố khi không có GPS.

## Cấu trúc giao diện

Mỗi bài có `lib/lab_ui.dart`: theme Material 3, màu xanh ngọc, thẻ bo góc,
chiều rộng tối đa 560 và nội dung cuộn cho màn hình nhỏ.
Các bản lab_ui.dart được giữ riêng để mỗi bài có thể copy và chạy độc lập.
Không thêm thư viện giao diện; tiếp tục dùng dependencies và assets của mẫu.
Các tệp build, cache và cấu hình SDK cũ không được đưa vào bản sao.


Nếu Windows báo "Building with plugins requires symlink support", bật Developer Mode
trong Settings > System > For developers rồi chạy lại setup.ps1.
Đây là yêu cầu của Flutter cho plugin desktop, thường gặp ở Xylophone/Clima.

## Kết quả kiểm tra

- Flutter 3.29.3 / Dart 3.7.2.
- Phân tích toàn bộ mã: No issues found.
- 9 bài kiểm tra widget đều đạt, với khung màn hình 360 x 640.
- Đã kiểm tra luồng tính BMI/quay lại, hoàn thành quiz/thử lại, lựa chọn truyện,
  thao tác xúc xắc/quả cầu, bố cục đàn nhạc và biểu mẫu tìm thành phố.
- Clima dùng dữ liệu mẫu trong kiểm tra, không gọi API thời tiết.
- Chưa kiểm tra âm thanh, GPS, API trực tiếp hoặc build Android/iOS trên thiết bị.

Chạy lại kiểm tra: vào thư mục từng ứng dụng rồi chạy `flutter test --no-pub`.
Phân tích cả bộ bài: chạy `dart analyze .` tại thư mục này.
