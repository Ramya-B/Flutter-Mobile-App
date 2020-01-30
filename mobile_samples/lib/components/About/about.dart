import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomToolBar(),
      body: Container(
        color: Colors.tealAccent,
        child: Center(
          child: FlutterLogo(
            size: 500,
          ),
        )
      ),
    );
  }
}