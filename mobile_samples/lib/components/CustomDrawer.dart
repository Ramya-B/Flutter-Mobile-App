import 'package:flutter/material.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';
import 'package:tradeleaves/components/Profile/Profile.dart';
import 'package:tradeleaves/components/categories/categories.dart';
import 'package:tradeleaves/components/favourites/favourite.dart';
import 'package:tradeleaves/components/login_register/login.dart';
import 'package:tradeleaves/components/notications/Notifications.dart';
import 'package:tradeleaves/components/orders/orders.dart';
import 'package:tradeleaves/components/products/ProductsList.dart';
import 'package:tradeleaves/components/About/about.dart';
import 'package:tradeleaves/components/Settings/setting.dart';


class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: new ListView(
          children: <Widget>[
            Container(
              child: new UserAccountsDrawerHeader(
                accountName: Text('Manohar Nettem'),
                accountEmail: Text('manohar.nettem@gmail.com'),
                currentAccountPicture: GestureDetector(
                  child: new CircleAvatar(child: Icon(Icons.person)
                      ),
                ),
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => new Scaffold(
                    appBar: CustomToolBar(),
                    body: Container(
                      child: Products(category: 'all') ,
                    ),
                    bottomNavigationBar: CustomNavBar(selectedIndex: 0),
                    drawer: CustomDrawer(),
                  ))),
              child: new ListTile(
                title: Text('Home Page'),
                leading: Icon(Icons.home),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => new Profile(
                      userId: 'manohar',
                      companyName:'my dream company',
                      emailId:'manohar.nettem@gmail.com',
                      phoneNo: "7799867839",
                      firstName: 'Manohar',
                      lastName: 'Nettem'
                  ))),
              child: new ListTile(
                title: Text('Profile'),
                leading: Icon(Icons.person),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (context) => new Categories())),
              child: new ListTile(
                title: Text('Categories'),
                leading: Icon(Icons.dashboard),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => new Favourite())),
              child: new ListTile(
                title: Text('Favourites'),
                leading: Icon(Icons.favorite),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => new Orders())),
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
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new SettingsPage())),
              child: new ListTile(
                title: Text('Settings'),
                leading: Icon(Icons.settings),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new AboutPage())),
              child: new ListTile(
                title: Text('About'),
                leading: Icon(Icons.info),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new Login())),
              child: new ListTile(
                title: Text('Logout'),
                leading: Icon(Icons.exit_to_app),
              )
            )
          ],
        ),
      );
  }
}
