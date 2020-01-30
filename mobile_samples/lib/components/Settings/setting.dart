import 'package:flutter/material.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomToolBar(),
      body: Container(
        color: Colors.tealAccent,
        child: Center(
          child: Text('All Settings Here'),
        ),
      ),
    );
  }
}