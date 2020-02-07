import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';
import 'package:tradeleaves/components/Profile/Profile.dart';
import 'package:tradeleaves/components/categories/categories.dart';
import 'package:tradeleaves/components/favourites/favourite.dart';
import 'package:tradeleaves/components/login_register/login.dart';
import 'package:tradeleaves/components/login_register/logout.dart';
import 'package:tradeleaves/components/notications/Notifications.dart';
import 'package:tradeleaves/components/orders/orders.dart';
import 'package:tradeleaves/components/products/ProductsList.dart';
import 'package:tradeleaves/components/About/about.dart';
import 'package:tradeleaves/components/Settings/setting.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  var sample;
  var emailId;
  var fullName;

  @override
  void initState() {
    setData();
    super.initState();
  }

  void setData() async {
    print("set data called...!");
    SharedPreferences sample = await SharedPreferences.getInstance();
    print(sample.getString('emailId'));
    print(sample.getString('fullName'));
    this.emailId = sample.getString('emailId') != null
        ? sample.getString('emailId')
        : null;
    this.fullName = sample.getString('fullName') != null
        ? sample.getString('fullName')
        : null;
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
          (this.emailId != null && this.fullName != null)
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
            color: Colors.green,
                  height: 100,
                  alignment: Alignment.center,
                  child: InkWell(

                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => new Login())),
                    child: Text('LogIn/Register',style: TextStyle(fontSize: 20,color: Colors.tealAccent),),
                  ),
                ),

          InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => new Scaffold(
                      appBar: CustomToolBar(),
                      body: Container(
                        child: Products(category: 'all'),
                      ),
                      bottomNavigationBar: CustomNavBar(selectedIndex: 0),
                      drawer: CustomDrawer(),
                    ))),
            child: new ListTile(
              title: Text('Home Page'),
              leading: Icon(Icons.home),
            ),
          ),
          (this.emailId != null && this.fullName != null) ? InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => new Profile( ))),
            child: new ListTile(
              title: Text('Profile'),
              leading: Icon(Icons.person),
            ),
          ):Container(),
          InkWell(
            onTap: () => Navigator.of(context).push(
                new MaterialPageRoute(builder: (context) => new Categories())),
            child: new ListTile(
              title: Text('Categories'),
              leading: Icon(Icons.dashboard),
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(
                new MaterialPageRoute(builder: (context) => new Favourite())),
            child: new ListTile(
              title: Text('Favourites'),
              leading: Icon(Icons.favorite),
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(
                new MaterialPageRoute(builder: (context) => new Orders())),
            child: new ListTile(
              title: Text('Orders'),
              leading: Icon(Icons.shopping_basket),
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
          (this.emailId != null && this.fullName != null)
              ? InkWell(
              onTap: () => Navigator.of(context).push(
                  new MaterialPageRoute(builder: (context) => new LogOut())),
              child: new ListTile(
                title: Text('Logout'),
                leading: Icon(Icons.exit_to_app),
              )):Container(),
        ],
      ),
    );
  }
}
