import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/CustomDrawer.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;
import 'package:tradeleaves/components/products/CategoryProductDetails.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  var categoryList = [];
  getCategoryRecords()async{
    Db db = new Db("mongodb://192.168.241.214:27017/tlapp");
    DbCollection coll;
    await db.open();
    print('connection open mongo');
    coll = db.collection("categories");

    await coll.find().forEach((v) => categoryList.add(v));
    setState(() {
      this.categoryList = categoryList;
    });
    print("after getting all records...");
    print(categoryList);
    db.close();

  }

  @override
  void initState() {
    // TODO: implement initState
    getCategoryRecords();
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomToolBar() ,
      drawer: CustomDrawer(),
      bottomNavigationBar: CustomNavBar(selectedIndex: 0),
      body:  GridView.builder(
          itemCount: categoryList.length,
          gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return SingleCategory(
              categoryName: categoryList[index]['categoryName'],
              categoryImage: categoryList[index]['categoryImage'],
            );
          }),
    );
  }
}

class SingleCategory extends StatelessWidget {
  final categoryName ;
  final categoryImage;
  SingleCategory({this.categoryName,this.categoryImage});
  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => CategoryProducts(
                  categoryName : categoryName,
                  categoryImage : categoryImage
                ))),
            child: Column(
              children: <Widget>[
                Image.asset('$categoryImage', height: 130,
                  width: 130,),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text('$categoryName',
                      style: TextStyle(fontSize: 20, color: Colors.black45),
                    ),
                  ),
                )
              ],
            )
        )
    );
  }
}
