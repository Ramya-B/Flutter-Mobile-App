import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradeleaves/tl-services/core-npm/cities.dart';
import '../../constants.dart';


class CitiesServiceImpl extends CityServices{
  Map<String, String> headers = {
    'Content-type': 'application/json; charset=UTF-8'
  };
  @override
  Future<List> getCitiesByCountryCodes(List<dynamic> countyList) async{
    SharedPreferences prefs =  await SharedPreferences.getInstance();
     print("getCitiesByCountryCodes service...!");
     print(jsonEncode(countyList));
     print(prefs);
     print(jsonEncode(<String, Object>{
        'regionSelection': countyList.toList(),
      }));
   return await http
        .post(
      '${Constants.envUrl}/api/cities/getpopular/citiesby/countrycode/list',
     headers: {HttpHeaders.authorizationHeader: 'Bearer ${prefs.getString("token")}' , 'Content-type': 'application/json; charset=UTF-8'},
     body: jsonEncode(<String, Object>{
        'regionSelection': countyList,
      }),
    )
        .then((data) {
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("getCitiesByCountryCodes came....");
        print(res);
        return res;
      } else {
        return throw Exception('falied to  getCitiesByCountryCodes....');
      }
    });
  }

  
}