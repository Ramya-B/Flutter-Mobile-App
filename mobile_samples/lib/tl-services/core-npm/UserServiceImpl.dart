import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import 'UserService.dart';

class UserServiceImpl extends UserService{

  @override
  Future getUser() async{
    SharedPreferences prefs =  await SharedPreferences.getInstance();
     print("get user service...!");
     print(prefs);
   return await http
        .get(
      '${Constants.envUrl}/api/users/me',
     headers: {HttpHeaders.authorizationHeader: 'Bearer ${prefs.getString("token")}' },
    )
        .then((data) {
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("get user  results came....");
        print(res);
        return res;
      } else {
        return throw Exception('falied to  get user  results....');
      }
    });
  }
 
}