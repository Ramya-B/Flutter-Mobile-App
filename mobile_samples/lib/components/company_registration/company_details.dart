import 'package:flutter/material.dart';

class CompanyDetails extends StatefulWidget {
  @override
  _CompanyDetailsState createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {
  bool isChecked = false;
  // bool serviceC = false;
  // bool isChecked = false;

  String companyTye;

  String industryType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Company Name'),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                hintText: "This is your leagally registered name",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              ),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Trading/Public/DBA Name'),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                hintText: "Trading/Public Name",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              ),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Company Address'),
            SizedBox(
              height: 8,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                      hintText: "Address1",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                      hintText: "Address2",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                      hintText: "City/Town",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                      hintText: "Country",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                      hintText: "State",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                      hintText: "Pin Code",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Company Type'),
            DropdownButton(
              hint: companyTye == null
                  ? Text('Choose Company Type')
                  : Text(
                      companyTye,
                      style: TextStyle(fontSize: 14),
                    ),
              isExpanded: true,
              iconSize: 30.0,
              items: [
                'One Person Company',
                'Corporate',
                'Private Limited Company'
              ].map(
                (val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                },
              ).toList(),
              onChanged: (val) {
                setState(
                  () {
                    companyTye = val;
                  },
                );
              },
            )
            // TextFormField(
            //   decoration: InputDecoration(
            //     contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
            //     hintText: "Company Type",
            //     border:
            //         OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            //   ),
            // )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Primary Industry/Market'),
            SizedBox(
              height: 8,
            ),
            DropdownButton(
              hint: industryType == null
                  ? Text('Choose Primary Industry')
                  : Text(
                      industryType,
                      style: TextStyle(fontSize: 14),
                    ),
              isExpanded: true,
              iconSize: 30.0,
              items: [
                'Business Services',
                'Agriculture Products',
                'Carpet',
                'Electrical & Electronics'
              ].map(
                (val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                },
              ).toList(),
              onChanged: (val) {
                setState(
                  () {
                    industryType = val;
                  },
                );
              },
            )
            // TextFormField(
            //   decoration: InputDecoration(
            //     contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
            //     hintText: "Primary Industry",
            //     border:
            //         OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            //   ),
            // )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.stretch,
        //   children: <Widget>[
        //     Text("What's your primary business activity?"),
        //     ListTileTheme(
        //       contentPadding: EdgeInsets.zero,
        //       child: CheckboxListTile(
        //         activeColor: Colors.green,
        //         dense: true,
        //         title: Text("Buying"),
        //         value: isChecked,
        //         onChanged: (bool value) {
        //           setState(() {
        //             isChecked = value;
        //           });
        //         },
        //         controlAffinity:
        //             ListTileControlAffinity.leading, //  <-- leading Checkbox
        //       ),
        //     ),
        //     ListTileTheme(
        //       contentPadding: EdgeInsets.zero,
        //       child: CheckboxListTile(
        //         activeColor: Colors.green,
        //         dense: true,
        //         title: Text("Selling"),
        //         value: isChecked,
        //         onChanged: (bool value) {
        //           setState(() {
        //             isChecked = value;
        //           });
        //         },
        //         controlAffinity:
        //             ListTileControlAffinity.leading, //  <-- leading Checkbox
        //       ),
        //     ),
        //     ListTileTheme(
        //       contentPadding: EdgeInsets.zero,
        //       child: CheckboxListTile(
        //         activeColor: Colors.green,
        //         dense: true,
        //         title: Text("Service Provider"),
        //         value: isChecked,
        //         onChanged: (bool value) {
        //           setState(() {
        //             isChecked = value;
        //           });
        //         },
        //         controlAffinity:
        //             ListTileControlAffinity.leading, //  <-- leading Checkbox
        //       ),
        //     ),
        //   ],
        // ),
        CheckboxWidget(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Telephone Number'),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                hintText: "Enter Mobile Number",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              ),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Company Email'),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                hintText: "email",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              ),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Company Website'),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                hintText: "Type your company URL",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              ),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Divider(
          color: Colors.black,
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              RaisedButton(
                color: Colors.lightGreen,
                onPressed: () {},
                child: Text(
                  'Save & Exit',
                  style: TextStyle(color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              SizedBox(
                width: 15,
              ),
              RaisedButton(
                color: Colors.lightGreen,
                onPressed: () {},
                child: Text(
                  'Save & Continue',
                  style: TextStyle(color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              )
            ],
          ),
        )
      ],
    );
  }
}

class CheckboxWidget extends StatefulWidget {
  @override
  CheckboxWidgetState createState() => new CheckboxWidgetState();
}

class CheckboxWidgetState extends State {
  Map<String, bool> values = {
    'Buying': false,
    'Selling': false,
    'Service Provider': false,
  };

  var tmpArray = [];

  getCheckboxItems() {
    values.forEach((key, value) {
      if (value == true) {
        tmpArray.add(key);
      }
    });
    print(tmpArray);
    tmpArray.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text("What's your primary business activity?"),
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: values.keys.map((String key) {
                return new CheckboxListTile(
                  title: new Text(key),
                  value: values[key],
                  activeColor: Colors.green,
                  checkColor: Colors.white,
                  onChanged: (bool value) {
                    setState(() {
                      values[key] = value;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                );
              }).toList(),
            ),
          ]),
    );
  }
}
