import 'package:flutter/material.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';

class Profile extends StatefulWidget {
  final userId;
  final companyName;
  final emailId;
  final phoneNo;
  final firstName;
  final lastName;

  Profile({
    this.userId,
    this.companyName,
    this.emailId,
    this.phoneNo,
    this.firstName,
    this.lastName,
  });

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final sample = "executed";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  widget.firstName + ' ' + widget.lastName,
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
                            child: Text(widget.userId,
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
                            child: Text(widget.companyName,
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
                            child: Text(widget.emailId,
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
                            child: Text(widget.phoneNo,
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
//        drawer: CustomDrawer(),
        bottomNavigationBar: CustomNavBar(selectedIndex: 0));
  }
}
