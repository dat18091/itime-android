import 'dart:convert';


List<Employee> employeeFromJson(String str) => List<Employee>.from(json.decode(str).map((x) => Employee.fromJson(x)));

String employeeToJson(List<Employee> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Employee {

  String maNhanVien;
  String tenNhanVien;
  String soDienThoaiNhanVien;
  String emailNhanVien;
  DateTime ngaySinhNhanVien;
  bool gioiTinhNhanVien;
  String hinhAnhNhanVien;
  String thuTuHienThiNv;
  String soCmnd;
  DateTime ngayCapCmnd;
  String noiCapCmnd;
  String soHoChieu;
  DateTime ngayCapHoChieu;
  DateTime ngayHetHanHoChieu;
  String noiCapHoChieu;
  BigInt maCongTy;
  String ghiChuNhanVien;
  BigInt maVung;
  BigInt maChiNhanh;
  BigInt maPhongBan;
  BigInt maNhomTruyCap;
  BigInt maChucDanh;
  String hoatDong;
  String quyenTruongPhong;
  String chuTaiKhoanNganHang;
  String soTaiKhoanNganHang;
  String tenNganHang;
  String chiNhanhNganHang;
  String tenDangNhap;
  String matKhau;
  BigInt provinceId;
  BigInt districtId;
  DateTime createdAt;
  DateTime updatedAt;
  String diaChiHienTai;

  Employee(
      {this.maNhanVien,
        this.tenNhanVien,
        this.soDienThoaiNhanVien,
        this.emailNhanVien,
        this.ngaySinhNhanVien,
        this.gioiTinhNhanVien,
        this.hinhAnhNhanVien,
        this.thuTuHienThiNv,
        this.soCmnd,
        this.ngayCapCmnd,
        this.noiCapCmnd,
        this.soHoChieu,
        this.ngayCapHoChieu,
        this.ngayHetHanHoChieu,
        this.noiCapHoChieu,
        this.maCongTy,
        this.ghiChuNhanVien,
        this.maVung,
        this.maChiNhanh,
        this.maPhongBan,
        this.maNhomTruyCap,
        this.maChucDanh,
        this.hoatDong,
        this.quyenTruongPhong,
        this.chuTaiKhoanNganHang,
        this.soTaiKhoanNganHang,
        this.tenNganHang,
        this.chiNhanhNganHang,
        this.tenDangNhap,
        this.matKhau,
        this.provinceId,
        this.districtId,
        this.createdAt,
        this.updatedAt,
        this.diaChiHienTai});

  Employee.fromJson(Map<String, dynamic> json) {
    maNhanVien = json['ma_nhan_vien'];
    tenNhanVien = json['ten_nhan_vien'];
    soDienThoaiNhanVien = json['so_dien_thoai_nhan_vien'];
    emailNhanVien = json['email_nhan_vien'];
    ngaySinhNhanVien = json['ngay_sinh_nhan_vien'];
    gioiTinhNhanVien = json['gioi_tinh_nhan_vien'];
    hinhAnhNhanVien = json['hinh_anh_nhan_vien'];
    thuTuHienThiNv = json['thu_tu_hien_thi_nv'];
    soCmnd = json['so_cmnd'];
    ngayCapCmnd = json['ngay_cap_cmnd'];
    noiCapCmnd = json['noi_cap_cmnd'];
    soHoChieu = json['so_ho_chieu'];
    ngayCapHoChieu = json['ngay_cap_ho_chieu'];
    ngayHetHanHoChieu = json['ngay_het_han_ho_chieu'];
    noiCapHoChieu = json['noi_cap_ho_chieu'];
    maCongTy = json['ma_cong_ty'];
    ghiChuNhanVien = json['ghi_chu_nhan_vien'];
    maVung = json['ma_vung'];
    maChiNhanh = json['ma_chi_nhanh'];
    maPhongBan = json['ma_phong_ban'];
    maNhomTruyCap = json['ma_nhom_truy_cap'];
    maChucDanh = json['ma_chuc_danh'];
    hoatDong = json['hoat_dong'];
    quyenTruongPhong = json['quyen_truong_phong'];
    chuTaiKhoanNganHang = json['chu_tai_khoan_ngan_hang'];
    soTaiKhoanNganHang = json['so_tai_khoan_ngan_hang'];
    tenNganHang = json['ten_ngan_hang'];
    chiNhanhNganHang = json['chi_nhanh_ngan_hang'];
    tenDangNhap = json['ten_dang_nhap'];
    matKhau = json['mat_khau'];
    provinceId = json['province_id'];
    districtId = json['district_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    diaChiHienTai = json['dia_chi_hien_tai'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ma_nhan_vien'] = this.maNhanVien;
    data['ten_nhan_vien'] = this.tenNhanVien;
    data['so_dien_thoai_nhan_vien'] = this.soDienThoaiNhanVien;
    data['email_nhan_vien'] = this.emailNhanVien;
    data['ngay_sinh_nhan_vien'] = this.ngaySinhNhanVien;
    data['gioi_tinh_nhan_vien'] = this.gioiTinhNhanVien;
    data['hinh_anh_nhan_vien'] = this.hinhAnhNhanVien;
    data['thu_tu_hien_thi_nv'] = this.thuTuHienThiNv;
    data['so_cmnd'] = this.soCmnd;
    data['ngay_cap_cmnd'] = this.ngayCapCmnd;
    data['noi_cap_cmnd'] = this.noiCapCmnd;
    data['so_ho_chieu'] = this.soHoChieu;
    data['ngay_cap_ho_chieu'] = this.ngayCapHoChieu;
    data['ngay_het_han_ho_chieu'] = this.ngayHetHanHoChieu;
    data['noi_cap_ho_chieu'] = this.noiCapHoChieu;
    data['ma_cong_ty'] = this.maCongTy;
    data['ghi_chu_nhan_vien'] = this.ghiChuNhanVien;
    data['ma_vung'] = this.maVung;
    data['ma_chi_nhanh'] = this.maChiNhanh;
    data['ma_phong_ban'] = this.maPhongBan;
    data['ma_nhom_truy_cap'] = this.maNhomTruyCap;
    data['ma_chuc_danh'] = this.maChucDanh;
    data['hoat_dong'] = this.hoatDong;
    data['quyen_truong_phong'] = this.quyenTruongPhong;
    data['chu_tai_khoan_ngan_hang'] = this.chuTaiKhoanNganHang;
    data['so_tai_khoan_ngan_hang'] = this.soTaiKhoanNganHang;
    data['ten_ngan_hang'] = this.tenNganHang;
    data['chi_nhanh_ngan_hang'] = this.chiNhanhNganHang;
    data['ten_dang_nhap'] = this.tenDangNhap;
    data['mat_khau'] = this.matKhau;
    data['province_id'] = this.provinceId;
    data['district_id'] = this.districtId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['dia_chi_hien_tai'] = this.diaChiHienTai;
    return data;
  }
}