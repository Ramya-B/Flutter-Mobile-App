import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradeleaves/constants.dart';
import 'package:tradeleaves/podos/crm/register.dart';
import 'package:tradeleaves/tl-services/crm/CrmServices.dart';

class CrmServiceImpl extends CrmServices {
  static const String apiUrl = "/crm/api";
  Map<String, String> headers = {
    'Content-type': 'application/json; charset=UTF-8'
  };

  @override
  Future register(RegisterDTO registerDTO) async {
    print("register service...");
    return await http
        .post('${Constants.envUrl}$apiUrl/register',
            headers: headers, body: jsonEncode(registerDTO.toJson()))
        .then((data) {
      print("response rgister...!");
      print(data);
      if (data?.statusCode == 200) {
        var res = json.decode(data.body);
        print("register successfully....");
        print(res);
        return res;
      } else {
        return throw Exception('falied to register');
      }
    });
  }

  @override
  Future verifyUser(UserCheck info) async {
    print("verify user....");
    var uri = Uri.http('${Constants.envDomainUrl}',
        '$apiUrl/register/verification/verify', {'login': false.toString()});
    print(uri);
    return await http
        .post(uri, headers: headers, body: jsonEncode(info.toJson()))
        .then((data) {
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("validated....");
        print(res);
        return res;
      } else {
        return throw Exception('falied to validate....');
      }
    });
  }

  @override
  Future companyRegions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("companyRegions service....!");
    return await http.get(
      '${Constants.envUrl}$apiUrl/profile/companyregions/get',
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString('token')}",
        'Content-type': 'application/json; charset=UTF-8'
      },
    ).then((data) {
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("companyRegions resp....");
        print(res);
        return res;
      } else {
        return throw Exception('falied to companyRegions ....');
      }
    });
  }

  @override
  Future<List> companyTypes(String siteId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("companyTypes service...");
    print(siteId);
    return await http.get(
      '${Constants.envUrl}$apiUrl/profile/companytypes/site/$siteId',
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString('token')}",
        'Content-type': 'application/json; charset=UTF-8'
      },
    ).then((data) {
      print("companyType response...!");
      print(data);
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("companyTypes get successfully......");
        print(res);
        return res;
      } else {
        return throw Exception('falied to get companyTypes..........');
      }
    });
  }

  @override
  Future businessType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("businessType service called......");
    return await http.get(
      '${Constants.envUrl}$apiUrl/profile/classification/businesstype',
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString('token')}",
        'Content-type': 'application/json; charset=UTF-8'
      },
    ).then((data) {
      print("businessType response...!");
      print(data);
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("businessTypes get successfully....");
        print(res);
        return res;
      } else {
        return throw Exception('falied to get businessTypes.........');
      }
    });
  }

  @override
  Future<List> industryType(String siteId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("industryType service called......");
    return await http.get(
      '${Constants.envUrl}$apiUrl/profile/primaryindustries/site/$siteId',
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString('token')}",
        'Content-type': 'application/json; charset=UTF-8'
      },
    ).then((data) {
      print("industryType response...!");
      print(data);
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("industryType get successfully....");
        print(res);
        return res;
      } else {
        return throw Exception('falied to get industryType.........');
      }
    });
  }
}
