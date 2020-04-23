import 'package:flutter/material.dart';
import 'package:tradeleaves/tl-services/crm/CrmServiceImpl.dart';
import 'package:tradeleaves/models/index.dart';
import '../../service_locator.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

var addressType;
var states;

var addNewAddress = Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: <Widget>[
    Divider(
      color: Colors.grey,
    ),
    SizedBox(
      height: 15,
    ),
    Text(
      'Add New Address',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    SizedBox(
      height: 15,
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
                initialValue: 'Country',
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              DropdownButton<String>(
                value: states,
                hint: Text('State'),
                isExpanded: true,
                onChanged: null,
                // onChanged: (newValue) {
                //   setState(
                //     () {
                //       states = newValue;
                //     },
                //   );
                // },
                items: <String>['India', 'USA'].map((String type) {
                  return new DropdownMenuItem<String>(
                    value: type,
                    child: new Text(type),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                  hintText: "Zip code",
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
      height: 15,
    ),
    Divider(
      color: Colors.grey,
    ),
    SizedBox(
      height: 15,
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text('Address Type'),
        new DropdownButton<String>(
          value: addressType,
          hint: Text('Address Type'),
          isExpanded: true,
          onChanged: null,
          // onChanged: (newValue) {
          //   setState(
          //     () {
          //     addressType = newValue;
          //     },
          //   );
          // },
          items: <String>[
            'Registered Address',
            'Billing Address',
            'Shipping Address'
          ].map((String type) {
            return new DropdownMenuItem<String>(
              value: type,
              child: new Text(type),
            );
          }).toList(),
        )
      ],
    ),
    SizedBox(
      height: 15,
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text('Associate Number'),
        SizedBox(
          height: 8,
        ),
        TextFormField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
            hintText: "Number",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          ),
        )
      ],
    ),
    SizedBox(
      height: 15,
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text('Associated Email'),
        SizedBox(
          height: 8,
        ),
        TextFormField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
            hintText: "Email",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          ),
        )
      ],
    ),
    SizedBox(
      height: 15,
    ),
    Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          InkWell(
            child: Text('Cancel'),
            onTap: () {},
          ),
          SizedBox(
            width: 15,
          ),
          RaisedButton(
            color: Colors.lightGreen,
            onPressed: () {},
            child: Text(
              'Save Address',
              style: TextStyle(color: Colors.white),
            ),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          )
        ],
      ),
    )
  ],
);

var editAddress = Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: <Widget>[
    SizedBox(
      height: 15,
    ),
    Divider(
      color: Colors.grey,
    ),
    SizedBox(
      height: 15,
    ),
    Text(
      'Edit Address',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    SizedBox(
      height: 15,
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text('Address Type'),
        new DropdownButton<String>(
          value: addressType,
          hint: Text('Address Type'),
          isExpanded: true,
          onChanged: null,
          // onChanged: (newValue) {
          //   setState(
          //     () {
          //       addressType = newValue;
          //     },
          //   );
          // },
          items: <String>[
            'Registered Address',
            'Billing Address',
            'Shipping Address'
          ].map((String type) {
            return new DropdownMenuItem<String>(
              value: type,
              child: new Text(type),
            );
          }).toList(),
        )
      ],
    ),
    SizedBox(
      height: 15,
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
                initialValue: 'India',
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              DropdownButton<String>(
                value: states,
                hint: Text('State'),
                isExpanded: true,
                onChanged: null,
                // onChanged: (newValue) {
                //   setState(
                //     () {
                //       this.states = newValue;
                //     },
                //   );
                // },
                items: <String>['India', 'USA'].map((String type) {
                  return new DropdownMenuItem<String>(
                    value: type,
                    child: new Text(type),
                  );
                }).toList(),
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
      height: 15,
    ),
    Divider(
      color: Colors.grey,
    ),
    SizedBox(
      height: 15,
    ),
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
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          ),
        )
      ],
    ),
    SizedBox(
      height: 15,
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
            hintText: "Enter your email",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          ),
        )
      ],
    ),
    SizedBox(
      height: 15,
    ),
    Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          InkWell(
            child: Text('Cancel'),
            onTap: () {},
          ),
          SizedBox(
            width: 15,
          ),
          RaisedButton(
            color: Colors.lightGreen,
            onPressed: () {},
            child: Text(
              'Save Address',
              style: TextStyle(color: Colors.white),
            ),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          )
        ],
      ),
    )
  ],
);


class _ContactState extends State<Contact> {
  bool enableAddNewAddress = false;
  bool enableEditAddress = false;
  Company company;
  CrmServiceImpl get crmService => locator<CrmServiceImpl>();
  getCompanyDetails() async{
    var res = await crmService.getCompanyDetails();
    CompanyRegisterResp companyRegisterResp = CompanyRegisterResp.fromJson(res);
    print(companyRegisterResp);
    company = companyRegisterResp.company;
  }
  @override
  void initState() {
    getCompanyDetails();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Addresses',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 30,
                  child: OutlineButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    highlightColor: Colors.green[900],
                    child: Text(
                      'Add New Address',
                      style: TextStyle(color: Colors.green),
                    ),
                    onPressed: () {
                      setState(() {
                        enableAddNewAddress = true;
                      });
                    }
//                    => Navigator.of(context).push(
//                        new MaterialPageRoute(
//                            builder: (context) => addNewAddress))
                    ,
                    borderSide: BorderSide(
                      color: Colors.green,
                      style: BorderStyle.solid,
                      width: 0.8,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  'Headquarters',
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(
                  width: 40,
                ),
                Text(
                  'REGISTERED',
                  style: TextStyle(
                      color: Colors.white, backgroundColor: Colors.green[700]),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(
                'Opposite Icici street, padala ramareddy law college Road, Yellareddyguda HYDERABAD, Dadra & Nagar Haveli, 254252, India'),
            SizedBox(
              height: 5,
            ),
            Text('Phone : +91 9849831643'),
            SizedBox(
              height: 5,
            ),
            Text('Email : jose.ph.kis.ha.n007@gmail.com'),
            SizedBox(
              height: 8,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  print('ontap clicked');
                  enableEditAddress = true;
                });
              },
              child: Text(
                'Edit Address',
                style: TextStyle(color: Colors.green[700], fontSize: 18),
              ),
            ),
//            editScreen,
          enableEditAddress ? editAddress : Container(),
           enableAddNewAddress ? addNewAddress : Container()
          ],
        ),
      ),
    );
  }
}
