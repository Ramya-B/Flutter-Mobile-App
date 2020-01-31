import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;
import 'package:tradeleaves/components/products/ProductDetails.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class SingleProduct extends StatelessWidget {
  final productName;
  final productDescription;
  final supplierName;
  final cost;
  final imageUrl;

  SingleProduct(
      {this.productName,
      this.productDescription,
      this.supplierName,
      this.cost,
      this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.of(context).push(new MaterialPageRoute(
            builder: (context) => new ProductDetails(
                  productName: productName,
                  productDescription: productDescription,
                  supplierName: supplierName,
                  cost: cost,
                  imageUrl: imageUrl,
                ))),
        child: Container(
          padding: EdgeInsets.all(4.0),
          child: Column(
            children: <Widget>[
              Image.asset(
                '$imageUrl',
                height: 155,
                width: 180,
              ),
              Container(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    productName,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductsState extends State<Products> {
  var prodList = [];

  getProdRecords() async {
    Db db = new Db("mongodb://10.0.2.2:27017/tlapp");
    DbCollection coll;
    await db.open();
    print('connection open mongo');
    coll = db.collection("products");

    await coll.find().forEach((v) => prodList.add(v));
    setState(() {
      this.prodList = prodList;
    });
    print("after getting all records...");
    print(prodList);
    db.close();
  }

  @override
  void initState() {
    // TODO: implement initState

    getProdRecords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: prodList.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return SingleProduct(
            productName: prodList[index]['productName'],
            productDescription: prodList[index]['productDescription'],
            supplierName: prodList[index]['supplierName'],
            cost: prodList[index]['cost'],
            imageUrl: prodList[index]['imageUrl'],
          );
        });
  }
}
