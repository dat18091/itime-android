import 'dart:convert';

import 'package:itime/models/Company.dart';
import 'package:itime/models/Employee.dart';
import 'package:itime/utils/network_util.dart';

import 'package:http/http.dart' as http;

NetworkUtil _networkUtil = new NetworkUtil();
class DataServices {
  // get data from database compaies
  // created by : DatNQ
  // created at : 23/11/2020
  static Future<List<Company>> getAllCompanies() async {
    try {
      Map param = {'what': 200};
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

  static Future<List<Employee>> getEmployeeByUsername() async {
    try {
      Map param = {'what': 110};
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


}