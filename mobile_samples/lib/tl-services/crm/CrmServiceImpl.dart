import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradeleaves/constants.dart';
import 'package:tradeleaves/models/changeUserPassword.dart';
import 'package:tradeleaves/models/company.dart';
import 'package:tradeleaves/models/partyQuestionsList.dart';
import 'package:tradeleaves/models/personalDetailsDTO.dart';
import 'package:tradeleaves/models/resend.dart';
import 'package:tradeleaves/models/updatePasswordDto.dart';
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
  Future<List> industryType(String siteId) async {
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

  @override
  Future<List> getIdentificationGroyp(int groupId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("getIdentificationGroyp service called......");
    return await http.get(
      '${Constants.envUrl}$apiUrl/profile/identificationgroups/$groupId',
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString('token')}",
        'Content-type': 'application/json; charset=UTF-8'
      },
    ).then((data) {
      print("getIdentificationGroyp response...!");
      print(data);
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("getIdentificationGroyp get successfully....");
        print(res);
        return res;
      } else {
        return throw Exception('falied to get getIdentificationGroyp.........');
      }
    });
  }

  @override
  Future<List> getStates(String name, bool isActive) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("getStates service called......");
    return await http.post(
      '${Constants.envUrl}/api/countries/states/by/country/code',
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString('token')}",
        'Content-type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode({
        'countryInfoDto': {"name":"India" , "isActive": true}
      })
    ).then((data) {
      print("getStates response...!");
      print(data);
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("getStates get successfully....");
        print(res);
        return res;
      } else {
        return throw Exception('falied to get getStates.........');
      }
    });
  }

  @override
  Future getPersonalDetails() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("getPersonalDetails called......");
    return await http.get(
      '${Constants.envUrl}$apiUrl/profile/login/person',
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString('token')}",
        'Content-type': 'application/json; charset=UTF-8'
      },
    ).then((data) {
      print("getPersonalDetails response...!");
      print(data);
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("getPersonalDetails  successfully....");
        print(res);
        return res;
      } else {
        return throw Exception('falied to  getPersonalDetails.........');
      }
    });
  }

  @override
  Future updateUser(PersonalDetailsDTO personalDetailsDTO) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("updateUser called......");
    return await http.post(
      '${Constants.envUrl}$apiUrl/profile/update/person',
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString('token')}",
        'Content-type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode({
        'personalDetailsDTO': personalDetailsDTO.toJson()
      })
    ).then((data) {
      print("updateUser response...!");
      print(data);
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("updateUser  successfully....");
        print(res);
        return res;
      } else {
        return throw Exception('falied to  updateUser.........');
      }
    });
  }

  @override
  Future updatePassword(UpdatePasswordDto updatePasswordDto) async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
    print("updatePassword called......");
    return await http.post(
      '${Constants.envUrl}$apiUrl/profile/checkCurrent/previousPassword',
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString('token')}",
        'Content-type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode({
        'updatePasswordDto': updatePasswordDto.toJson()
      })
    ).then((data) {
      print("updatePassword response...!");
      print(data);
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("updatePassword  successfully....");
        print(res);
        return res;
      } else {
        return throw Exception('falied to  updatePassword.........');
      }
    });
  }

  @override
  Future resendOtp(Resend resend) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
    print("resendOtp called......");
    print(resend.toJson());
    return await http.post(
      '${Constants.envUrl}$apiUrl/register/verification/resend',
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString('token')}",
        'Content-type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode( resend.toJson() )
    ).then((data) {
      print("resendOtp response...!");
      print(data);
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("resendOtp  successfully....");
        print(res);
        return res;
      } else {
        return throw Exception('falied to  resendOtp.........');
      }
    });
  }

  @override
  Future chagePassword(ChangeUserPassword changeUserPassword) async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
    print("chagePassword called......");
    return await http.post(
      '${Constants.envUrl}$apiUrl/register/person/changepassword',
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString('token')}",
        'Content-type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode( changeUserPassword.toJson() )
    ).then((data) {
      print("chagePassword response...!");
      print(data);
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("chagePassword  successfully....");
        print(res);
        return res;
      } else {
        return throw Exception('falied to  chagePassword.........');
      }
    });
  }

  @override
  Future getSecurityQuestions() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("getSecurityQuestions called......");
    return await http.get(
        '${Constants.envUrl}$apiUrl/profile/admin/questions',
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${prefs.getString('token')}",
          'Content-type': 'application/json; charset=UTF-8'
        },
    ).then((data) {
      print("getSecurityQuestions response...!");
      print(data);
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("getSecurityQuestions  successfully....");
        print(res);
        return res;
      } else {
        return throw Exception('falied to  getSecurityQuestions.........');
      }
    });  }

  @override
  Future saveSecurityQuestions(PartyQuestionsList partyQuestionsList) async{
    // TODO: implement saveSecurityQuestions
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("saveSecurityQuestions called......");
    print(partyQuestionsList.toJson());
    return await http.post(
        '${Constants.envUrl}$apiUrl/profile/person/questions',
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${prefs.getString('token')}",
          'Content-type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode({
    'partyQuestionsList': partyQuestionsList.toJson()
    })
    ).then((data) {
      print("saveSecurityQuestions response.cls..!");
      print(data);
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("saveSecurityQuestions  successfully....");
        print(res);
        return res;
      } else {
        return throw Exception('falied to  saveSecurityQuestions.........');
      }
    });

  }

  @override
  Future fetchSecurityQuestionsByPartyId (String partyId) async{
    // TODO: implement fetchSecurityQuestionsByPartyId
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("fetchSecurityQuestionsByPartyId service called......");
    return await http.get(
      '${Constants.envUrl}$apiUrl/profile/getQuestions/partyId/$partyId',
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString('token')}",
        'Content-type': 'application/json; charset=UTF-8'
      },
    ).then((data) {
      print("fetchSecurityQuestionsByPartyId response...!");
      print(data);
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("industryType get successfully....");
        print(res);
        return res;
      } else {
        return throw Exception('falied to get fetchSecurityQuestionsByPartyId.........');
      }
    });
  }

  @override
  Future saveCompanyDetails(Company company) async{
    // TODO: implement saveCompanyDetails
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("saveCompanyDetails called......");
    print(company.toJson());
    return await http.post(
        '${Constants.envUrl}$apiUrl/profile/company/details/save',
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${prefs.getString('token')}",
          'Content-type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode({
          'companyDTO': company.toJson()
        })
    ).then((data) {
      print("saveCompanyDetails response.cls..!");
      print(data);
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("saveCompanyDetails  successfully....");
        print(res);
        return res;
      } else {
        return throw Exception('falied to  saveCompanyDetails.........');
      }
    });
  }


}
