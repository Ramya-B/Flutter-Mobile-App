import 'package:flutter/material.dart';
import 'package:tradeleaves/components/categories/categories.dart';
import 'package:tradeleaves/components/categories/sub_categories.dart';
import 'package:tradeleaves/components/login_register/register.dart';
import 'package:tradeleaves/podos/categories/categories.dart';
import 'package:tradeleaves/tl-services/catalog/CatalogServiceImpl.dart';

import '../../constants.dart';
import '../../service_locator.dart';

class MarketplaceHomePage extends StatefulWidget {
  @override
  _MarketplaceHomePageState createState() => _MarketplaceHomePageState();
}

class _MarketplaceHomePageState extends State<MarketplaceHomePage> {
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
              for(int i=0;i<this.categoryList.length;i++){
                for (var item in this.categoryList[i].categoryAttribute) {
                  if(item.attributeName == 'ThumbnailImageAttribute' && item.attributeValue != null){
                    this.categoryList[i].thumbnailImage = '${Constants.envUrl}${Constants.mongoImageUrl}/${item.attributeValue}';
                    }
                    else{
                      item.attributeValue = null;
                    }
                  } 
              }
    
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
                image: new AssetImage('assets/homepages/hero_img_tradewinds.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width / 1.6,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: 'GLOBAL TRADING MADE '),
                      TextSpan(
                          text: 'SIMPLE',
                          style: TextStyle(color: Colors.lightGreen))
                    ],
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.2,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: <Widget>[
                Text(
                  'For businesses of EVERY size in EVERY sector.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  softWrap: true,
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text:
                            'Whether you are a trade veteran or just getting started, our user-friendly ',style: TextStyle(fontSize: 15)),
                    TextSpan(
                        text: 'digital marketplace ',
                        style: TextStyle(color: Colors.green[700])),
                    TextSpan(
                        text:
                            'makes increased visibility and exponential growth a few clicks away. It really is as easy as 1, 2, 3!')
                  ], style: TextStyle(fontSize: 15, color: Colors.black)),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: RaisedButton(
                  onPressed: () => {},
                  color: Colors.lightGreen,
                  padding: EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.business,
                        color: Colors.white,
                        size: 40,
                      ),
                      Text(
                        "Buy",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: RaisedButton(
                  onPressed: () => {},
                  color: Colors.lightGreen,
                  padding: EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.select_all,
                        color: Colors.white,
                        size: 40,
                      ),
                      Text(
                        "Sell",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: RaisedButton(
                  onPressed: () => {},
                  color: Colors.lightGreen,
                  padding: EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.business_center,
                        color: Colors.white,
                        size: 40,
                      ),
                      Text(
                        "Service",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height / 1.6,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20),
            color: Colors.black87,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'It really is as easy as 1-2-3!',
                  style: TextStyle(
                      fontSize: 20, color: Colors.lightGreenAccent[700]),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: 35,
                      height: 35,
                      child: Text(
                        '1',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1, color: Colors.white)),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.6,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            'JOIN',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 23, color: Colors.white),
                          ),
                          Text(
                            'Subscribe today for six months at no charge!',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: 35,
                      height: 35,
                      child: Text(
                        '2',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1, color: Colors.white)),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.6,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            'SEARCH',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 23, color: Colors.white),
                          ),
                          Text(
                            'Search for vast network for products and partners!',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: 35,
                      height: 35,
                      child: Text(
                        '3',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1, color: Colors.white)),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.6,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            'TRADE',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 23, color: Colors.white),
                          ),
                          Text(
                            'Connect through our platform and start trading today!',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          )
                        ],
                      ),
                    )
                  ],
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
                  '6 MONTHS FREE',
                  style: TextStyle(fontSize: 25, color: Colors.green[700]),
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
                Container(
                  decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.grey[300]))),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Text(
                    'A one-stop digital shop for buyers, sellers and service providers.',
                    style: TextStyle(fontSize: 22),
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
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    'TradeLeaves Marketplace',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, color: Colors.green[700]),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Whether you are a veteran of the international marketplace or brand new to it, we provide all you need to trade across borders with confidence and ease.',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
              (this.categoryList != null && this.categoryList.length>0)
          ? Container(
              // height: 400,
              // constraints: BoxConstraints(minHeight: 100, maxHeight: 800),
              child: GridView.builder(
                shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  itemCount: this.categoryList.length >= 10
                                  ? 10
                                  : this.categoryList.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: (){
                           Navigator.of(context).push(new MaterialPageRoute(
                              builder: (context) => SubCategoryDeatils(
                              categoryDTO : this.categoryList[index],
                              categoryImage:this.categoryList[index].thumbnailImage 
                              )));
                        },
                        child: Column(
                          children: <Widget>[
                                           (this.categoryList[index].thumbnailImage != null)
                                      ? Center(
                                          child: Container(
                                              width: 120.0,
                                              height: 120.0,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: new NetworkImage(
                                                          '${this.categoryList[index].thumbnailImage}')))),
                                        )
                                      : Container(
                                        child: Icon(Icons.image),
                                      ),
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
                        ),
                    );
                  }))
          : Container(),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => Categories()));
                  },
                                  child: Container(
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
                SizedBox(
                  height: 15,
                ),
                Text(
                  'You will get it all with',
                  style: TextStyle(fontSize: 25, color: Colors.green[700]),
                ),
                SizedBox(
                  height: 70,
                  width: MediaQuery.of(context).size.width / 1.4,
                  child: Image.asset("assets/tllogo.png", fit: BoxFit.contain),
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
                              border:
                                  Border(top: BorderSide(color: Colors.grey))),
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
                              border:
                                  Border(top: BorderSide(color: Colors.grey))),
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
                              border:
                                  Border(top: BorderSide(color: Colors.grey))),
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
                              border:
                                  Border(top: BorderSide(color: Colors.grey))),
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
                              border:
                                  Border(top: BorderSide(color: Colors.grey))),
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
                              border:
                                  Border(top: BorderSide(color: Colors.grey))),
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
                              border:
                                  Border(top: BorderSide(color: Colors.grey))),
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
                              border:
                                  Border(top: BorderSide(color: Colors.grey))),
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
                              border:
                                  Border(top: BorderSide(color: Colors.grey))),
                        ),
                      ],
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 20,
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
                  'Join our vibrant, rapidly expanding community to get all the benefits before the offer runs out!',
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
