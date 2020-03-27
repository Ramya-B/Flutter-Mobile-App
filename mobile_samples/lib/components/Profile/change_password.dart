import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradeleaves/models/index.dart';
import 'package:tradeleaves/models/resend.dart';
import 'package:tradeleaves/tl-services/crm/CrmServiceImpl.dart';

import '../../service_locator.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String currentPassword;
  String newPassword;
  ProfileResp profileResp;
  CrmServiceImpl get crmService => locator<CrmServiceImpl>();

  getUserDetails() async {
    print("getUserDetails called");
    var userInfo = await crmService.getPersonalDetails();
    print("get User details");
    print(userInfo);
    setState(() {
      profileResp = ProfileResp.fromJson(userInfo);
    });
  }

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  updatePassword() async {
    print("update password called...!");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UpdatePasswordDto updatePasswordDto = new UpdatePasswordDto();
    updatePasswordDto.userLoginId = prefs.getString('userId');
    updatePasswordDto.newPassword = this.newPassword;
    updatePasswordDto.currentPassword = this.currentPassword;
    var updateResp = await crmService.updatePassword(updatePasswordDto);
    print(updateResp);
    if (updateResp["statusDto"]["status"] == "TL_USER_UPDATE_PASSWORD_PROCEED") {
      Resend resend = new Resend();
      resend.currentUserLoginId =
          profileResp.personalDetailsDTO.email.emailAddress;
      resend.newUserLoginId = profileResp.personalDetailsDTO.email.emailAddress;
      resend.isPwdChange = true;
      resend.firstName = profileResp.personalDetailsDTO.details.firstName;
      resend.visitedregion = 'IN';
      SendConfirmationDto sendConfirmationDto = new SendConfirmationDto();
      sendConfirmationDto.mobileNumber =
          '${profileResp.personalDetailsDTO.mobile.countryCode}${profileResp.personalDetailsDTO.mobile.contactNumber}';
      sendConfirmationDto.partyId =
          profileResp.personalDetailsDTO.details.partyId;
      sendConfirmationDto.verificationType = "Update Email";
      sendConfirmationDto.optIn = true;
      sendConfirmationDto.countryCode =
          profileResp.personalDetailsDTO.mobile.countryCode;
      sendConfirmationDto.contactNumber =
          profileResp.personalDetailsDTO.mobile.contactNumber;
          resend.sendConfirmationDto = sendConfirmationDto;
     var otpResp = await crmService.resendOtp(resend);
      setState(() {
        print(otpResp["status"]);
        otpResp["status"] == "TL_EMAIL_CONF_CODE_SUCCESS" ?
         Navigator.of(context)
          .push(new MaterialPageRoute(builder: (context) => OtpValidate(resend: resend,updatePasswordDto: updatePasswordDto,))):Navigator.of(context);
      });
     
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('ChangePassword Page'),
      // ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Change Password',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                    'To keep your account safe, and for further security reasons create a strong password.'),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text('Current Password'),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                        hintText: "Enter Current Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      onChanged: (String value){
                        setState(() {
                          this.currentPassword= value;
                        });
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text('New Password'),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                        hintText: "Enter New Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                       onChanged: (String value){
                        setState(() {
                          this.newPassword = value;
                        });
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text('Confirm Password'),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                        hintText: "Enter Confirm Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.lightGreen,
                        onPressed: () {updatePassword();},
                        child: Text(
                          'Update Password',
                          style: TextStyle(color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OtpValidate extends StatelessWidget {
  final Resend resend;
  final UpdatePasswordDto updatePasswordDto;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CrmServiceImpl get crmService => locator<CrmServiceImpl>();
  OtpValidate({this.resend,this.updatePasswordDto});
  final ChangeUserPassword changeUserPassword = new ChangeUserPassword();

  validateVerificarionCode() async {
    print("validateVerificarionCode called...");
    changeUserPassword.userLoginId = resend.currentUserLoginId;
    changeUserPassword.currentPassword = updatePasswordDto.currentPassword;
    changeUserPassword.newPassword = updatePasswordDto.newPassword;
    changeUserPassword.firstName = resend.firstName;
    var changePasswordResp = await crmService.chagePassword(changeUserPassword);
    print(changePasswordResp);
    if(changePasswordResp["status"] == "TL_PASSWORD_UPDATE_SUCCESS") 
    {
      clearInfo();
    } else{
      print("else called...!");
      print(changePasswordResp["status"]);
    }
  }

   void clearInfo() async {
     print("clearing infoo");
    SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.clear();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('Enter Verification Code'),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Enter OTP...",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                  onChanged: (String code) {
                    changeUserPassword.confirmationCode = code;
                  },
                  validator: (String code) {
                    if (code.isEmpty) {
                      return "Please enter Confirmation code";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                child: IconButton(
                  icon: Icon(
                    Icons.refresh,
                    size: 30,
                  ),
                  onPressed: () {},
                ),
              )
            ],
          ),
          Material(
              borderRadius: BorderRadius.circular(10),
              color: Colors.green,
              child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  onPressed: () {
                    print(_formKey.currentState.validate());
                    (_formKey.currentState.validate() == true)
                        ? validateVerificarionCode()
                        : Navigator.of(context);
                  },
                  child: Text("Verify",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))))
        ],
      ),
    ));
  }
}
