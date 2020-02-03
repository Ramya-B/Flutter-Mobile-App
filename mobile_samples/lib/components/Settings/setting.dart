import 'package:flutter/material.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool value1 = true;
  bool value2 = false;
  bool value3 = true;
  bool value4 = false;
  bool value5 = true;
  bool value6 = false;
  bool value7 = true;

  void onChangedValue1(bool value){
    setState(() {
      value1 = value;
    });
  }
  void onChangedValue2(bool value){
    setState(() {
      value2 = value;
    });
  }
  void onChangedValue3(bool value){
    setState(() {
      value3 = value;
    });
  }
  void onChangedValue4(bool value){
    setState(() {
      value4 = value;
    });
  }
  void onChangedValue5(bool value){
    setState(() {
      value5 = value;
    });
  }
  void onChangedValue6(bool value){
    setState(() {
      value6 = value;
    });
  }
  void onChangedValue7(bool value){
    setState(() {
      value7 = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomToolBar(),
      body: Container(
        child: new Column(
          children: <Widget>[
            CheckboxListTile(
              value: value1,
              onChanged: onChangedValue1,
              title: new Text('All Notifications'),
              activeColor: Colors.deepPurple,
              subtitle: new Text('Click here to enabled all notifications'),
              secondary: Icon(Icons.notification_important),
            ),
            CheckboxListTile(
              value: value2,
              onChanged: onChangedValue2,
              title: new Text('Simcard Settings'),
              activeColor: Colors.deepPurple,
              subtitle: new Text('Prefferd sim card settings'),
              secondary: Icon(Icons.sim_card),
            ),
            CheckboxListTile(
              value: value3,
              onChanged: onChangedValue3,
              title: new Text('Bluetooth'),
              activeColor: Colors.deepPurple,
              subtitle: new Text('Bluetooth on/off'),
              secondary: Icon(Icons.bluetooth),
            ),
            CheckboxListTile(
              value: value4,
              onChanged: onChangedValue4,
              title: new Text('Storage & Space'),
              activeColor: Colors.deepPurple,
              subtitle: new Text('Click here to free your space'),
              secondary: Icon(Icons.storage),
            ),
            CheckboxListTile(
              value: value5,
              onChanged: onChangedValue5,
              title: new Text('Music & Ringtones'),
              activeColor: Colors.deepPurple,
              subtitle: new Text('Change your phone ringtones'),
              secondary: Icon(Icons.ring_volume),
            ),
            CheckboxListTile(
              value: value6,
              onChanged: onChangedValue6,
              title: new Text('Latest Updates'),
              activeColor: Colors.deepPurple,
              subtitle: new Text('Click here to upgrade your phone'),
              secondary: Icon(Icons.update),
            ),
            CheckboxListTile(
              value: value7,
              onChanged: onChangedValue7,
              title: new Text('Format Options'),
              activeColor: Colors.deepPurple,
              subtitle: new Text('Do you want format your mobile'),
              secondary: Icon(Icons.format_list_bulleted),
            ),
          ],
        ),
      ),
    );
  }
}