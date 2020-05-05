import 'package:flutter/material.dart';
class LeadsDetailPage extends StatefulWidget {
  final int customerRequestId;
  LeadsDetailPage({
    this.customerRequestId
  });
  @override
  _LeadsDetailPageState createState() => _LeadsDetailPageState();
}

class _LeadsDetailPageState extends State<LeadsDetailPage> {
  int customerRequestId;
  @override
  void initState() {
    this.customerRequestId = widget.customerRequestId;
    print("printing the customer request id");
    print(this.customerRequestId);
    super.initState();
  }
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    bool showAttributes = false;

    return Scaffold(
     body: SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FlatButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: Colors.green[700],
                  ),
                  label: Text(
                    'Back',
                    style: TextStyle(color: Colors.green[700], fontSize: 18),
                  )),
              Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: size.width,
                      child: Text(
                        'Posting an inquiry to the marketplace from inquiry loisting view',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      width: size.width,
                      height: size.height / 6,
                      decoration: BoxDecoration(color: Colors.grey[300]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Lead ID: ',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 16)),
                                  TextSpan(
                                      text: ' DEV-INQ-0005-1-2019',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black87))
                                ],
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                          RichText(
                            text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'LoB: ',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 16)),
                                  TextSpan(
                                      text: 'BLISS',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black87))
                                ],
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                          RichText(
                            text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Country: ',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 16)),
                                  TextSpan(
                                      text: 'India',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black87))
                                ],
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                          RichText(
                            text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Status: ',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 16)),
                                  TextSpan(
                                      text: 'Accepted',
                                      style: TextStyle(
                                          backgroundColor: Colors.green,
                                          fontSize: 16,
                                          color: Colors.white))
                                ],
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    RichText(
                      text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Notes: ',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 16)),
                            TextSpan(
                                text:
                                'Posting an inquiry to the marketplace from inquiry loisting view',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black87))
                          ],
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton.icon(
                            onPressed: () {
                              setState(() {
                                showAttributes = true;
                              });
                            },
                            icon: Icon(
                              Icons.menu,
                              size: 17,
                              color: Colors.green[700],
                            ),
                            label: Text(
                              'Show Attributes',
                              style: TextStyle(
                                  color: Colors.green[700], fontSize: 14),
                            )),
                      ],
                    ),
                    Table(
                      border: TableBorder.all(),
                      children: [
                        TableRow(children: [
                          Container(
                            height: 40,
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            child: Text('Dev In user19 Pvt Ltd2',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ]),
                        TableRow(children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(8),
                                  width: size.width / 2,
                                  height: size.height / 11,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text('Sent Quote as per the request',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                      Text('7 months ago',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  width: size.width / 2,
                                  height: size.height / 11,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text('Sent Quote as per the request',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                      Text('7 months ago',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 60,
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      width: size.width / 1.6,
                                      height: size.height / 6.5,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        border: Border.all(),
                                      ),
                                      child: TextField(
                                        maxLines: 200,
                                        decoration: InputDecoration(
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: size.height / 6.5,
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            IconButton(
                                              icon: Icon(
                                                Icons.attach_file,
                                                color: Colors.green,
                                              ),
                                              onPressed: null,
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.send,
                                                color: Colors.green,
                                              ),
                                              onPressed: null,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: size.width,
                      decoration: BoxDecoration(border: Border.all(width: 0.5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(left: 15, top: 8),
                              child: Text(
                                'Quote Sent',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          Divider(
                            color: Colors.black,
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                RichText(
                                  text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Quote ID: ',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16)),
                                        TextSpan(
                                            text: 'QUT-0002.1-2019',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black87))
                                      ],
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  width: size.width,
                                  padding: EdgeInsets.all(5),
                                  decoration:
                                  BoxDecoration(color: Colors.lightGreen),
                                  child: Text(
                                    'Product Details',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                InkWell(
                                  child: Text(
                                    'Long grain Basmathi Rice',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.green),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                RichText(
                                  text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Order Quantity: ',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16)),
                                        TextSpan(
                                            text: '100000 Kilogram',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black87))
                                      ],
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                                RichText(
                                  text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Unit Price: ',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16)),
                                        TextSpan(
                                            text: '10,000.00',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black87))
                                      ],
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                                RichText(
                                  text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Order Value: ',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16)),
                                        TextSpan(
                                            text: '1,000,000,000.00',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black87))
                                      ],
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Container(
                                  width: size.width,
                                  padding: EdgeInsets.all(5),
                                  decoration:
                                  BoxDecoration(color: Colors.lightGreen),
                                  child: Text(
                                    'Delivery Details',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Delivered By: ',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16)),
                                        TextSpan(
                                            text: '11/26/2019',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black87))
                                      ],
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                                RichText(
                                  text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                            'Delivered Terms(IncoTerms): ',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16)),
                                        TextSpan(
                                            text: 'CIF, CIP',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black87))
                                      ],
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                                RichText(
                                  text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Payment Method: ',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16)),
                                        TextSpan(
                                            text: 'Cheque/DD, Escrow',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black87))
                                      ],
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Container(
                                  width: size.width,
                                  padding: EdgeInsets.all(5),
                                  decoration:
                                  BoxDecoration(color: Colors.lightGreen),
                                  child: Text(
                                    'Document Details',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    InkWell(
                                      child: Text(
                                        'Show History',
                                        style: TextStyle(color: Colors.green),
                                      ),
                                      onTap: () {},
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    SizedBox(
                                      height: 25,
                                      child: RaisedButton(
                                        color: Colors.green,
                                        onPressed: () {},
                                        child: Text(
                                          'Send Quote',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(20)),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }
}

