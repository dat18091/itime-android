import 'dart:convert';

List<Company> companyFromJson(String str) => List<Company>.from(json.decode(str).map((x) => Company.fromJson(x)));

String companyToJson(List<Company> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Company {
  Company({
    this.id,
    this.name,
    this.username,
    this.password,
    this.provinceId,
    this.districtId,
    this.typeOfBusiness,
    this.image,
    this.address,
    this.phone,
    this.note,
    this.website,
    this.email,
    this.establishDate,
    this.bankName,
    this.bankNumber,
    this.taxCode,
    this.rolesId,
    this.createdAt,
    this.updatedAt,
    this.backgroundImage,
  });

  String id;
  String name;
  String username;
  String password;
  String provinceId;
  String districtId;
  String typeOfBusiness;
  dynamic image;
  dynamic address;
  String phone;
  String note;
  String website;
  String email;
  DateTime establishDate;
  dynamic bankName;
  dynamic bankNumber;
  dynamic taxCode;
  String rolesId;
  DateTime createdAt;
  dynamic updatedAt;
  dynamic backgroundImage;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    id: json["id"],
    name: json["name"],
    username: json["username"],
    password: json["password"],
    provinceId: json["province_id"],
    districtId: json["district_id"],
    typeOfBusiness: json["type_of_business"],
    image: json["image"],
    address: json["address"],
    phone: json["phone"],
    note: json["note"],
    website: json["website"],
    email: json["email"],
    establishDate: DateTime.parse(json["establish_date"]),
    bankName: json["bank_name"],
    bankNumber: json["bank_number"],
    taxCode: json["tax_code"],
    rolesId: json["roles_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
    backgroundImage: json["background_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "username": username,
    "password": password,
    "province_id": provinceId,
    "district_id": districtId,
    "type_of_business": typeOfBusiness,
    "image": image,
    "address": address,
    "phone": phone,
    "note": note,
    "website": website,
    "email": email,
    "establish_date": "${establishDate.year.toString().padLeft(4, '0')}-${establishDate.month.toString().padLeft(2, '0')}-${establishDate.day.toString().padLeft(2, '0')}",
    "bank_name": bankName,
    "bank_number": bankNumber,
    "tax_code": taxCode,
    "roles_id": rolesId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt,
    "background_image": backgroundImage,
  };
}
