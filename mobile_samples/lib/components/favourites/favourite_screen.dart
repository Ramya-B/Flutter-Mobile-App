import 'package:flutter/material.dart';
import 'package:tradeleaves/components/contact_supplier/contact_supplier.dart';
import 'package:tradeleaves/components/products/ProductDetails.dart';
import 'package:tradeleaves/models/favouriteProductsListDTO.dart';
import 'package:tradeleaves/models/index.dart';
import 'package:tradeleaves/tl-services/catalog/CatalogServiceImpl.dart';

import '../../constants.dart';
import '../../service_locator.dart';

class FavouritePage extends StatefulWidget {
   final List<FavouriteProductsListDTO> favProds;
   final List<FavouriteSuppliersDto> favSuppliers;
  FavouritePage({this.favProds,this.favSuppliers});
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  bool selectProducts = false;
  bool selectSuppliers = false;

  bool product1 = false;
  bool product2 = false;
  bool product3 = false;
  bool product4 = false;

  bool supplier1 = false;
  bool supplier2 = false;
  bool supplier3 = false;
  bool supplier4 = false;

  var suppliers;
  var products;

   handleFav(ProductDTO productDTO,SupplierDTO supplierDTO) async{
    setState(() {
      productDTO.isFavorited = !productDTO.isFavorited;
    });
    FavouriteProductsDTO favouriteProductsDTO = new FavouriteProductsDTO();
    favouriteProductsDTO.productId = productDTO.productId;
    favouriteProductsDTO.productImageUrl = productDTO.primaryImageUrl;
    favouriteProductsDTO.suppplierName = supplierDTO.supplierName;
    favouriteProductsDTO.partyId = supplierDTO.supplierId;
    catalogService.handleFavorites(favouriteProductsDTO);
  }

