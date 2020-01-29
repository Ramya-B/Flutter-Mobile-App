import 'package:flutter/material.dart';

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
    return Container(
      child: Center(


      ),
    );
  }
}
