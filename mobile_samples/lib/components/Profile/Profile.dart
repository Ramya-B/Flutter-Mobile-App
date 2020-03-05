import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final sample = "executed";
  var emailId;
  var fullName;
  var companyName;
  var phoneNo;
  var userData;
  var userId;

  @override
  void initState() {
    setData();
    super.initState();
  }

  void setData() async {
    print("set data called...in profile!");
    SharedPreferences sample = await SharedPreferences.getInstance();
    print(sample.getString('emailId'));
    print(sample.getString('fullName'));
    this.emailId = sample.getString('emailId') != null
        ? sample.getString('emailId')
        : null;
    this.fullName = sample.getString('fullName') != null
        ? sample.getString('fullName')
        : null;
    this.companyName = sample.getString('companyName') != null
        ? sample.getString('companyName')
        : null;
    this.phoneNo = sample.getString('phoneNo') != null
        ? sample.getString('phoneNo')
        : null;
    this.userId = sample.getString('userId') != null
        ? sample.getString('userId')
        : null;
    print(this.emailId);
    print(this.fullName);
    print(this.emailId);
    print(this.companyName);
    print(this.phoneNo);
    print(this.phoneNo);
    setState(() {
      print("set state called.....");
      print(this.emailId);
      print(this.fullName);
      print(this.emailId);
      print(this.phoneNo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: CustomToolBar(),
        body: Container(
          child: ListView(
            children: <Widget>[
              Container(
                height: 200,
                padding: EdgeInsets.all(40.0),
                child: new CircleAvatar(
                  child: Icon(Icons.person),
                  radius: 48.0,
                ),
              ),
              Container(
                height: 50,
                alignment: Alignment.topCenter,
                child: Text(
                  this.fullName,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                height: 200,
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: 30,
                      child: Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.bottomCenter,
                            width: 150,
                            child: Text(
                              'User Id',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black54),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: Text(this.userId,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black)),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 30,
                      child: Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.bottomCenter,
                            width: 150,
                            child: Text(
                              'Company Name',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black54),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: Text(this.companyName,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black)),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 30,
                      child: Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.bottomCenter,
                            width: 150,
                            child: Text(
                              'Email Id',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black54),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: Text(this.emailId,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black)),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 30,
                      child: Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.bottomCenter,
                            width: 150,
                            child: Text(
                              'Phone No',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black54),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: Text(this.phoneNo,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomNavBar(selectedIndex: 0));
  }
}
