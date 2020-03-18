import 'package:flutter/material.dart';
import 'package:tradeleaves/components/company_registration/company_details.dart';
import 'package:tradeleaves/components/company_registration/verification.dart';

class CompanyRegistration extends StatefulWidget {
  @override
  _CompanyRegistrationState createState() => _CompanyRegistrationState();
}

class _CompanyRegistrationState extends State<CompanyRegistration> {
  List<MyItem> _items = <MyItem>[
    MyItem(header: "Company Details", body: "Company Details Page"),
    MyItem(header: "Verification", body: "Verification Page"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Company Registration'),
        ),
        body: ListView(
          children: <Widget>[
            ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  _items[index].isExapanded = !_items[index].isExapanded;
                });
              },
              children: _items.map((MyItem item) {
                return ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(item.header, style: TextStyle(fontSize: 20),),
                      );
                    },
                    isExpanded: item.isExapanded,
                    body: Container(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child : (item.header == 'Company Details') ? CompanyDetails() : VerficationPage()
                      )
                    ));
              }).toList(),
            )
          ],
        ));
  }
}

class MyItem {
  bool isExapanded;
  final String header;
  final String body;

  MyItem({this.isExapanded: false, this.header, this.body});
}
