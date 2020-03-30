import 'package:flutter/material.dart';
import 'package:tradeleaves/models/index.dart';
import 'package:tradeleaves/tl-services/crm/CrmServiceImpl.dart';

import '../../service_locator.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

   CrmServiceImpl get crmService => locator<CrmServiceImpl>();
    ProfileResp profileResp;
   
  getUserDetails() async{
    print("getUserDetails called");
    var userInfo = await crmService.getPersonalDetails();
    print("get User details");
    print(userInfo);
    setState(() {
      profileResp = ProfileResp.fromJson(userInfo);
    });
  }
  updateUser() async{
    print("update user called...");
      var updateUser = await crmService.updateUser(profileResp.personalDetailsDTO);
      print("update user resp...");
      print(updateUser);
      setState(() {
         profileResp = ProfileResp.fromJson(updateUser);
      });
  }

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Profile Page'),
      // ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Profile Settings',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text('First Name'),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      initialValue: profileResp.personalDetailsDTO.details.firstName !=  null ? profileResp.personalDetailsDTO.details.firstName: null,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                        hintText: "Enter First Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      onChanged: (String value){
                        setState(() {
                          profileResp.personalDetailsDTO.details.firstName = value;
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
                    Text('Middle Name'),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                       initialValue: profileResp.personalDetailsDTO !=  null ? profileResp.personalDetailsDTO.details.middleName : null,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                        hintText: "Enter Middle Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      onChanged: (String value){
                        setState(() {
                          profileResp.personalDetailsDTO.details.middleName = value;
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
                    Text('Last Name'),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                       initialValue: profileResp.personalDetailsDTO !=  null ? profileResp.personalDetailsDTO.details.lastName:null,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                        hintText: "Enter Last Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      onChanged: (String value){
                        setState(() {
                          profileResp.personalDetailsDTO.details.lastName = value;
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
                    Text('Phone Number'),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                       initialValue: profileResp.personalDetailsDTO.mobile.contactNumber,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                        hintText: "Enter Phone Number",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      onChanged: (String value){
                        setState(() {
                          profileResp.personalDetailsDTO.mobile.contactNumber = value;
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
                    Text('Email'),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                       initialValue: profileResp.personalDetailsDTO.email.emailAddress,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                        hintText: "Enter Email Address",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))  
                      ),
                      onChanged: (String value){
                        setState(() {
                          profileResp.personalDetailsDTO.email.emailAddress = value;
                        });
                      },
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
                      InkWell(
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.grey),
                        ),
                        onTap: () {},
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      RaisedButton(
                        color: Colors.lightGreen,
                        onPressed: () {updateUser();},
                        child: Text(
                          'Save',
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
