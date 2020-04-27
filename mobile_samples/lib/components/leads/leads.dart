import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tradeleaves/components/leads/leads.list.dart';
import 'package:tradeleaves/components/leads/expiredleads.list.dart';
import 'package:tradeleaves/components/leads/discardedLeads.list.dart';

import '../../constants.dart';
class Leads extends StatefulWidget {
  @override
  _LeadsState createState() => _LeadsState();
}

class _LeadsState extends State<Leads> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.toolbarColor,
          title: Text('My Leads'),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.white.withOpacity(0.4),
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(
                child: Text('Leads'),
              ),
              Tab(
                child: Text('Expired Leads'),
              ),
              Tab(
                child: Text('Discarded Leads'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            MyLeads(),
            MyExpiredLeads(),
            MyDiscardedLeads(),
          ],
        ),
      ),
    );
  }
}
