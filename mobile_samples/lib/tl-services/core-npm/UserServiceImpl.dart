import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradeleaves/models/faqs.dart';
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

  @override
  Future saveFaqs(List<Faqs> faqs) async{
     SharedPreferences prefs =  await SharedPreferences.getInstance();
     print("saveFaqs service...!");
     print(prefs);
      return await http
        .post(
      '${Constants.envUrl}/knowledgebase/api/faqs',
      headers: {HttpHeaders.authorizationHeader: "Bearer ${prefs.getString('token')}" , 'Content-type': 'application/json; charset=UTF-8'},
      body: jsonEncode(faqs),
    ).then((data) {
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("saveFaqs  results came....");
        print(res);
        return res;
      } else {
        return throw Exception('falied to  get saveFaqs results....');
      }
    });
  }


 
}