  CatalogServiceImpl get catalogService => locator<CatalogServiceImpl>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        
        appBar: AppBar(
           iconTheme: new IconThemeData(color: Colors.green),
          backgroundColor: Colors.white,
          title: Text(
            'My Favourites',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.black.withOpacity(0.4),
            indicatorColor: Colors.green,
            labelColor: Colors.green,
            unselectedLabelStyle: TextStyle(color: Colors.black),
            tabs: <Widget>[
              Tab(
                child: Text(
                  'PRODUCTS',
                ),
              ),
              Tab(
                child: Text(
                  'SUPPLIERS',
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            //this for products
            (widget.favProds!= null && widget.favProds.length>0)
                ? ListView(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          // CheckboxListTile(
                          //   title: Text(
                          //     'Select All',
                          //     style: TextStyle(color: Colors.black),
                          //   ),
                          //   value: selectProducts,
                          //   activeColor: Colors.green,
                          //   checkColor: Colors.white,
                          //   onChanged: (bool value) {
                          //     setState(() {
                          //       this.selectProducts = value;
                          //       this.product1 = value;
                          //       this.product2 = value;
                          //       this.product3 = value;
                          //       this.product4 = value;
                          //     });
                          //   },
                          //   controlAffinity: ListTileControlAffinity.leading,
                          // ),
                          // Container(
                          //   decoration: BoxDecoration(
                          //       border: Border(
                          //           top: BorderSide(color: Colors.grey))),
                          // ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          Container(
                            child: ListView.builder(
                              itemCount: widget.favProds.length,
                              physics: new NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context,int index){
                              return InkWell(
                                onTap: (){
                                  Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (context) => new ProductDetails(
                                        productDTO:widget.favProds[index].productDTO,
                                        supplierDTO:widget.favProds[index].supplierSearchDTO,
                                      )));
                                },
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                height: 140,
                                width: 400,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(0),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // CheckboxListTile(
                                  //   value: product1,
                                  //   activeColor: Colors.green,
                                  //   checkColor: Colors.white,
                                  //   onChanged: (bool value) {
                                  //     setState(() {
                                  //       this.product1 = value;
                                  //     });
                                  //   },
                                  //   controlAffinity:
                                  //       ListTileControlAffinity.leading,
                                  // ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        widget.favProds[index].productDTO.primaryImageUrl !=null ?Image.network(
                                         '${Constants.envUrl}${Constants.mongoImageUrl}/${widget.favProds[index].productDTO.primaryImageUrl}' ,
                                          width: 100.0,
                                          height: 100.0,
                                          fit: BoxFit.cover,
                                        ):Container(),
                                        
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                 Container(
                                                   padding: EdgeInsets.all(10),
                                              width: 220,
                                              child: InkWell(
                                                child: Text(
                                                  '${widget.favProds[index].productDTO.productName}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                onTap: () {},
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                              child: IconButton(icon: Icon(widget.favProds[index].productDTO.isFavorited ? Icons.favorite_border:Icons.favorite ),color:Colors.green ,onPressed: (){
                                                handleFav(widget.favProds[index].productDTO,widget.favProds[index].supplierSearchDTO);
                                              },),
                                              
                                            ),
                                             Container(
                                              child: IconButton(icon: Icon(Icons.message),color:Colors.green,onPressed: (){
                                                Navigator.of(context).push(new MaterialPageRoute(
                                              builder: (context) => new ContactSupplier()));
                                              },))
                                              ],
                                            )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            // Text('Min. Order : 100 Piece(s)')
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                 /*  Container(
                                    child: Table(
                                      border: TableBorder.all(),
                                      children: [
                                        TableRow(children: [
                                          Container(
                                            height: 30,
                                            alignment: Alignment.center,
                                            color: Colors.grey[300],
                                            child: Text('Incoterm',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                                textAlign: TextAlign.center),
                                          ),
                                          Container(
                                            height: 30,
                                            alignment: Alignment.center,
                                            color: Colors.grey[300],
                                            child: Text('Range',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                                textAlign: TextAlign.center),
                                          ),
                                          Container(
                                            height: 30,
                                            alignment: Alignment.center,
                                            color: Colors.grey[300],
                                            child: Text('Price',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                                textAlign: TextAlign.center),
                                          ),
                                          Container(
                                            height: 30,
                                            alignment: Alignment.center,
                                            color: Colors.grey[300],
                                            child: Text('Quantity(per)',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                                textAlign: TextAlign.center),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            height: 30,
                                            alignment: Alignment.center,
                                            child: Text('CFR',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                                textAlign: TextAlign.center),
                                          ),
                                          Container(
                                            height: 30,
                                            alignment: Alignment.center,
                                            child: Text('1-100',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                                textAlign: TextAlign.center),
                                          ),
                                          Container(
                                            height: 30,
                                            alignment: Alignment.center,
                                            child: Text('500/-',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                                textAlign: TextAlign.center),
                                          ),
                                          Container(
                                            height: 30,
                                            alignment: Alignment.center,
                                            child: Text('Piece(s)',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                                textAlign: TextAlign.center),
                                          )
                                        ])
                                      ],
                                    ),
                                  ), */
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  // Row(
                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceAround,
                                  //   children: <Widget>[
                                  //     SizedBox(
                                  //       height: 25,
                                  //       child: OutlineButton(
                                  //         shape: new RoundedRectangleBorder(
                                  //             borderRadius:
                                  //                 new BorderRadius.circular(
                                  //                     30.0)),
                                  //         highlightColor: Colors.green[900],
                                  //         child: Text(
                                  //           'Contact Supplier',
                                  //           style: TextStyle(color: Colors.green),
                                  //         ),
                                  //         onPressed: () {},
                                  //         borderSide: BorderSide(
                                  //           color: Colors.green,
                                  //           style: BorderStyle.solid,
                                  //           width: 0.8,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     SizedBox(
                                  //       height: 25,
                                  //       width: 150,
                                  //       child: OutlineButton(
                                  //         shape: new RoundedRectangleBorder(
                                  //             borderRadius:
                                  //                 new BorderRadius.circular(
                                  //                     30.0)),
                                  //         highlightColor: Colors.green[900],
                                  //         child: Text(
                                  //           'Chat Now',
                                  //           style: TextStyle(color: Colors.green),
                                  //         ),
                                  //         onPressed: () {},
                                  //         borderSide: BorderSide(
                                  //           color: Colors.green,
                                  //           style: BorderStyle.solid,
                                  //           width: 0.8,
                                  //         ),
                                  //       ),
                                  //     )
                                  //   ],
                                  // )
                                ],
                            ),
                          ),
                              );
                            }),
                          )
                        ],
                      )
                    ],
                  )
                : Container(
                    child: Center(
                      child: Text("You don't have any products."),
                    ),
                  ),
            //this for suppliers
            (widget.favSuppliers != null && widget.favSuppliers.length > 0)
                ? ListView(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          // CheckboxListTile(
                          //   title: Text(
                          //     'Select All',
                          //     style: TextStyle(color: Colors.black),
                          //   ),
                          //   value: selectSuppliers,
                          //   activeColor: Colors.green,
                          //   checkColor: Colors.white,
                          //   onChanged: (bool value) {
                          //     setState(() {
                          //       this.selectSuppliers = value;
                          //       this.supplier1 = value;
                          //       this.supplier2 = value;
                          //       this.supplier3 = value;
                          //       this.supplier4 = value;
                          //     });
                          //   },
                          //   controlAffinity: ListTileControlAffinity.leading,
                          // ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(color: Colors.grey))),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                         Container(
                           child: ListView.builder(
                             itemCount: widget.favSuppliers.length,
                             physics: new NeverScrollableScrollPhysics(),
                             shrinkWrap: true,
                             itemBuilder: (BuildContext context,int sup){
                             return  Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.all(10),
                            height: 110,
                            width: 200,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: CheckboxListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      InkWell(
                                        child: Text(
                                          '${widget.favSuppliers[sup].supplierName}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onTap: () {},
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(children: <Widget>[
                                        Icon(
                                          Icons.verified_user,
                                          color: Colors.green,
                                          size: 20,
                                        ),
                                        Text(
                                          'APPROVED',
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14),
                                        )
                                      ]),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text('Country : India'),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text('Business Type : ${widget.favSuppliers[sup].detailDTO.businessType}'),
                                    ],
                                  ),
                                  Container(padding: EdgeInsets.all(10),
                                  child: IconButton(icon: Icon(Icons.message),color: Colors.green, onPressed: (){
                                    Navigator.of(context).push(new MaterialPageRoute(
                                    builder: (context) => new ContactSupplier()));

                                  }),)
                                  /* SizedBox(
                                    child: OutlineButton(
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0)),
                                      highlightColor: Colors.green[900],
                                      child: Text(
                                        'Contact Supplier',
                                        style: TextStyle(color: Colors.green),
                                      ),
                                      onPressed: () {},
                                      borderSide: BorderSide(
                                        color: Colors.green,
                                        style: BorderStyle.solid,
                                        width: 0.8,
                                      ),
                                    ),
                                  ) */
                                ],
                              ),
                              value: supplier1,
                              activeColor: Colors.green,
                              checkColor: Colors.white,
                              onChanged: (bool value) {
                                setState(() {
                                  this.supplier1 = value;
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          );
                           }),
                         )
                        ],
                      ),
                    ],
                  )
                : Container(
                    child: Center(
                      child: Text("You don't have any suppliers."),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
