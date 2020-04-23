import 'package:flutter/material.dart';
import 'package:tradeleaves/components/login_register/register.dart';
import 'package:tradeleaves/podos/categories/categories.dart';
import 'package:tradeleaves/tl-services/catalog/CatalogServiceImpl.dart';

import '../../constants.dart';
import '../../service_locator.dart';

class BLISSHomePage extends StatefulWidget {
  @override
  _BLISSHomePageState createState() => _BLISSHomePageState();
}

class _BLISSHomePageState extends State<BLISSHomePage> {
  CatalogServiceImpl get catalogService => locator<CatalogServiceImpl>();
  List<CategoryDTO> categoryList = [];

  getCategories() async {
    print("getCategories called...");
    CategoryDetailsLobDTO categoryDetailsLobDTO = new CategoryDetailsLobDTO();
    categoryDetailsLobDTO.lobId = ["34343e34-7601-40de-878d-01b3bd1f0641"];
    categoryDetailsLobDTO.systemRootCategoryFlag = false;
    categoryDetailsLobDTO.restrictFetchImage = false;
    categoryDetailsLobDTO.active = true;

    var data = await catalogService.getCategories(categoryDetailsLobDTO);
    setState(() {
      print("Categories from node...");
      print(data);
      this.categoryList =
          List<CategoryDTO>.from(data.map((f) => CategoryDTO.fromJson(f)))
              .toList();
    });
  }

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('assets/homepages/bliss-domestic.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
             decoration: new BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 30.0, // soften the shadow
            spreadRadius: 5.0, //extend the shadow
            offset: Offset(
              15.0, // Move to right 10  horizontally
              15.0, // Move to bottom 10 Vertically
            ),
          )
        ],
    ),
              width: MediaQuery.of(context).size.width / 1.4,
              child: Text(
                  'ELEVATE YOUR BUSINESS VISIBILITY LOCALLY OR GLOBALLY',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 9,
            width: MediaQuery.of(context).size.width,
            color: Colors.black87,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Buy, sell and search our Classifieds.',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'GET 3 MONTHS FREE  >',
                    style: TextStyle(color: Colors.lightGreen, fontSize: 15),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.2,
            margin: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Text(
                  'With TradeLeaves BLISS, You Get it All!',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.4,
                  child: Text(
                    'Expand your business horizon - local to global. Get genuine inquiries from verified buyers and a whole lot more!',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.verified_user,
                        color: Colors.green[700],
                        size: 18,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Online visibility",
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.grey))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.verified_user,
                        color: Colors.green[700],
                        size: 18,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Manage products and services",
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.grey))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.verified_user,
                        color: Colors.green[700],
                        size: 18,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Real-time communication with buyers",
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.grey))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.verified_user,
                        color: Colors.green[700],
                        size: 18,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Verified seal",
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.grey))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.verified_user,
                        color: Colors.green[700],
                        size: 18,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Promote products and services",
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.grey))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.verified_user,
                        color: Colors.green[700],
                        size: 18,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Analytics",
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.grey))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.verified_user,
                        color: Colors.green[700],
                        size: 18,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Manage company profile",
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.grey))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.verified_user,
                        color: Colors.green[700],
                        size: 18,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Get genuine relevant inquiries",
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.grey))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.verified_user,
                        color: Colors.green[700],
                        size: 18,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Enhanced digital presence",
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.grey))),
                  ),
                ],
              )),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 30,
            child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(30),
                color: Colors.lightGreen,
                child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width / 2,
                    onPressed: () {
                      Navigator.push(
                       context, MaterialPageRoute(builder: (context) => Register()));
                    },
                    child: Text("Sign Me Up For Free Today",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white)))),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2.2,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey[200],
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(
                  Icons.verified_user,
                  color: Colors.green,
                  size: 20,
                ),
                Text(
                  "LIMITED TIME ONLY",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.lightGreenAccent[700], fontSize: 25),
                ),
                Text(
                  '3 MONTHS FREE',
                  style: TextStyle(fontSize: 25, color: Colors.green[700]),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.grey[300]))),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Text(
                    'Buy, sell and search our Classifieds.',
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.green[700],
                      child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width / 2,
                          onPressed: () {
                              Navigator.push(
                       context, MaterialPageRoute(builder: (context) => Register()));
                          },
                          child: Text("Sign Me Up For Free Today",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white)))),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    'Categories',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 34, color: Colors.green[700]),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'List your products for Global visibility',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: this.categoryList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: this
                                          .categoryList[index]
                                          .categoryAttribute
                                          .length >
                                      9
                                  ? 9
                                  : this
                                      .categoryList[index]
                                      .categoryAttribute
                                      .length,
                              itemBuilder: (context, int index1) {
                                return (this
                                            .categoryList[index]
                                            .categoryAttribute[index1]
                                            .attributeName ==
                                        'ThumbnailImageAttribute')
                                    ? Center(
                                        child: Container(
                                            width: 120.0,
                                            height: 120.0,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: new NetworkImage(
                                                        '${Constants.envUrl}${Constants.mongoImageUrl}/${this.categoryList[index].categoryAttribute[index1].attributeValue}')))),
                                      )
                                    : Container();
                              }),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "${this.categoryList[index].name}",
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      );
                    }),
                SizedBox(
                  height: 15,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 120,
                  width: 120,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey[200]),
                  child: Container(
                      width: MediaQuery.of(context).size.width / 1.6,
                      child: Text(
                        'VIEW ALL CATEGORIES',
                        textAlign: TextAlign.center,
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 30,
                  child: Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.green[700],
                      child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width / 2,
                          onPressed: () {
                              Navigator.push(
                       context, MaterialPageRoute(builder: (context) => Register()));
                          },
                          child: Text("Sign Me Up For Free Today",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white)))),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.7,
            color: Colors.lightGreen,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Join our B2B Online Directory and become visible to Local, Domestic and Global Business.',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                  child: Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.green[700],
                      child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width / 2,
                          onPressed: () {
                              Navigator.push(
                       context, MaterialPageRoute(builder: (context) => Register()));
                          },
                          child: Text("Sign Me Up For Free Today",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white)))),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
