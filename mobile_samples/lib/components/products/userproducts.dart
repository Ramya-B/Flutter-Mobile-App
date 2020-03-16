import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tradeleaves/podos/products/product.dart';
import 'package:tradeleaves/tl-services/catalog/CatalogServiceImpl.dart';
import '../../constants.dart';
import '../../service_locator.dart';
import 'ProductsList.dart';

class UserProducts extends StatefulWidget {
  @override
  _UserProductsState createState() => _UserProductsState();
}

class _UserProductsState extends State<UserProducts> {
   List<Sort> sorts = [];
  CatalogServiceImpl get catalogService => locator<CatalogServiceImpl>();
  UserListedProducts userProducts;
  List<ProductDTO> userProductsList = [];
  ScrollController _controller;
  var counter = 1;
  var pageStart = 0;
  @override
  void initState() {
        _controller = ScrollController();
    _controller.addListener(_scrollListener);
    getUserProducts();
    super.initState();
  }
  
    getUserProducts() async {
    print("getUserProducts");
    ProductCriteria productCriteria = new ProductCriteria();
    Pagination pagination = new Pagination(start: this.pageStart, limit: 10);
    Sort sort = new Sort();
    sort.direction = 'desc';
    sort.sort = 'createdTime';
    this.sorts.add(sort);
    productCriteria.pagination = pagination;
    productCriteria.sort = null;
    productCriteria.siteCriterias = null;
    print("getUserProducts productCriteria");
    print(productCriteria.toJson());
    var getUserProducts = await catalogService.getUserProducts(productCriteria);
    print("getUser response...!");
    print(UserListedProducts.fromJson(getUserProducts));
    setState(() {
      this.userProducts = UserListedProducts.fromJson(getUserProducts);
      this.userProductsList.addAll(this.userProducts.productSearchDTO);
    });
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        if (this.userProductsList.length > this.counter) {
          this.pageStart++;
          print("scrolling is over.so fetching --${this.pageStart}");
         getUserProducts();
        }
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        print("scroll reached the top...!");
      });
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My products'),backgroundColor: Colors.green,),
      body: (this.userProducts != null ) ? Container(
        // height: 400,
       constraints: BoxConstraints(minHeight: 100, maxHeight: 800),
         child: GridView.builder(
        controller: _controller,
        itemCount: this.userProductsList.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return SingleUserProduct(
            productDTO: this.userProductsList[index],
          );
        })
       
      ):Container(),
    );
  }
}

class SingleUserProduct extends StatefulWidget {
   final productDTO;

  SingleUserProduct({
    this.productDTO,
  });
  @override
  _SingleUserProductState createState() => _SingleUserProductState();
}

class _SingleUserProductState extends State<SingleUserProduct> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Container(
          padding: EdgeInsets.all(4.0),
          child: Column(
            children: <Widget>[
              (widget.productDTO.primaryImageUrl != null )? Image.network(
                (widget.productDTO.primaryImageUrl.toString().contains('http') )? ('${widget.productDTO.primaryImageUrl}'):('${Constants.envUrl}${Constants.mongoImageUrl}/${widget.productDTO.primaryImageUrl}'),
                width: 150,
                height: 150,
              ):Container( width: 150,
                height: 150,),
              Expanded(
                child: Container(
                    padding: EdgeInsets.all(2.0),
                    child: Text(
                      widget.productDTO.productName,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

