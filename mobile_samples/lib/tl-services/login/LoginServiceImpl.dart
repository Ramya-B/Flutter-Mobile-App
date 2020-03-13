import 'dart:convert';

import 'package:tradeleaves/podos/crm/register.dart';
import 'package:tradeleaves/tl-services/login/LoginService.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';

class LogInServiceImpl extends LoginService{
  Map<String, String> headers = {
    'Content-type': 'application/json; charset=UTF-8'
  };
  @override
  Future getAuthToken(AuthRequest authRequest) async{
     return await http
        .post('${Constants.envUrl}/auth/local',
            headers: headers, body: jsonEncode(authRequest.toJson()))
        .then((data) {
      print("auth token...!");
      print(data);
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("auth token resp....");
        print(res);
        return res;
      } else {
        return throw Exception('falied to get auth token');
      }
    });
  }

  @override
  Future logIn(AuthRequest authRequest) async{
    return await http
        .post('${Constants.envUrl}/auth/local',
            headers: headers, body: jsonEncode(authRequest.toJson()))
        .then((data) {
      print("auth token...!");
      print(data);
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("auth token resp....");
        print(res);
        return res;
      } else {
        return throw Exception('falied to get auth token');
      }
    });
  }
}