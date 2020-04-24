import 'package:flutter/material.dart';

class Preferences extends StatefulWidget {
  @override
  _PreferencesState createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  bool checkValue = false;

  bool isSwitchedTrue = true;

  bool isSwitchedFalse = false;

  var time;

  var language;

  var languages = ['English'];

  List<String> timeZone = [
    "AKST North America (UTC - 9)",
    "AST North America  (UTC - 4)",
    "CST North America (UTC - 6)",
    "EST North America (UTC - 5)",
    "HAST North America (UTC - 10)",
    "MST North America (UTC - 7)",
    "PST North America (UTC - 8)",
    "IST India (UTC + 5:30)",
    "GMT Greenwich Mean Time (UTC + 0)"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Personal Preferences',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text('Time Zone'),
                    SizedBox(
                      height: 8,
                    ),
                    DropdownButton<String>(
                      iconSize: 35,
                      isExpanded: true,
                      value: this.time,
                      hint: Text('Select Time Zone'),
                      items: timeZone.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (String value) {
                        setState(() {
                          this.time = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text('Preferred Language'),
                    SizedBox(
                      height: 8,
                    ),
                    DropdownButton<String>(
                      iconSize: 35,
                      isExpanded: true,
                      value: this.language,
                      hint: Text('Select Preferred Language'),
                      items: languages.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (String value) {
                        setState(() {
                          this.language = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Marketplace search preferences',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                            'Enable grid view for product search results in marketplace.')),
                    Switch(
                      value: isSwitchedFalse,
                      onChanged: (value) {
                        setState(() {
                          isSwitchedFalse = value;
                        });
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    ),
                  ],
                )),
                SizedBox(
                  height: 20,
                ),
                Container(
                    child: Row(
                  children: <Widget>[
                    Expanded(child: Text('Enable SMS Messages.')),
                    Switch(
                      value: isSwitchedTrue,
                      onChanged: (value) {
                        setState(() {
                          isSwitchedTrue = value;
                        });
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    ),
                  ],
                )),
                SizedBox(
                  height: 20,
                ),
                Text('Allow maximum number of products shown in a page:'),
                // Row(
                //   children: <Widget>[
                //     CircularCheckBox(
                //       value: checkValue,
                //       onChanged: (bool value) {
                //         setState(() {
                //           checkValue = value;
                //         });
                //       },
                //       activeColor: Colors.green,
                //     ),
                //     CircularCheckBox(
                //       value: checkValue,
                //       onChanged: (bool value) {
                //         setState(() {
                //           checkValue = value;
                //         });
                //       },
                //       activeColor: Colors.green,
                //     ),
                //     CircularCheckBox(
                //       value: checkValue,
                //       onChanged: (bool value) {
                //         setState(() {
                //           checkValue = value;
                //         });
                //       },
                //       activeColor: Colors.green,
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.lightGreen,
                        onPressed: () {},
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
