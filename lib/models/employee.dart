import 'dart:convert';

List<Employee> employeeFromJson(String str) => List<Employee>.from(json.decode(str).map((x) => Employee.fromJson(x)));

String employeeToJson(List<Employee> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Employee {
  Employee({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.dateOfBirth,
    this.gender,
    this.image,
    this.displayOrder,
    this.identityCard,
    this.dateReleaseId,
    this.locatedReleaseId,
    this.passport,
    this.dateReleasePassport,
    this.dateExpiredPassport,
    this.locatedReleasePassport,
    this.companyId,
    this.note,
    this.areaId,
    this.branchId,
    this.departmentId,
    this.accessgroupId,
    this.positionId,
    this.active,
    this.actingChief,
    this.bankName,
    this.bankNumber,
    this.nameOfBank,
    this.branchOfBank,
    this.username,
    this.password,
    this.provinceId,
    this.districtId,
    this.createdAt,
    this.updatedAt,
    this.currentAddress,
    this.backgroundImage,
  });

  String id;
  String name;
  String phone;
  String email;
  DateTime dateOfBirth;
  String gender;
  String image;
  String displayOrder;
  String identityCard;
  DateTime dateReleaseId;
  String locatedReleaseId;
  String passport;
  DateTime dateReleasePassport;
  DateTime dateExpiredPassport;
  String locatedReleasePassport;
  String companyId;
  String note;
  String areaId;
  String branchId;
  String departmentId;
  String accessgroupId;
  String positionId;
  String active;
  String actingChief;
  String bankName;
  String bankNumber;
  String nameOfBank;
  String branchOfBank;
  String username;
  String password;
  String provinceId;
  String districtId;
  DateTime createdAt;
  DateTime updatedAt;
  String currentAddress;
  String backgroundImage;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    dateOfBirth: DateTime.parse(json["date_of_birth"]),
    gender: json["gender"],
    image: json["image"],
    displayOrder: json["display_order"],
    identityCard: json["identity_card"],
    dateReleaseId: DateTime.parse(json["date_release_id"]),
    locatedReleaseId: json["located_release_id"],
    passport: json["passport"],
    dateReleasePassport: DateTime.parse(json["date_release_passport"]),
    dateExpiredPassport: DateTime.parse(json["date_expired_passport"]),
    locatedReleasePassport: json["located_release_passport"],
    companyId: json["company_id"],
    note: json["note"],
    areaId: json["area_id"],
    branchId: json["branch_id"],
    departmentId: json["department_id"],
    accessgroupId: json["accessgroup_id"],
    positionId: json["position_id"],
    active: json["active"],
    actingChief: json["acting_chief"],
    bankName: json["bank_name"],
    bankNumber: json["bank_number"],
    nameOfBank: json["name_of_bank"],
    branchOfBank: json["branch_of_bank"],
    username: json["username"],
    password: json["password"],
    provinceId: json["province_id"],
    districtId: json["district_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    currentAddress: json["current_address"],
    backgroundImage: json["background_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "email": email,
    "date_of_birth": "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "image": image,
    "display_order": displayOrder,
    "identity_card": identityCard,
    "date_release_id": "${dateReleaseId.year.toString().padLeft(4, '0')}-${dateReleaseId.month.toString().padLeft(2, '0')}-${dateReleaseId.day.toString().padLeft(2, '0')}",
    "located_release_id": locatedReleaseId,
    "passport": passport,
    "date_release_passport": "${dateReleasePassport.year.toString().padLeft(4, '0')}-${dateReleasePassport.month.toString().padLeft(2, '0')}-${dateReleasePassport.day.toString().padLeft(2, '0')}",
    "date_expired_passport": "${dateExpiredPassport.year.toString().padLeft(4, '0')}-${dateExpiredPassport.month.toString().padLeft(2, '0')}-${dateExpiredPassport.day.toString().padLeft(2, '0')}",
    "located_release_passport": locatedReleasePassport,
    "company_id": companyId,
    "note": note,
    "area_id": areaId,
    "branch_id": branchId,
    "department_id": departmentId,
    "accessgroup_id": accessgroupId,
    "position_id": positionId,
    "active": active,
    "acting_chief": actingChief,
    "bank_name": bankName,
    "bank_number": bankNumber,
    "name_of_bank": nameOfBank,
    "branch_of_bank": branchOfBank,
    "username": username,
    "password": password,
    "province_id": provinceId,
    "district_id": districtId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "current_address": currentAddress,
    "background_image": backgroundImage,
  };
}
