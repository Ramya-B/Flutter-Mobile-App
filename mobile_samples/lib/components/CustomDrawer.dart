import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';
import 'package:tradeleaves/components/categories/categories.dart';
import 'package:tradeleaves/components/login_register/login.dart';
import 'package:tradeleaves/components/login_register/logout.dart';
import 'package:tradeleaves/components/login_register/register.dart';
import 'package:tradeleaves/components/notications/Notifications.dart';
import 'package:tradeleaves/components/About/about.dart';
import 'package:tradeleaves/components/Settings/setting.dart';
import 'package:tradeleaves/components/products/products_home.dart';
import 'package:tradeleaves/components/products/userproducts.dart';
import 'package:tradeleaves/components/webpage/mywebview.dart';
import '../service_locator.dart';
import 'Profile/person_profile.dart';
import 'company_registration/register_business.dart';
import 'company_settings/companysettings.dart';
import 'package:tradeleaves/tl-services/core-npm/UserServiceImpl.dart';
import 'package:tradeleaves/models/index.dart';
import 'package:tradeleaves/components/inquiries/inquiries.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  var sample;
  var emailId;
  var fullName;
  var authToken;
  User user;
  bool showCompanySettings = false;
  bool showCompanyRegistration = false;
  var site = 'Global';
  var country = 'IN';

  UserServiceImpl get userService => locator<UserServiceImpl>();

  getUserInfo() async {
    var data = await userService.getUser();
    print("user response...");
    setState(() {
      this.user = User.fromJson(data);
      if (user.personalDetails.profile.company.status == "COMPLETE") {
        showCompanySettings = true;
      } else {
        showCompanyRegistration = true;
      }
    });
  }

  @override
  void initState() {
    setData();
    getUserInfo();
    super.initState();
  }

  void setData() async {
    print("set data called...!");
    SharedPreferences sample = await SharedPreferences.getInstance();
    this.authToken = sample.getString('token');
    print(sample.getString('userId'));
    print(sample.getString('name'));
    this.emailId =
        sample.getString('userId') != null ? sample.getString('userId') : null;
    this.fullName =
        sample.getString('name') != null ? sample.getString('name') : null;
    print(this.emailId);
    print(this.fullName);
    setState(() {
      print("set state called.....");
      print(this.emailId);
      print(this.fullName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new ListView(
        children: <Widget>[
          (this.authToken != null && this.fullName != null)
              ? Container(
                  child: new UserAccountsDrawerHeader(
                    accountName: Text(this.fullName),
                    accountEmail: Text(this.emailId),
                    currentAccountPicture: GestureDetector(
                      child: new CircleAvatar(child: Icon(Icons.person)),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                    ),
                  ),
                )
              : Container(
                  height: 100,
                  child: FlatButton.icon(
                    color: Colors.green,
                    icon:
                        Icon(Icons.person_pin, size: 60.0, color: Colors.white),
                    label: Text('Guest',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    onPressed: () {},
                  ),
                ),
          Container(
            color: Colors.grey[50],
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.only(left: 20),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: site,
                        items:
                            <String>['Domestic', 'Global'].map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            site = newValue;
                          });
                        },
                      ),
                    ),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1.0, style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20, left: 10),
                  padding: EdgeInsets.only(left: 20, right: 10),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: country,
                      items: <String>['IN', 'US'].map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          country = newValue;
                        });
                      },
                    ),
                  ),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.0, style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => new Scaffold(
                      appBar: CustomToolBar(),
                      body: Container(
                        child: HomeProducts(),
                      ),
                      bottomNavigationBar: CustomNavBar(selectedIndex: 0),
                      drawer: CustomDrawer(),
                    ))),
            child: new ListTile(
              title: Text('Home Page'),
              leading: Icon(Icons.home),
            ),
          ),
          (this.emailId != null && this.fullName != null)
              ? InkWell(
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => PersonalProfile())),
                  child: new ListTile(
                    title: Text('Profile'),
                    leading: Icon(Icons.person),
                  ),
                )
              : Container(),
          (this.authToken == null)
              ? InkWell(
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => new Register())),
                  child: new ListTile(
                    title: Text('Register'),
                    leading: Icon(Icons.people),
                  ),
                )
              : Container(),
          (this.authToken == null)
              ? InkWell(
                  onTap: () => Navigator.of(context).push(
                      new MaterialPageRoute(builder: (context) => Login())),
                  child: new ListTile(
                    title: Text('Login'),
                    leading: Icon(Icons.person),
                  ),
                )
              : Container(),
//          (user!=null) && (user.personalDetails.profile.company.accountStatus == null) || (user.personalDetails.profile.company.accountStatus != null && user.personalDetails.profile.company.accountStatus.statusId == "CREATED_INCOMPLETED") ?
          showCompanyRegistration
              ? InkWell(
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => CompanyRegistration())),
                  child: new ListTile(
                    title: Text('Business Setup'),
                    leading: Icon(Icons.business),
                  ),
                )
              : Container(),
//          user!=null && (user.personalDetails.profile.company.status == "COMPLETE" )?
          showCompanySettings
              ? InkWell(
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => CompanySettings())),
                  child: new ListTile(
                    title: Text('Company Settings'),
                    leading: Icon(Icons.business),
                  ),
                )
              : Container(),
          InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new MyWebView(
                    selectedUrl: "https://classifieds.tradeleaves.com/"))),
            child: new ListTile(
              title: Text('Classifieds'),
              leading: Icon(Icons.table_chart),
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(
                new MaterialPageRoute(builder: (context) => new Categories())),
            child: new ListTile(
              title: Text('Categories'),
              leading: Icon(Icons.dashboard),
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => new UserProducts())),
            child: new ListTile(
              title: Text('My Products'),
              leading: Icon(Icons.view_list),
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(
                new MaterialPageRoute(builder: (context) => new Inquiries())),
            child: new ListTile(
              title: Text('Inquiries'),
              leading: Icon(Icons.email),
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => new AlertNotifications())),
            child: new ListTile(
              title: Text('Notifications'),
              leading: Icon(Icons.notifications),
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => new SettingsPage())),
            child: new ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.settings),
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(
                new MaterialPageRoute(builder: (context) => new AboutPage())),
            child: new ListTile(
              title: Text('About'),
              leading: Icon(Icons.info),
            ),
          ),
          (this.authToken != null)
              ? InkWell(
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => new LogOut())),
                  child: new ListTile(
                    title: Text('Logout'),
                    leading: Icon(Icons.exit_to_app),
                  ))
              : Container(),
        ],
      ),
    );
  }
}
