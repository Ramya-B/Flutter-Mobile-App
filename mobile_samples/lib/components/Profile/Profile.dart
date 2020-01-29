import 'package:flutter/material.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/CustomDrawer.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomToolBar(),
        drawer: CustomDrawer()
    );
  }
}
