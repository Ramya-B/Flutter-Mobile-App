import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradeleaves/components/CustomDrawer.dart';
import 'package:tradeleaves/components/Profile/person_profile.dart';
import 'package:tradeleaves/components/landing_pages/bliss_home_page.dart';
import 'package:tradeleaves/components/landing_pages/mp_home_page.dart';
import 'package:tradeleaves/components/login_register/login.dart';
import 'package:tradeleaves/components/search/search.dart';

class TradeleavesLandingPage extends StatefulWidget {
  @override
  _TradeleavesLandingPageState createState() => _TradeleavesLandingPageState();
}

class _TradeleavesLandingPageState extends State<TradeleavesLandingPage> {
  String authToken;
  @override
  void initState() {
    getCookies();
    super.initState();
  }
  getCookies() async{
     SharedPreferences sample = await SharedPreferences.getInstance();
    this.authToken = sample.getString('token');
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset("assets/tllogo.png"),
                width: 200,
                height: 170,
              )
            ],
          ),
          backgroundColor: Colors.white,
          iconTheme: new IconThemeData(color: Colors.green),
          actions: <Widget>[
            new IconButton(
                icon: Icon(Icons.search),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => new SearchItems()))),
            new IconButton(
                icon: Icon(Icons.person),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => (this.authToken == null)
                        ? Login()
                        : PersonalProfile())))
          ],
          centerTitle: true,
          bottom: new PreferredSize(
            preferredSize: const Size(100,12),
            child: Container(
              alignment: Alignment.center,
              color: Colors.black87,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children : <Widget>[ TabBar(
                  labelPadding: EdgeInsets.all(5),
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.green  ,
                  isScrollable: true,
                  labelColor: Colors.white,
                  tabs: <Widget>[
                    Container(
                      height: 15,
                      child: Tab(
                      child: Text('BLISS'),
                    ),
                    ),
                     Container(
                      height: 15,
                      child: Tab(
                      child: Text('Marketplace'),
                    ))
                    
                  ],
                ),]
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[BLISSHomePage(), MarketplaceHomePage()],
        ),
        drawer: CustomDrawer(),
      ),
    );
  }
}
