import 'package:flutter/material.dart';
import 'package:tradeleaves/components/inquiries/inquiries.list.dart';

import '../../constants.dart';
class Inquiries extends StatefulWidget {
  @override
  _InquiriesState createState() => _InquiriesState();
}

class _InquiriesState extends State<Inquiries> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.toolbarColor,
          title: Text('My Inquiries'),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.white.withOpacity(0.4),
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(
                child: Text('POSTED INQUIRIES'),
              ),
              Tab(
                child: Text('PROPOSALS'),
              ),
              Tab(
                child: Text('APPROVALS'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            MyInquiries(),
            Center(child: Text('Proposals need to implement',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),)),
            Center(child: Text('Approvals need to implement',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),))
          ],
        ),
      ),
    );
  }
}
