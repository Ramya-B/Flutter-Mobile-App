import 'package:flutter/material.dart';
import 'package:tradeleaves/components/company_settings/contact.dart';
import 'package:tradeleaves/components/company_settings/about.dart';

import '../../constants.dart';
//import 'package:tradeleaves/components/company_settings/contact.dart';
class CompanySettings extends StatefulWidget {
  @override
  _CompanySettingsState createState() => _CompanySettingsState();
}

class _CompanySettingsState extends State<CompanySettings> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.toolbarColor,
          title: Text('Company Settings'),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.white.withOpacity(0.4),
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(
                child: Text('ABOUT'),
              ),
              Tab(
                child: Text('CONTACT'),
              ),
              Tab(
                child: Text('PAYMENT'),
              ),
              Tab(
                child: Text('VERIFICATION'),
              ),
              Tab(
                child: Text('CERTIFICATIONS'),
              ),
              Tab(
                child: Text('DELIVERY'),
              ),
              Tab(
                child: Text('DOCUMENT TEMPLATES'),
              ),
              Tab(
                child: Text('PREFERENCES'),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            About(),
            Contact(),
            Text('Need to implement'),
            Text('Need to implement'),
            Text('Need to implement'),
            Text('Need to implement'),
            Text('Need to implement'),
            Text('Need to implement')
          ],
        ),
      ),
    );
  }
}

//class CompanySettingsScreen extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return DefaultTabController(
//      length: 8,
//      child: Scaffold(
//        appBar: AppBar(
//          backgroundColor: Colors.green[700],
//          title: Text('Company Settings'),
//          centerTitle: true,
//          bottom: TabBar(
//            isScrollable: true,
//            unselectedLabelColor: Colors.white.withOpacity(0.4),
//            indicatorColor: Colors.white,
//            tabs: <Widget>[
//              Tab(
//                child: Text('ABOUT'),
//              ),
//              Tab(
//                child: Text('CONTACT'),
//              ),
//              Tab(
//                child: Text('PAYMENT'),
//              ),
//              Tab(
//                child: Text('VERIFICATION'),
//              ),
//              Tab(
//                child: Text('CERTIFICATIONS'),
//              ),
//              Tab(
//                child: Text('DELIVERY'),
//              ),
//              Tab(
//                child: Text('DOCUMENT TEMPLATES'),
//              ),
//              Tab(
//                child: Text('PREFERENCES'),
//              )
//            ],
//          ),
//        ),
//        body: TabBarView(
//          children: <Widget>[
////            AboutScreen(),
////            CantactPage(),
//            Text('data'),
//            Text('data'),
//            Text('data'),
//            Text('data'),
//            Text('data'),
//            Text('data')
//          ],
//        ),
//      ),
//    );
//  }
//}
