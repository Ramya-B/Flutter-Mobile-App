import 'package:flutter/material.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/podos/crm/register.dart';
import 'package:tradeleaves/service_locator.dart';
import 'package:tradeleaves/tl-services/crm/CrmServiceImpl.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);

  final _formKey = GlobalKey<FormState>();

  bool autoValidate = false;

  var name;
  var email;
  var mobile;
  var companyName;
  var password;
  bool optIn = false;

  // bool checkBoxValue = false;

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
        if (arg1.isEmpty || arg1.length < 3) {
          return 'Name must be more than 2 characters';
        }
        return null;
      },
      // onSaved: (String name) {
      //   this.name = name;

      // }
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
        if (arg2.isEmpty || !arg2.contains('@')) {
          return 'Please enter valid email';
        }
        return null;
      },

      // onSaved: (String email) {
      //  this.email= email;
      // },
      onChanged: (String email) {
        setState(() {
          this.email = email;
        });
      },
    );

    final phoneField = TextFormField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Phone Number",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
      validator: (arg3) {
        Pattern pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
        RegExp _regExpPhn = new RegExp(pattern);
        if (!_regExpPhn.hasMatch(arg3)) {
          return 'Please enter valid phone number';
        }
        return null;
      },
      // onSaved: (String mobile) {
      //  this.mobile = mobile;
      // }
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
        if (arg5.isEmpty) {
          return "Please enter password";
        } else if (!_regExpPwd.hasMatch(arg5)) {
          return "Enter Valid Password";
        }
        return null;
      },
      // onSaved: (String password) {
      //    this.password  = password;
      // },
      onChanged: (String password) {
        setState(() {
          this.password = password;
        });
      },
    );

    final confirmPasswordField = TextFormField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
      validator: (arg6) {
        if (arg6.isEmpty) {
          return " Confirm Password should not be empty";
        }
        // else if(arg6 != registerDTO.userLoginDTO.password){
        //     return "Password not match";
        // }
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
        // elevation: 100,
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
  CrmServiceImpl get crmService => locator<CrmServiceImpl>();
  register() async {
    print("register called...");
    var data = await crmService.register(widget.registerDTO);
    setState(() {
      print("Reister details from node.........");
      print(data);
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
      child: Center(
        child: Container(
          padding: EdgeInsets.all(50),
          child: TextField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                hintText: "Enter OTP...",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
          ),
        ),
      ),
    );
  }
}
