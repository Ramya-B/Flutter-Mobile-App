import 'package:flutter/material.dart';
import 'package:tradeleaves/components/landing_pages/bliss_home_page.dart';
import 'package:tradeleaves/components/landing_pages/mp_home_page.dart';

class TradeleavesLandingPage extends StatefulWidget {
  @override
  _TradeleavesLandingPageState createState() => _TradeleavesLandingPageState();
}

class _TradeleavesLandingPageState extends State<TradeleavesLandingPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[700],
          title: Text('Landing Pages'),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.white.withOpacity(0.4),
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(
                child: Text('BLISS'),
              ),
              Tab(
                child: Text('MARKETPLACE'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[BLISSHomePage(), MarketplaceHomePage()],
        ),
      ),
    );
  }
}

