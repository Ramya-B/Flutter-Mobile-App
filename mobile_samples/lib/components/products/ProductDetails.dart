import 'package:flutter/material.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;
import 'package:tradeleaves/components/products/ProductsList.dart';
import 'package:tradeleaves/podos/products/product.dart';

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
      appBar: CustomToolBar(),
      body: ListView(
        children: <Widget>[
          Card(
            child: Container(
              margin: EdgeInsets.all(10.0),
              height: 250,
              width: 250,
              child: Image.network(
                  'http://uat.tradeleaves.internal/tl/public/assest/get/${widget.productDTO.primaryImageUrl}'),
            ),
          ),
          Card(

            child: Column(
              children: <Widget>[
              new Container(
                 padding:EdgeInsets.all(5.0),
                child: new ListView.builder(
                scrollDirection: Axis.vertical,
            shrinkWrap: true,
                  itemCount: prods.length,
                  itemBuilder: (BuildContext context, int index){
                    String key = prods.keys.elementAt(index);
                   String value = prods.values.elementAt(index);
                    return new Row(
                      children: <Widget>[
                         Container(
                          alignment: Alignment.topCenter,
                          height: 40,
                          width: 150,
                          child: Text(
                            '$key :',
                            style: TextStyle(fontSize: 15, color: Colors.black54),
                          )),
                          Expanded(
                          child: Container(
                              height: 40,
                              alignment: Alignment.topLeft,
                              child: Text("$value",overflow: TextOverflow.ellipsis,
                                  style:
                                      TextStyle(fontSize: 15, color: Colors.black)))),
                      
                      ],
                    );
                  },

                )),             
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavBar(selectedIndex: 0),
    );
  }
}
