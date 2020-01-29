import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;
import 'package:flutter/src/widgets/scroll_view.dart';
import 'package:tradeleaves/components/products/ProductDetails.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var prodList = [
    {
      "productName": "Fortunure Car",
      "productDescription": "Fortunure car description",
      "supplierName": "My Dream Company",
      "cost": 8900000,
      "imageUrl": "pexels-photo-116675.jpeg"
    },
    {
      "productName": "Porshe Car",
      "productDescription": "Porshecar description ",
      "supplierName": "Porshe Car showroom",
      "cost": 6800000,
      "imageUrl": "pexels-photo-977003.jpeg"
    },
    {
      "productName": "Ferrari Car",
      "productDescription": "Ferrari car description",
      "supplierName": "Ferrari Car showroom",
      "cost": 6900000,
      "imageUrl": "pexels-photo-544542.jpeg"
    },
    {
      "productName": "BMW Car",
      "productDescription": "BMW car description",
      "supplierName": "BMW Car showroom",
      "cost": 9700000,
      "imageUrl": "pexels-photo-707046.jpeg"
    }, {
      "productName": "Fortunure Car",
      "productDescription": "Fortunure car description",
      "supplierName": "My Dream Company",
      "cost": 8900000,
      "imageUrl": "pexels-photo-116675.jpeg"
    },
    {
      "productName": "Porshe Car",
      "productDescription": "Porshecar description ",
      "supplierName": "Porshe Car showroom",
      "cost": 6800000,
      "imageUrl": "pexels-photo-977003.jpeg"
    },
    {
      "productName": "Ferrari Car",
      "productDescription": "Ferrari car description",
      "supplierName": "Ferrari Car showroom",
      "cost": 6900000,
      "imageUrl": "pexels-photo-544542.jpeg"
    },
    {
      "productName": "BMW Car",
      "productDescription": "BMW car description",
      "supplierName": "BMW Car showroom",
      "cost": 9700000,
      "imageUrl": "pexels-photo-707046.jpeg"
    }, {
      "productName": "Fortunure Car",
      "productDescription": "Fortunure car description",
      "supplierName": "My Dream Company",
      "cost": 8900000,
      "imageUrl": "pexels-photo-116675.jpeg"
    },
    {
      "productName": "Porshe Car",
      "productDescription": "Porshecar description ",
      "supplierName": "Porshe Car showroom",
      "cost": 6800000,
      "imageUrl": "pexels-photo-977003.jpeg"
    },
    {
      "productName": "Ferrari Car",
      "productDescription": "Ferrari car description",
      "supplierName": "Ferrari Car showroom",
      "cost": 6900000,
      "imageUrl": "pexels-photo-544542.jpeg"
    },
    {
      "productName": "BMW Car",
      "productDescription": "BMW car description",
      "supplierName": "BMW Car showroom",
      "cost": 9700000,
      "imageUrl": "pexels-photo-707046.jpeg"
    }
  ];
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
            onTap: () =>Navigator.of(context).push(new MaterialPageRoute(
              builder: (context) => new ProductDetails(
                 productName: productName,
                productDescription: productDescription,
                supplierName: supplierName,
                cost: cost,
                imageUrl: imageUrl,


              )
            )),
            child: Container(
                child:  Image.asset('assets/cars/$imageUrl',
                    fit: BoxFit.contain),

            ),
          ),
    );
  }
}

// class DBConnection {
//   static DBConnection _instance;

//   final String _host = "10.0.2.2";
//   final String _port = "27017";
//   final String _dbName = "tlapp";
//   Db _db;

//   static getInstance() {
//     if (_instance == null) {
//       _instance = DBConnection();
//     }
//     return _instance;
//   }

//   Future<Db> getConnection() async {
//     if (_db == null) {
//       try {
//         _db = Db(_getConnectionString());
//         await _db.open();
//       } catch (e) {
//         print(e);
//       }
//     }
//     return _db;
//   }

//   _getConnectionString() {
//     return "mongodb://$_host:$_port/$_dbName";
//   }

//   closeConnection() {
//     _db.close();
//   }
// }
