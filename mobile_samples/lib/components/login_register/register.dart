import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/company/company_registration.dart';
import 'package:tradeleaves/main.dart';
import 'package:tradeleaves/models/user.dart';
import 'package:tradeleaves/podos/crm/register.dart';
import 'package:tradeleaves/podos/products/product.dart';
import 'package:tradeleaves/service_locator.dart';
import 'package:tradeleaves/tl-services/catalog/CatalogServiceImpl.dart';
import 'package:tradeleaves/tl-services/core-npm/UserServiceImpl.dart';
import 'package:tradeleaves/tl-services/crm/CrmServiceImpl.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:tradeleaves/tl-services/login/LoginServiceImpl.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  bool autoValidate = false;
  

  var name;
  var email;
  var mobile;
  var companyName;
  var password;
  bool optIn = false;
  // bool checkBoxValue = false;

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
    PersonDTO details = new PersonDTO();
    details.firstName = this.name;
    details.domainName = "tradeleaves.in";
    details.optIn = this.optIn;
    person.details = details;
    TelephoneDTO mobile = new TelephoneDTO();
    mobile.contactNumber = this.mobile;
    mobile.countryCode = "+91";
    person.mobile = mobile;
    EmailContactDTO email = new EmailContactDTO();
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
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Full Name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
      validator: (arg1) {
        if (arg1.isEmpty || arg1 == "") {
          autoValidate = false;
          return "Name can't be empty";
        } else if (arg1.length < 3) {
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
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
      validator: (arg2) {
        Pattern pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp _regExpEmail = new RegExp(pattern);
        if (arg2.isEmpty || arg2 == "") {
          return "Email can't be empty";
        } else if (!_regExpEmail.hasMatch(arg2)) {
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

    final phoneField = TextFormField(
      inputFormatters: [
        WhitelistingTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10)
      ],
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
          hintText: "Phone Number",
          prefix: CountryCodePicker(
            initialSelection: '+91',
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
      validator: (arg3) {
        Pattern pattern = r'^[2-9][0-9]{9}$';
        RegExp _regExpPhn = new RegExp(pattern);
        if (arg3.isEmpty || arg3 == "") {
          return "Phone number can't be empty";
        } else if (!_regExpPhn.hasMatch(arg3)) {
          return 'Please enter valid phone number';
        }
        return null;
      },
      onChanged: (String mobile) {
        setState(() {
          this.mobile = mobile;
        });
      },
    );

    final companyField = TextFormField(
        obscureText: false,
        style: style,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Company Name",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
        onChanged: (String company) {
          setState(() {
            this.companyName = company;
          });
        });

    final passwordField = TextFormField(
      controller: _pass,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
      validator: (arg5) {
        Pattern pattern =
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
        RegExp _regExpPwd = new RegExp(pattern);
        if (arg5.isEmpty || arg5 == "") {
          return "Password can't be empty";
        } else if (!_regExpPwd.hasMatch(arg5)) {
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
      controller: _confirmPass,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
      validator: (arg6) {
        if (arg6 != _pass.text) {
          return "Password not match";
        }
        return null;
      },
    );

    final checkBoxField = CheckboxListTile(
        title: Text("I agree to receive SMS"),
        value: this.optIn,
        onChanged: (bool value) {
          setState(() {
            this.optIn = value;
          });
        },
        controlAffinity: ListTileControlAffinity.leading);

    final registerButton = Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.green,
        child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            onPressed: () {
              print(_formKey.currentState.validate());
              (_formKey.currentState.validate() == true)
                  ? registerInfo()
                  : Navigator.of(context);
            },
            child: Text("Register Your Account",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold))));

    return Scaffold(
        appBar: CustomToolBar(),
        body: Center(
            child: SingleChildScrollView(
                child: Container(
                    color: Colors.white,
                    child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Form(
                          key: _formKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                nameField,
                                SizedBox(height: 20),
                                emailField,
                                SizedBox(height: 20),
                                phoneField,
                                SizedBox(height: 20),
                                companyField,
                                SizedBox(height: 20),
                                passwordField,
                                SizedBox(height: 20),
                                confirmPasswordField,
                                checkBoxField,
                                SizedBox(height: 20),
                                registerButton
                              ]),
                        ))))));
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
                .push(new MaterialPageRoute(builder: (context) => CompanyRegistration()));
    }
  }

  getUserProducts() async {
    print("getUserProducts");
    ProductCriteria productCriteria = new ProductCriteria();
    Pagination pagination = new Pagination(start: 0, limit: 10);
    Sort sort = new Sort();
    sort.direction = 'desc';
    sort.sort = 'createdTime';
    this.sorts.add(sort);
    productCriteria.pagination = pagination;
    productCriteria.sort = this.sorts;
    productCriteria.siteCriterias = [];
    var getUserProducts = await catalogService.getUserProducts(productCriteria);
    print("getUser response...!");
    print(getUserProducts);
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
        backgroundColor: Colors.pink[50],
        appBar: AppBar(title: Text('OTP Page')),
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
