import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';
import 'package:tradeleaves/components/CustomDrawer.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;

class Favourite extends StatefulWidget {
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  var favList = [];

  getFavRecords() async {
    Db db = new Db("mongodb://192.168.241.214:27017/tlapp");
    DbCollection coll;
    await db.open();
    print('fav records called..');
    coll = db.collection("products");
    await coll.find({'isFavourited': true}).forEach((v) => favList.add(v));
    setState(() {
      this.favList = favList;
    });
    print("favourite records...");
    print(favList);
    db.close();
  }

  @override
  void initState() {
    getFavRecords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomToolBar(),
        drawer: CustomDrawer(),
        bottomNavigationBar: CustomNavBar(selectedIndex: 0),
        body: ListView.builder(
            itemCount: favList.length,
            itemBuilder: (BuildContext context, int index) {
              return SingleFav(
                id: favList[index]['_id'],
                productName: favList[index]['productName'],
                productDescription: favList[index]['productDescription'],
                supplierName: favList[index]['supplierName'],
                cost: favList[index]['cost'],
                imageUrl: favList[index]['imageUrl'],
                isFavourited: favList[index]['isFavourited'],
                isCarted: favList[index]['isCarted'],
                isOrdered: favList[index]['isOrdered'],
                category: favList[index]['category'],
              );
            }));
  }
}

class SingleFav extends StatefulWidget {
  final id;
  final productName;
  final productDescription;
  final supplierName;
  final cost;
  final imageUrl;
  final isFavourited;
  final isCarted;
  final isOrdered;
  final category;

  SingleFav(
      {this.id,
      this.productName,
      this.productDescription,
      this.supplierName,
      this.cost,
      this.isFavourited,
      this.isCarted,
      this.isOrdered,
      this.imageUrl,
      this.category});

  @override
  _SingleFavState createState() => _SingleFavState();
}

class _SingleFavState extends State<SingleFav> {
  bool isFavourited;
  bool isOrdered;
  bool isCarted;

  void initState() {
    this.isFavourited = widget.isFavourited;
    this.isOrdered = widget.isOrdered;
    this.isCarted = widget.isCarted;
    super.initState();
  }

  void save(type, value) async {
    Db db = new Db("mongodb://192.168.241.214:27017/tlapp");
    DbCollection coll;
    await db.open();
    print('save called');
    coll = db.collection("products");
    if (type != null) {
      var res = await coll.findOne({'_id': widget.id});
      if (type == 'favourite') {
        res["isFavourited"] = value;
      } else if (type == 'cart') {
        res["isCarted"] = value;
      } else if (type == 'order') {
        res["isOrdered"] = value;
      }
      await coll.save(res);
    }
    db.close();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () => Navigator.of(context).push(new MaterialPageRoute(
      //     builder: (context) => new ProductDetails(
      //           productName: widget.productName,
      //           productDescription: widget.productDescription,
      //           supplierName: widget.supplierName,
      //           cost: widget.cost,
      //           imageUrl: widget.imageUrl,
      //           category: widget.category,
      //         ))),
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              child: Image.asset(
                widget.imageUrl,
                width: 100,
                height: 100,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                height: 100,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Column(
                      children: <Widget>[
                        Container(
                            child: Text(widget.productName,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black87)),
                            alignment: Alignment.topLeft),
                      ],
                    )),
                    Container(
                        child: IconButton(
                            icon: Icon(
                              (this.isFavourited)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: (this.isFavourited)
                                  ? Colors.green
                                  : Colors.blueGrey,
                            ),
                            onPressed: () {
                              setState(() {
                                if (this.isFavourited == true) {
                                  this.isFavourited = false;
                                } else {
                                  this.isFavourited = true;
                                }
                                save('favourite', this.isFavourited);
                              });
                            }),
                        alignment: Alignment.topCenter)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
