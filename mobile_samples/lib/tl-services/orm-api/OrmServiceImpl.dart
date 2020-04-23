import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradeleaves/constants.dart';
import 'package:tradeleaves/models/customerRequestDTO.dart';
import 'package:tradeleaves/tl-services/orm-api/OrmServices.dart';

class OrmServiceImpl extends OrmServices {
  static const String apiUrl = "/order/api";

  @override
  Future createBuyrequest(CustomerRequestDTO customerRequestDTO) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("createBuyrequest called");
     print(jsonEncode(customerRequestDTO));
    return await http
        .post('${Constants.envUrl}$apiUrl/buyrequests/create/request',
        headers: {
     HttpHeaders.authorizationHeader: "Bearer ${prefs.getString('token')}",
    'Content-type': 'application/json; charset=UTF-8'
  }, 
   body: jsonEncode({
        'customerRequestDTO': customerRequestDTO.toJson()
      })).then((data) {
      print("response rgister...!");
      print(data);
      if (data?.statusCode == 200) {
        var res = json.decode(data.body);
        print("createBuyrequest successfully....");
        print(res);
        return res;
      } else {
        return throw Exception('falied to createBuyrequest');
      }
    });
  }



}
