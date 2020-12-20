import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:itime/commons/special_convert.dart';
import 'package:itime/models/Company.dart';
import 'package:itime/models/Datetakeleavetype.dart';
import 'package:itime/models/Employee.dart';
import 'package:itime/utils/network_util.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

NetworkUtil _networkUtil = new NetworkUtil();
class DataServices {
  SharedPreferences preferences;
  var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
  var now = new DateTime.now();

  //------------------------------100---------------------------------------
  //------------------------------200---------------------------------------
  //------------------------------300---------------------------------------
  //------------------------------400---------------------------------------
  // Register on database
  // created by : DatNQ
  // created at : 11/12/2020
  Future<void> checkInSubmit(
      {int idEmployee,
        int idCompany,
        int idArea,
        int idBranch,
        int idDepartment,
        int idPosition,
        String checkInLocal,
        String checkInImage,
        int status}) async {
    Map parameters = {
      'what': 407,
      'company_id': idCompany,
      'employee_id': idEmployee,
      'area_id': idArea,
      'branch_id': idBranch,
      'department_id': idDepartment,
      'position_id': idPosition,
      'check_in_time': formatter.format(now),
      'check_in_local': checkInLocal,
      'check_in_image': checkInImage,
      'status': status,
      'created_at': formatter.format(now),
    };
    var input = jsonEncode(parameters);
    return _networkUtil.get(input);
  }

  // check employee have checkin or not
  // created by : DatNQ
  // created at : 04/12/2020
  Future<void> checkExistsAttendances(
      {int idEmployee,
        int idCompany,
        int status}) async {
    Map parameters = {
      'what': 410,
      'employee_id': idEmployee,
      'company_id': idCompany,
      'status': status,
    };
    var input = jsonEncode(parameters);
    return _networkUtil.get(input);
  }

  // Count attendances
  // created by : DatNQ
  // created at : 07/12/2020
  Future<void> countAttendances({int idEmployee, int idCompany}) async {
    Map parameters = {
      'what': 411,
      'employee_id': idEmployee,
      'company_id': idCompany,
    };
    var input = jsonEncode(parameters);
    final url = BASE_URL_GET + input;
    print(url);
    return _networkUtil.get(input);
  }
  //------------------------------500---------------------------------------
  //------------------------------600---------------------------------------
  // get data from database compaies
  // created by : DatNQ
  // created at : 23/11/2020
  Future<List<Company>> getAllCompanies() async {
    try {
      Map param = {'what': 600};
      var input = jsonEncode(param);
      final url = BASE_URL_GET + "?input=" + input;
      var response = await http
          .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
      if (200 == response.statusCode) {
        List<Company> list = companyFromJson(response.body);
        return list;
      } else {
        return List<Company>();
      }
    } catch (e) {
      throw Exception(e); // return an empty list on exception/error
    }
  }
  //------------------------------700---------------------------------------
  Future<List<Datetakeleavetype>> getDataDateTakeLeaveTypes(
      {int idCompany, int status}) async {
    Map param = {
      'what': 707,
      'company_id': idCompany,
      'status': status,
    };
    var input = jsonEncode(param);
    final url = BASE_URL_GET + input;
    print(url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return datetakeleavetypesFromJson(response.body);
    } else {
      return null;
    }
  }
  //------------------------------800---------------------------------------
  //------------------------------900---------------------------------------
  //------------------------------1000---------------------------------------
  // get all data employees on database
  // created by : DatNQ
  // created at : 04/12/2020
  Future<List<Employee>> getAllEmployees() async {
    try {
      Map param = {'what': 1000};
      var input = jsonEncode(param);
      final url = BASE_URL_GET + "?input=" + input;
      var response = await http
          .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
      if (200 == response.statusCode) {
        List<Employee> list = employeeFromJson(response.body);
        return list;
      } else {
        return List<Employee>();
      }
    } catch (e) {
      throw Exception(e); // return an empty list on exception/error
    }
  }

  // check Exists account on database
  // created by : DatNQ
  // created at : 04/12/2020
  Future<void> checkExistsAccountEmployees(
      {String email,
        String userName,
        String phoneNumber}) async {
    Map parameters = {
      'what': 1007,
      'username': userName,
      'email': email,
      'phone': phoneNumber,
    };
    var input = jsonEncode(parameters);
    return _networkUtil.get(input);
  }

  // Register on database
  // created by : DatNQ
  // created at : 11/12/2020
  Future<void> register(
      {int idCompany,
        String fullname,
        String username,
        String phone,
        String email,
        String password,
        int active,
        int actingChief}) async {
    Map parameters = {
      'what': 1008,
      'username': username,
      'password': convertStringToMD5(password),
      'company_id': idCompany,
      'phone': phone,
      'email': email,
      'name': fullname,
      'active': active,
      'acting_chief': actingChief,
      'created_at': formatter.format(now),
    };
    var input = jsonEncode(parameters);
    return _networkUtil.get(input);
  }

  // Login on database
  // created by : DatNQ
  // created at : 04/12/2020
  Future<void> login({int idCompany, String username, String password}) async {
    Map parameters = {
      'what': 1009,
      'username': username,
      'password': convertStringToMD5(password),
      'company_id': idCompany,
    };
    var input = jsonEncode(parameters);
    return _networkUtil.get(input);
  }

  // getEmployeeDataByUserName on database
  // created by : DatNQ
  // created at : 04/12/2020
  Future<List<Employee>> getEmployeeDataByUserName({String userName, int idCompany}) async {
    Map parameters = {
      'what': 1010,
      'username': userName,
      'company_id': idCompany,
    };
    var input = jsonEncode(parameters);
    final url = BASE_URL_GET + "?input=" + input;
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return employeeFromJson(response.body);
    } else {
      return null;
    }
  }
  //------------------------------1100---------------------------------------
  //------------------------------1200---------------------------------------
  //------------------------------1300---------------------------------------
  //------------------------------1400---------------------------------------
  //------------------------------1500---------------------------------------
  //------------------------------1600---------------------------------------
  //------------------------------1700---------------------------------------
  //------------------------------1800---------------------------------------
  //------------------------------1900---------------------------------------
  //------------------------------2000---------------------------------------
  // Insert data into table pShopMenu
  // created by : DatNQ
  // created at : 04/22/2020
  Future<void> sendRequestTakeLeave(
      {int idCompany,
      int idEmloyee,
      int idArea,
      int idBranch,
      int idDepartment,
      int idPosition,
      int idDateTakeLeaveType,
      String startDate,
      String endDate,
      String dateTakeLeave,
      int idTakeLeaveType,
      int idShift,
      int idTakeLeaveReason,
      String content,
      String reason}) async {
    Map parameters = {
      'what': 1707,
      'company_id': idCompany,
      'employee_id': idEmloyee,
      'area_id': idArea,
      'branch_id': idBranch,
      'department_id': idDepartment,
      'position_id': idPosition,
      'date_take_leave_type_id': idDateTakeLeaveType,
      'start_date': startDate,
      'end_date': endDate,
      'date_take_leave': dateTakeLeave,
      'take_leave_type_id': idTakeLeaveType,
      'shift_id': idShift,
      'take_leave_reason_id': idTakeLeaveReason,
      'content': content,
      'reason': reason,
      'status': 0,
      'created_at': formatter.format(now),
    };
    var input = jsonEncode(parameters);
    return _networkUtil.get(input);
  }

}
