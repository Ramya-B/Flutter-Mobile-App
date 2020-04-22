import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
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
                    onPressed: () {},
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
              onTap: () {},
              child: Text(
                'Edit Address',
                style: TextStyle(color: Colors.green[700], fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
