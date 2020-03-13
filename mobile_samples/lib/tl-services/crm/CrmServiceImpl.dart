import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tradeleaves/constants.dart';
import 'package:tradeleaves/podos/crm/register.dart';
import 'package:tradeleaves/tl-services/crm/CrmServices.dart';

class CrmServiceImpl extends CrmServices {
  static const String apiUrl = "/crm/api/register";
  Map<String, String> headers = {
    'Content-type': 'application/json; charset=UTF-8'
  };

  @override
  Future register(RegisterDTO registerDTO) async {
    print("register service...");
    return await http
        .post('${Constants.envUrl}$apiUrl',
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
  var uri =  Uri.http('${Constants.envDomainUrl}', '$apiUrl/verification/verify', { 'login': false.toString() });
   print(uri);
    return await http
        .post(uri,
            headers: headers, body: jsonEncode(info.toJson()))
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
}
