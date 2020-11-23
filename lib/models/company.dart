import 'dart:convert';

List<Company> companyFromJson(String str) => List<Company>.from(json.decode(str).map((x) => Company.fromJson(x)));

String companyToJson(List<Company> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Company {
  Company({
    this.id,
    this.tenCongTy,
    this.tenTruyCap,
    this.matKhau,
    this.provinceId,
    this.districtId,
    this.loaiHinhDoanhNghiep,
    this.hinhAnhCongTy,
    this.diaChiCongTy,
    this.soDienThoaiCongTy,
    this.ghiChuCongTy,
    this.websiteCongTy,
    this.emailCongTy,
    this.ngayThanhLap,
    this.tenNganHangCongTy,
    this.soTaiKhoanCongTy,
    this.maSoThue,
    this.rolesId,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String tenCongTy;
  String tenTruyCap;
  String matKhau;
  String provinceId;
  String districtId;
  String loaiHinhDoanhNghiep;
  String hinhAnhCongTy;
  String diaChiCongTy;
  String soDienThoaiCongTy;
  String ghiChuCongTy;
  String websiteCongTy;
  String emailCongTy;
  DateTime ngayThanhLap;
  String tenNganHangCongTy;
  String soTaiKhoanCongTy;
  String maSoThue;
  String rolesId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    id: json["id"],
    tenCongTy: json["ten_cong_ty"],
    tenTruyCap: json["ten_truy_cap"],
    matKhau: json["mat_khau"],
    provinceId: json["province_id"],
    districtId: json["district_id"],
    loaiHinhDoanhNghiep: json["loai_hinh_doanh_nghiep"],
    hinhAnhCongTy: json["hinh_anh_cong_ty"],
    diaChiCongTy: json["dia_chi_cong_ty"],
    soDienThoaiCongTy: json["so_dien_thoai_cong_ty"],
    ghiChuCongTy: json["ghi_chu_cong_ty"],
    websiteCongTy: json["website_cong_ty"],
    emailCongTy: json["email_cong_ty"],
    ngayThanhLap: DateTime.parse(json["ngay_thanh_lap"]),
    tenNganHangCongTy: json["ten_ngan_hang_cong_ty"],
    soTaiKhoanCongTy: json["so_tai_khoan_cong_ty"],
    maSoThue: json["ma_so_thue"],
    rolesId: json["roles_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ten_cong_ty": tenCongTy,
    "ten_truy_cap": tenTruyCap,
    "mat_khau": matKhau,
    "province_id": provinceId,
    "district_id": districtId,
    "loai_hinh_doanh_nghiep": loaiHinhDoanhNghiep,
    "hinh_anh_cong_ty": hinhAnhCongTy,
    "dia_chi_cong_ty": diaChiCongTy,
    "so_dien_thoai_cong_ty": soDienThoaiCongTy,
    "ghi_chu_cong_ty": ghiChuCongTy,
    "website_cong_ty": websiteCongTy,
    "email_cong_ty": emailCongTy,
    "ngay_thanh_lap": "${ngayThanhLap.year.toString().padLeft(4, '0')}-${ngayThanhLap.month.toString().padLeft(2, '0')}-${ngayThanhLap.day.toString().padLeft(2, '0')}",
    "ten_ngan_hang_cong_ty": tenNganHangCongTy,
    "so_tai_khoan_cong_ty": soTaiKhoanCongTy,
    "ma_so_thue": maSoThue,
    "roles_id": rolesId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
