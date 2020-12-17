import 'dart:convert';

List<Attendance> attendanceFromJson(String str) => List<Attendance>.from(json.decode(str).map((x) => Attendance.fromJson(x)));

String attendanceToJson(List<Attendance> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Attendance {
  Attendance({
    this.id,
    this.employeeId,
    this.companyId,
    this.areaId,
    this.branchId,
    this.departmentId,
    this.positionId,
    this.checkInTime,
    this.checkInLocal,
    this.checkInImage,
    this.checkOutTime,
    this.checkOutLocal,
    this.checkOutImage,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String employeeId;
  String companyId;
  String areaId;
  String branchId;
  String departmentId;
  String positionId;
  DateTime checkInTime;
  String checkInLocal;
  String checkInImage;
  dynamic checkOutTime;
  dynamic checkOutLocal;
  dynamic checkOutImage;
  String status;
  DateTime createdAt;
  dynamic updatedAt;

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
    id: json["id"],
    employeeId: json["employee_id"],
    companyId: json["company_id"],
    areaId: json["area_id"],
    branchId: json["branch_id"],
    departmentId: json["department_id"],
    positionId: json["position_id"],
    checkInTime: DateTime.parse(json["check_in_time"]),
    checkInLocal: json["check_in_local"],
    checkInImage: json["check_in_image"],
    checkOutTime: json["check_out_time"],
    checkOutLocal: json["check_out_local"],
    checkOutImage: json["check_out_image"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employee_id": employeeId,
    "company_id": companyId,
    "area_id": areaId,
    "branch_id": branchId,
    "department_id": departmentId,
    "position_id": positionId,
    "check_in_time": checkInTime.toIso8601String(),
    "check_in_local": checkInLocal,
    "check_in_image": checkInImage,
    "check_out_time": checkOutTime,
    "check_out_local": checkOutLocal,
    "check_out_image": checkOutImage,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt,
  };
}
