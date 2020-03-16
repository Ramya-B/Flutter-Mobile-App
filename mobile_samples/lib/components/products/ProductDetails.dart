import 'package:flutter/material.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';

import '../../constants.dart';

class ProductDetails extends StatefulWidget {
  final productDTO;
  final supplierDTO;
 

  ProductDetails({
    this.productDTO,
    this.supplierDTO,
  });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Map<String, dynamic> prods;
 var prodAttrs =  ["productName","productUniqueId"];
  @override
  void initState() {
    print("inittt....");
    print(widget.productDTO);
    print(widget.productDTO.toJson());
    prods = widget.productDTO.toJson();
    print(prods);
    prods.forEach((k, v) => print(k));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomToolBar(),
      body: ListView(
        children: <Widget>[
          Card(
            child: Container(
              margin: EdgeInsets.all(10.0),
              height: 250,
              width: 250,
              child: Image.network(
                  '${Constants.envUrl}${Constants.mongoImageUrl}/${widget.productDTO.primaryImageUrl}'),
            ),
          ),

          Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Row(children: <Widget>[
                    Expanded(
                      child: Text(
                        '${widget.supplierDTO.supplierName}',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Open Sans',
                        ),
                      ),
                    ),
                    new IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.green,
                        ),
                        onPressed: () => {}),
                  ]),
                  Row(children: <Widget>[
                    Icon(
                      Icons.verified_user,
                      color: Colors.green,
                      size: 20,
                    ),
                    (widget.supplierDTO.supplierStatus == 'APPROVED')
                        ? Text(
                            "Verified Supplier",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          )
                        : Text('${widget.supplierDTO.supplierStatus}'),
                  ]),
                  widget.supplierDTO.rating != 0
                      ? Container(
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.topLeft,
                          child: Column(children: <Widget>[
                            Text(
                              '${widget.supplierDTO.rating.toStringAsFixed(1)}*',
                              style: TextStyle(
                                  color: Colors.lightGreen, fontSize: 16),
                            ),
                            Text(
                              'rating',
                              style: TextStyle(fontSize: 12),
                            ),
                          ]),
                        )
                      : Container(),
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: Row(children: <Widget>[
                      Text(
                        'address:',
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                      Text(
                          '${widget.supplierDTO.supplierCity},${widget.supplierDTO.supplierCountry}')
                    ]),
                  ),
                ],
              )),
          Container(
            padding: EdgeInsets.all(10),
            constraints: BoxConstraints(minHeight: 250),
            margin: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.tealAccent)),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child:
                      Text('Product Details', style: TextStyle(fontSize: 20)),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(5),
                  child: Text(prods["productName"],style: TextStyle(fontSize: 18,
                  ),),
                ),
                Container(
                  height: 200,
                  child: ListView.builder(
                   physics: const NeverScrollableScrollPhysics(),
                    itemCount: this.prods.length,
                    itemBuilder: (BuildContext context,int index){
                      var key = prods.keys.elementAt(index).toString();
                      return (prodAttrs.contains(key)) ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(child:  Container(
                            padding: EdgeInsets.all(5.0),
                            alignment: Alignment.topCenter,
                            child:  Text(
                        '$key:',
                        style: TextStyle(color: Colors.blueGrey)),
                          )
                      ),
                      Expanded(child:Container(
                         padding: EdgeInsets.all(5.0),
                        alignment: Alignment.topLeft,
                        child:   Text(
                          '${prods.values.elementAt(index).toString()}',overflow: TextOverflow.ellipsis,maxLines: 2,)),
                      )
                     
                        ],

                      ):Container();
                  }),
                ),
               
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.tealAccent)),
            height: 250,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child:
                      Text('Technical Specs', style: TextStyle(fontSize: 20)),
                ),
                Container(
                  height: 200,
                  alignment: Alignment.center,
                  child:Text('Technical specs are not defined for this product'),
                )
                
                
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.tealAccent)),
            height: 250,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: Text('FAQ\'s', style: TextStyle(fontSize: 20)),
                ),
                Container(
                  height: 200,
                  alignment: Alignment.center,
                  child:Text('No faqs are posted'),
                )
              ],
            ),
          ),
          // Card(

          //   child: Column(
          //     children: <Widget>[
          //     new Container(
          //        padding:EdgeInsets.all(5.0),
          //       child: new ListView.builder(
          //       scrollDirection: Axis.vertical,
          //   shrinkWrap: true,
          //         itemCount: prods.length,
          //         itemBuilder: (BuildContext context, int index){
          //           String key = prods.keys.elementAt(index);
          //          String value = prods.values.elementAt(index);
          //           return new Row(
          //             children: <Widget>[
          //                Container(
          //                 alignment: Alignment.topCenter,
          //                 height: 40,
          //                 width: 150,
          //                 child: Text(
          //                   '$key :',
          //                   style: TextStyle(fontSize: 15, color: Colors.black54),
          //                 )),
          //                 Expanded(
          //                 child: Container(
          //                     height: 40,
          //                     alignment: Alignment.topLeft,
          //                     child: Text("$value",overflow: TextOverflow.ellipsis,
          //                         style:
          //                             TextStyle(fontSize: 15, color: Colors.black)))),

          //             ],
          //           );
          //         },

          //       )),
          //     ],
          //   ),
          // ),
        ],
      ),
      bottomNavigationBar: CustomNavBar(selectedIndex: 0),
    );
  }
}
