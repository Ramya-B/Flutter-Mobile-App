import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradeleaves/tl-services/customs/customService.dart';

import '../../constants.dart';

class CustomServiceImpl extends CustomServices {
  static const String apiUrl = "/customs/api";
  Map<String, String> headers = {
    'Content-type': 'application/json; charset=UTF-8'
  };

  @override
  Future<List> countryCodes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("countryCodes service...");
    return await http.get(
      '${Constants.envUrl}$apiUrl/countrycodes/active',
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString('token')}",
        'Content-type': 'application/json; charset=UTF-8'
      },
    ).then((data) {
      print("countryCodes response...!");
      print(data);
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("countryCodes get successfully......");
        print(res);
        return res;
      } else {
        return throw Exception('falied to get countryCodes..........');
      }
    });
  }
}
