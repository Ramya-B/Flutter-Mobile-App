import 'package:flutter/material.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/CustomBottomNavigationBar.dart';
import 'package:tradeleaves/components/contact_supplier/contact_supplier.dart';
import 'package:tradeleaves/models/index.dart';
import 'package:tradeleaves/tl-services/catalog/CatalogServiceImpl.dart';

import '../../constants.dart';
import '../../service_locator.dart';

class ProductDetails extends StatefulWidget {
  final ProductDTO productDTO;
  final SupplierDTO supplierDTO;
 

  ProductDetails({
    this.productDTO,
    this.supplierDTO,
  });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
   CatalogServiceImpl get catalogService => locator<CatalogServiceImpl>();
 var prodAttrs =  ["text",'City Type','radio','checkbox'];
  @override
  void initState() {
    super.initState();
  }
   setValues() async{
      // for (var attr in widget.productDTO.productAttributeDetailDTO) {
      //     switch (attr.displayType) {
      //       case "City Type":
              
      //         break;
      //       default:
      //     }
        
      // }
   }
   handleFav() async{
    setState(() {
      widget.productDTO.isFavorited = !widget.productDTO.isFavorited;
    });
    FavouriteProductsDTO favouriteProductsDTO = new FavouriteProductsDTO();
    favouriteProductsDTO.productId = widget.productDTO.productId;
    favouriteProductsDTO.productImageUrl = widget.productDTO.primaryImageUrl;
    favouriteProductsDTO.suppplierName = widget.supplierDTO.supplierName;
    favouriteProductsDTO.partyId = widget.supplierDTO.supplierId;
    catalogService.handleFavorites(favouriteProductsDTO);
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
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(5),
                      child: new IconButton(
                          icon: Icon(
                            widget.productDTO.isFavorited? Icons.favorite : Icons.favorite_border,
                            color: Colors.green,
                          ),
                          onPressed: ()  {
                            handleFav();
                          }),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(5),
                      child: new IconButton(
                          icon: Icon(
                             Icons.message,
                            color: Colors.green,
                          ),
                          onPressed: ()  {
                            Navigator.of(context).push(new MaterialPageRoute(
                              builder: (context) => new ContactSupplier(
                                      
                                    )));
                          }),
                    ),
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
                  widget.supplierDTO.rating != null && widget.supplierDTO.rating != 0
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
                  child: Text(widget.productDTO.productName,style: TextStyle(fontSize: 18,
                  ),),
                ),
                Container(
                  child: ListView.builder(
                    itemCount: widget.productDTO.productAttributeDetailDTO.length,
                    physics: new NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context,int index){
                       ProductAttributeDetailDTO  prodAttr =    widget.productDTO.productAttributeDetailDTO[index];
                      return (prodAttr.attributeName!=null && prodAttr.value !=null) ? Row(
                        children: <Widget>[
                          Expanded(child:  Container(
                            padding: EdgeInsets.all(5.0),
                            alignment: Alignment.topCenter,
                            child:  Text(
                        '${prodAttr.attributeName}:',
                        style: TextStyle(color: Colors.blueGrey)),
                          )
                      ),
                      Expanded(child:Container(
                         padding: EdgeInsets.all(5.0),
                        alignment: Alignment.topLeft,
                        child:   Text(
                          '${prodAttr.value}',overflow: TextOverflow.ellipsis,maxLines: 2,)),
                      )
                     
                        ],

                      ):Container();
                  }),
                  /* ListView.builder(
                    itemCount: 4,
                    physics:new  NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context,int item){
                    return Text('hii');
                  }), */
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
