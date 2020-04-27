import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:tradeleaves/models/index.dart';
import 'package:tradeleaves/models/user.dart';
import 'package:tradeleaves/podos/crm/register.dart';
import 'package:tradeleaves/service_locator.dart';
import 'package:tradeleaves/tl-services/catalog/CatalogServiceImpl.dart';
import 'package:tradeleaves/tl-services/core-npm/UserServiceImpl.dart';
import 'package:tradeleaves/tl-services/crm/CrmServiceImpl.dart';
import 'package:tradeleaves/tl-services/login/LoginServiceImpl.dart';

import '../../constants.dart';
import 'landing_page.dart';
import 'login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _mobileController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  var name;
  var email;
  var mobile;
  var password;
  var confirmPassword;
  var companyName;
  bool autoValidate = false;
  String countryCode;
  bool agreeForSms = false;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);

  @override
  void initState() {
    super.initState();
  }

  registerInfo() {
    RegisterDTO registerDTO = new RegisterDTO();
    UserLoginDTO userLoginDTO = new UserLoginDTO();
    userLoginDTO.userLoginId = this.email;
    userLoginDTO.password = this.password;
    registerDTO.userLoginDTO = userLoginDTO;
    PersonalDetailsDTO person = new PersonalDetailsDTO();
    Details details = new Details();
    details.firstName = this.name;
    details.domainName = "tradeleaves.in";
    details.optIn = this.agreeForSms;
    person.details = details;
    Mobile mobile = new Mobile();
    mobile.contactNumber = this.mobile;
    mobile.countryCode = this.countryCode;
    person.mobile = mobile;
    Email email = new Email();
    email.emailAddress = this.email;
    person.email = email;
    registerDTO.person = person;
    CompanyDTO company = new CompanyDTO();
    PartyGroupDTO partyDetails = new PartyGroupDTO();
    partyDetails.groupName = this.companyName;
    company.details = partyDetails;
    registerDTO.company = company;
    registerDTO.channel = "B2BInternational";
    registerDTO.region = "IN";
    registerDTO.featureId = "fafe70b7-500d-42fa-fb3a-8421fc7c6c9d";
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => RegisterDetails(
              registerDTO: registerDTO,
            )));
  }

   @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
          fillColor: Colors.grey[200],
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          hintText: "Your Full Name",
          border: InputBorder.none),
      validator: (name) {
        if (name.isEmpty || name == "") {
          autoValidate = false;
          return "Name can't be empty";
        } else if (name.length < 3) {
          return 'Name must be more than two characters';
        }
        autoValidate = true;
        return null;
      },
      onChanged: (String name) {
        setState(() {
          this.name = name;
        });
      },
    );

    final emailField = TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          hintText: "yourName@company.com",
          border: InputBorder.none),
      validator: (email) {
        Pattern pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp _regExpEmail = new RegExp(pattern);
        if (email.isEmpty || email == "") {
          return "Email can't be empty";
        } else if (!_regExpEmail.hasMatch(email)) {
          return 'Please enter valid email';
        }
        return null;
      },
      onChanged: (String email) {
        setState(() {
          this.email = email;
        });
      },
    );

    final mobileField = Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(5),
          ),
          child: DropdownButton<String>(
            value: countryCode,
            items: <String>['+91', '+1'].map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
            onChanged: (String newValue) {
              setState(() {
                countryCode = newValue;
              });
            },
          ),
        ),
        Flexible(
          child: TextFormField(
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10)
            ],
            controller: _mobileController,
            decoration: InputDecoration(
                fillColor: Colors.grey[200],
                filled: true,
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                hintText: "Enter mobile number",
                border: InputBorder.none),
            validator: (mobile) {
              Pattern pattern = r'^[2-9][0-9]{9}$';
              RegExp _regExpPhn = new RegExp(pattern);
              if (mobile.isEmpty || mobile == "") {
                return "Phone number can't be empty";
              } else if (!_regExpPhn.hasMatch(mobile)) {
                return 'Please enter valid phone number';
              }
              return null;
            },
            onChanged: (String mobile) {
              setState(() {
                this.mobile = mobile;
              });
            },
          ),
        )
      ],
    );

    final passwordField = TextFormField(
      obscureText: true,
      controller: _passwordController,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          hintText: "Enter your password",
          border: InputBorder.none),
      validator: (password) {
        Pattern pattern =
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
        RegExp _regExpPwd = new RegExp(pattern);
        if (password.isEmpty || password == "") {
          return "Password can't be empty";
        } else if (!_regExpPwd.hasMatch(password)) {
          return "Enter Valid Password";
        }
        return null;
      },
      onChanged: (String password) {
        setState(() {
          this.password = password;
        });
      },
    );

    final confirmPasswordField = TextFormField(
      obscureText: true,
      controller: _confirmPasswordController,
      decoration: InputDecoration(
          fillColor: Colors.grey[200],
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          hintText: "Confirm your password",
          border: InputBorder.none),
      validator: (confirmPassword) {
        if (confirmPassword != _passwordController.text) {
          return "Password not match";
        }
        return null;
      },
    );

    final tlLogo = SizedBox(
      height: 80,
      width: MediaQuery.of(context).size.width / 2,
      child: Image.asset("assets/tllogo.png", fit: BoxFit.contain),
    );

    final registerButton = SizedBox(
      height: 30,
      child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(30),
          color: Constants.toolbarColor,
          child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width / 3,
              onPressed: () {
                print(_formKey.currentState.validate());
                (_formKey.currentState.validate() == true)
                    ? registerInfo()
                    : Navigator.of(context);
              },
              child: Text("Register Now",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white)))),
    );
        var agreeToRecieveSms = Container(
          child:CheckboxListTile(
          title: Text("I agree to receive SMS."),
          value: agreeForSms,
          checkColor: Colors.white,
          activeColor: Colors.green,
          onChanged: (newValue) { 
            setState(() {
              agreeForSms = !agreeForSms;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,  
        )
        );
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.green[900],
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(40),
              child: Column(
                children: <Widget>[
                  tlLogo,
                  nameField,
                  SizedBox(height: 15),
                  emailField,
                  SizedBox(height: 15),
                  mobileField,
                  SizedBox(height: 15),
                  passwordField,
                  SizedBox(height: 15),
                  confirmPasswordField,
                  SizedBox(height: 10),
                  agreeToRecieveSms,
                  SizedBox(height: 10),
                  registerButton,
                  SizedBox(height: 15),
                  Text("Already have an account?"),
                  SizedBox(height: 5),
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Login())),
                    child: Text(
                      'Click here to login',
                      style: TextStyle(color: Colors.green[800]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterDetails extends StatefulWidget {
  final RegisterDTO registerDTO;

  const RegisterDetails({Key key, this.registerDTO}) : super(key: key);

  @override
  _RegisterDetailsState createState() => _RegisterDetailsState();
}

class _RegisterDetailsState extends State<RegisterDetails> {
  String confirmationCode;
  String error;
  CrmServiceImpl get crmService => locator<CrmServiceImpl>();
  LogInServiceImpl get logInService => locator<LogInServiceImpl>();
  UserServiceImpl get userService => locator<UserServiceImpl>();
  CatalogServiceImpl get catalogService => locator<CatalogServiceImpl>();
  List<Sort> sorts = [];
  User user;
  register() async {
    print("register called...");
    var data = await crmService.register(widget.registerDTO);
    setState(() {
      print("Reister details from node.........");
      print(data);
    });
  }

  verifyCurrentUser() async {
    print("start verifying...");
    UserCheck userInfo = UserCheck(
        email: widget.registerDTO.userLoginDTO.userLoginId,
        verificationCode: this.confirmationCode);
    var data = await crmService.verifyUser(userInfo);
    print(data);

    if (data["status"] == "TL_EMAIL_CONF_CODE_VALID") {
      AuthRequest authRequest = AuthRequest(
          name: widget.registerDTO.userLoginDTO.userLoginId,
          customerId: widget.registerDTO.userLoginDTO.userLoginId,
          password: widget.registerDTO.userLoginDTO.password);
      var authResp = await logInService.getAuthToken(authRequest);
      print("Authentication response...");
      print(authResp);
      AuthToken authToken = AuthToken.fromJson(authResp);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', authToken.token.toString());
      //  getUserProducts();
      getUserInfo();
      Navigator.of(context)
          .push(new MaterialPageRoute(builder: (context) => LandingPage()));
    }
  }

  getUserInfo() async {
    var data = await userService.getUser();
    print("user response...");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.user = User.fromJson(data);
    setState(() {
      this.user = User.fromJson(data);
      print("user response set state...");
      print(this.user);
      print(this.user.name);
      print(this.user.personalDetails.profile.person.firstName);
      prefs.setString('name',
          this.user.personalDetails.profile.person.firstName.toString());
      prefs.setString('userId', this.user.name.toString());
    });
  }

  @override
  void initState() {
    register();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(title: Text('Vefify OTP'),backgroundColor: Constants.toolbarColor,),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              color: Colors.white,
              margin: EdgeInsets.all(15.0),
              child: Container(
                margin: EdgeInsets.all(10.0),
                child: Form(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        '${widget.registerDTO.userLoginDTO.userLoginId}',
                        style: TextStyle(fontSize: 22, color: Colors.black87),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        '${widget.registerDTO.person.mobile.contactNumber.replaceRange(0, 6, '******')}',
                        style: TextStyle(fontSize: 20, color: Colors.black87),
                      ),
                    ),
                    Container(
                      height: 20,
                      child: (this.error != null)
                          ? (Text('${this.error}'))
                          : Container(),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Enter OTP...",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            onChanged: (String code) {
                              setState(() {
                                this.confirmationCode = code;
                              });
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
                    Container(
                      margin: EdgeInsets.all(20),
                      child: RaisedButton(
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.only(
                            left: 25, right: 25, top: 10, bottom: 10),
                        splashColor: Colors.lightGreen,
                        onPressed: () {
                          verifyCurrentUser();
                        },
                        child: Text(
                          'Continue',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        color: Colors.green,
                      ),
                    )
                  ],
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
