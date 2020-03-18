import 'package:flutter/material.dart';
import 'package:tradeleaves/components/Profile/change_password.dart';
import 'package:tradeleaves/components/Profile/my_roles.dart';
import 'package:tradeleaves/components/Profile/preferences.dart';
import 'package:tradeleaves/components/Profile/profile.dart';
import 'package:tradeleaves/components/Profile/security_questions.dart';

class PersonalProfile extends StatefulWidget {
  @override
  _PersonalProfileState createState() => _PersonalProfileState();
}

class _PersonalProfileState extends State<PersonalProfile> {
  

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: Text('Personal Profile'),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.white.withOpacity(0.4),
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(
                child: Text('PROFILE'),
              ),
              Tab(
                child: Text('CHANGE PASSWORD'),
              ),
              Tab(
                child: Text('PREFERENCES'),
              ),
              Tab(
                child: Text('SECURITY QUESTIONS'),
              ),
              Tab(
                child: Text('NY ROLES(S)'),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Profile(),
            ChangePassword(),
            Preferences(),
            SecurityQuestions(),
            MyRoles()
          ],
        ),
      ),
    );
  }
}
