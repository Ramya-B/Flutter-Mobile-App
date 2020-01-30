import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text('About Us'),),
      body: Container(
        child: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Text('          TradeLeaves is a Silicon Valley startup founded by seasoned entrepreneurs and technologists who are passionate about making global commerce simple for businesses of all sizes and consumers, worldwide.',
          style: TextStyle(color: Colors.black87, fontSize: 16),
          textAlign: TextAlign.justify
          ),
          SizedBox(
            height: 20,
          ),
          Text('          TradeLeaves makes Cross Border and Domestic Trade simple through its Professional Services, eMarketplace platform, Business Listing and Information Services, and Classifieds services.TradeLeaves user-friendly digital marketplace makes increased visibility and exponential growth a few clicks away.',
          style: TextStyle(color: Colors.black87, fontSize: 16),
          textAlign: TextAlign.justify
          ),
          SizedBox(
            height: 20,
          ),
          Text('          TradeLeaves helps Micro, Small, and Medium Enterprises (MSMEs) and large companies alike to streamline global or domestic trade processes such as discovery, marketing, compliance, payment, procurement and fulfillment; and provide all you need to trade locally or across borders with confidence and ease.',
          style: TextStyle(color: Colors.black87, fontSize: 16),
          textAlign: TextAlign.justify
          ),
          
        ],
        )
      ),
    );
  }
}
