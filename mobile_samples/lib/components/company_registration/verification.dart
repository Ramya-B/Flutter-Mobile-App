import 'package:flutter/material.dart';

class VerficationPage extends StatefulWidget {
  @override
  _VerficationPageState createState() => _VerficationPageState();
}

class _VerficationPageState extends State<VerficationPage> {
  String identyType;

  String type;

  int selectedRadioTile;
  int selectedRadio;
  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'To verify your company we need you to provide some documents.',
              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Verification is an important part of the TradeLeaves experience. It’s your assurance that you’re doing business with legitimate business entities. To verify your business, we’ll need some basic business information, along with business documents corresponding to your type of business. Please have these documents available beforehand to speed up your registration process.',
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "What's your role in the company?",
              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text("What's your primary business activity?"),
                ListTileTheme(
                  contentPadding: EdgeInsets.zero,
                  child: RadioListTile(
                    activeColor: Colors.green,
                    groupValue: selectedRadioTile,
                    dense: true,
                    title: Text(
                        "I am an owner, director, administrator or other senior officer."),
                    subtitle: Text(
                        'Please provide a valid document showing that you are the owner of this business.'),
                    value: 1,
                    onChanged: (value) {
                      setState(() {
                        print(value);
                        setSelectedRadioTile(value);
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                ),
                ListTileTheme(
                  contentPadding: EdgeInsets.zero,
                  child: RadioListTile(
                    activeColor: Colors.green,
                    groupValue: selectedRadioTile,
                    dense: true,
                    title: Text(
                        "I am an authorized member of the companies staff."),
                    subtitle: Text(
                        'Please provide a letter, on company letterhead, authorizing you to perform these actions, signed by an owner, director, CEO or CFO of the company.'),
                    value: 2,
                    onChanged: (value) {
                      setState(() {
                        setSelectedRadioTile(value);
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                ),
              ],
            ),
          ],
        ),
        Divider(
          color: Colors.black,
        ),
        SizedBox(
          height: 20,
        ),
        //First CheckBox
        (selectedRadioTile == 1)
            ? Card(
                child: Container(
                    child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                    ),
                    Text(
                      'Verification Document Required',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.center,
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Personal Identication',
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Please upload one of the following required documents.',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text('Type'),
                              SizedBox(
                                height: 8,
                              ),
                              DropdownButton(
                                hint: identyType == null
                                    ? Text('Type')
                                    : Text(
                                        identyType,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                isExpanded: true,
                                iconSize: 30.0,
                                items: [
                                  'Passport',
                                  'Pan Card',
                                  'Adhar Card',
                                  "Voter's Registration Card",
                                  'GSTIN ID',
                                  'Company Id Card'
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
                                      identyType = val;
                                    },
                                  );
                                },
                              )
                              // TextFormField(
                              //   decoration: InputDecoration(
                              //     contentPadding:
                              //         EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                              //     hintText: "Password",
                              //     border: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(5)),
                              //   ),
                              // )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Center(
                              child: Container(
                            child: RaisedButton(
                              shape: StadiumBorder(
                                  side: BorderSide(
                                      color: Colors.green, width: 1)),
                              onPressed: () {},
                              child: Text(
                                'Attach',
                                style: TextStyle(color: Colors.green[900]),
                              ),
                              color: Colors.white,
                              padding: EdgeInsets.only(left: 30, right: 30),
                            ),
                          )),
                        ],
                      ),
                    ),
                  ],
                )),
              )
            :
            // Second CheckBox
            (selectedRadioTile == 2)
                ? Column(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            'Owner Information',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text('Name'),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                              hintText: "Enter owner name",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
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
                          Text('Email'),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                              hintText: "Enter owner email",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
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
                          Text('Contact Number'),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                              hintText: "Enter owner contact number",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Card(
                        child: Container(
                            child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 8, bottom: 8),
                            ),
                            Text(
                              'Verification Document Required',
                              style: TextStyle(fontSize: 17),
                              textAlign: TextAlign.center,
                            ),
                            Divider(
                              color: Colors.black,
                            ),
                            Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Company Authorization',
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'To confirm your identity as an officer or authorized representative, select a document type and attach supporting file here.',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Text('Type'),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      DropdownButton(
                                        hint: identyType == null
                                            ? Text('Type')
                                            : Text(
                                                identyType,
                                                style: TextStyle(fontSize: 14),
                                              ),
                                        isExpanded: true,
                                        iconSize: 30.0,
                                        items: [
                                          'Passport',
                                          'Pan Card',
                                          'Adhar Card',
                                          "Voter's Registration Card",
                                          'GSTIN ID',
                                          'Company Id Card'
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
                                              identyType = val;
                                            },
                                          );
                                        },
                                      )
                                      // TextFormField(
                                      //   decoration: InputDecoration(
                                      //     contentPadding: EdgeInsets.fromLTRB(
                                      //         20.0, 5.0, 20.0, 5.0),
                                      //     hintText: "Password",
                                      //     border: OutlineInputBorder(
                                      //         borderRadius:
                                      //             BorderRadius.circular(5)),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Center(
                                      child: Container(
                                    child: RaisedButton(
                                      shape: StadiumBorder(
                                          side: BorderSide(
                                              color: Colors.green, width: 1)),
                                      onPressed: () {},
                                      child: Text(
                                        'Attach',
                                        style:
                                            TextStyle(color: Colors.green[900]),
                                      ),
                                      color: Colors.white,
                                      padding:
                                          EdgeInsets.only(left: 30, right: 30),
                                    ),
                                  )),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Text('Type'),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      DropdownButton(
                                        hint: type == null
                                            ? Text('Type')
                                            : Text(
                                                type,
                                                style: TextStyle(fontSize: 14),
                                              ),
                                        isExpanded: true,
                                        iconSize: 30.0,
                                        items: [
                                          'Authorization Letter',
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
                                              type = val;
                                            },
                                          );
                                        },
                                      )
                                      // TextFormField(
                                      //   decoration: InputDecoration(
                                      //     contentPadding: EdgeInsets.fromLTRB(
                                      //         20.0, 5.0, 20.0, 5.0),
                                      //     hintText: "Authorization Letter",
                                      //     border: OutlineInputBorder(
                                      //         borderRadius:
                                      //             BorderRadius.circular(5)),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Center(
                                      child: Container(
                                    // alignment: Alignment.center,
                                    child: RaisedButton(
                                      shape: StadiumBorder(
                                          side: BorderSide(
                                              color: Colors.green, width: 1)),
                                      onPressed: () {},
                                      child: Text(
                                        'Attach',
                                        style:
                                            TextStyle(color: Colors.green[900]),
                                      ),
                                      color: Colors.white,
                                      padding:
                                          EdgeInsets.only(left: 30, right: 30),
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ],
                        )),
                      ),
                    ],
                  )
                : Container(),
        Divider(
          color: Colors.black,
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              InkWell(
                child: Text(
                  'Skip this step',
                  style: TextStyle(color: Colors.green),
                ),
                onTap: () {},
              ),
              SizedBox(
                width: 15,
              ),
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
