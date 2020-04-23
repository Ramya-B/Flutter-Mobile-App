import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradeleaves/constants.dart';
import 'package:tradeleaves/tl-services/orm-api/OrmServices.dart';

class OrmServiceImpl extends OrmServices {
  static const String apiUrl = "/order/api";
  Map<String, String> headers = {
    'Content-type': 'application/json; charset=UTF-8'
  };

  @override
  Future createBuyrequest(customerRequestDTO) async{
    print("createBuyrequest called");
    // TODO: implement createBuyrequest
    return await http
        .post('${Constants.envUrl}$apiUrl/order/api/buyrequests/create/request',
        headers: headers, body: jsonEncode(customerRequestDTO.toJson()))
        .then((data) {
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
