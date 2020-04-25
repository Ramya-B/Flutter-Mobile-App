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
                width: 160,
                height: 150,
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
            preferredSize: new Size(MediaQuery.of(context).size.width,12),
            child: Container(
              color: Colors.black87,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children : <Widget>[ TabBar(
                  labelPadding: EdgeInsets.all(5),
                  unselectedLabelColor: Colors.white,
                  indicatorColor: Colors.green  ,
                  indicatorWeight: 4,
                  isScrollable: true,
                  labelColor: Colors.white,
                  tabs: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 10,left: 40),
                      height: 15,
                      child: Tab(
                      child: Text('BLISS'),
                    ),
                    //  decoration: BoxDecoration(
                    //         border: Border(
                    //           right: BorderSide(width: 2,style: BorderStyle.solid,color: Colors.white)
                    //         ),
                    //       ),
                    ),
                     Container(
                       decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(width: 2,style: BorderStyle.solid,color: Colors.white)
                            ),
                          ),
                       padding: EdgeInsets.only(left:20,right:20),
                      height: 15,
                      child: Tab(
                      child: Text('MARKETPLACE',),
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
