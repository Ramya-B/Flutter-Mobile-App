import 'package:flutter/material.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';
import 'package:tradeleaves/components/CustomDrawer.dart';
import 'package:tradeleaves/components/login_register/login_page.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  var fullName;
  var companyName;
  var password;
  var confirmPassword;
  var emailId;
  var phoneNo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new CustomToolBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(24),
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autofocus: true,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    autocorrect: true,
                    decoration: InputDecoration(
                        labelText: "Full Name",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                        )
                      ),
                    onChanged: (String name){
                      this.fullName = name;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autofocus: true,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                        )
                    ),
                    onChanged: (String email){
                      this.emailId = email;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autofocus: true,
                    obscureText: false,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        labelText: "Phone Number",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                        )
                    ),
                    onChanged: (String phone){
                      this.phoneNo = phone;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autofocus: true,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Company Name",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                        )
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autofocus: true,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                        )
                    ),
                    onChanged: (String password){
                      this.password = password;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autofocus: true,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Confirm Password",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                        )
                    ),
                    onChanged: (String confirmPassword){
                      this.confirmPassword = confirmPassword;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autofocus: true,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Refferal Code",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                        )
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ButtonTheme(
                    minWidth: double.infinity,
                    child: MaterialButton(
                        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new SaveUser(
                          fullName: this.fullName,
                          companyName: this.companyName,
                          password: this.password,
                          emailId: this.emailId,
                          phoneNo: this.phoneNo,
                        ))),
                        textColor: Colors.white,
                        color: Colors.green,
                        height: 50,
                        child: Text("Register Your Account")),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class SaveUser extends StatefulWidget {
  final fullName;
  final companyName;
  final password;
  final emailId;
  final phoneNo;

  SaveUser({this.fullName,this.companyName,this.password,this.emailId,this.phoneNo});
  @override
  _SaveUserState createState() => _SaveUserState();
}

class _SaveUserState extends State<SaveUser> {
  saveUser() async {
    Db db = new Db("mongodb://10.0.2.2:27017/tlapp");
    DbCollection coll;
    await db.open();
    coll = db.collection("users");
   coll.insert({
     "emailId" : widget.emailId,
     "password" : widget.password,
     "companyName" :widget.companyName,
     "fullName" : widget.fullName,
     "phoneNo" : widget.phoneNo
   });
    setState(() {
      print("set state called");
    });
    print("after getting all users...");
    db.close();
  }

  @override
  void initState() {
    // TODO: implement initState
    saveUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: CustomToolBar(),
//      bottomNavigationBar: CustomNavBar(selectedIndex: 0,),
//      drawer: CustomDrawer(),
      body: Container(
        child: UserLogin(),
      ),

    );
  }
}

