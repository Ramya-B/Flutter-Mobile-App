import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tradeleaves/components/add_product/select_category_region.dart';
import 'package:tradeleaves/components/products/ProductDetails.dart';
import 'package:tradeleaves/models/index.dart';
import 'package:tradeleaves/podos/products/product.dart';
import 'package:tradeleaves/tl-services/catalog/CatalogServiceImpl.dart';
import 'package:tradeleaves/tl-services/crm/CrmServiceImpl.dart';
import '../../constants.dart';
import '../../service_locator.dart';

class UserProducts extends StatefulWidget {
  @override
  _UserProductsState createState() => _UserProductsState();
}

class _UserProductsState extends State<UserProducts> {
  List<Sort> sorts = [];
  CatalogServiceImpl get catalogService => locator<CatalogServiceImpl>();
  CrmServiceImpl get crmService => locator<CrmServiceImpl>();
  UserListedProducts userProducts;
  List<ProductDTO> userProductsList = [];
  ScrollController _controller;
  var counter = 1;
  var pageStart = 0;
  SupplierDTO supplierDTO;
  @override
  void initState() {
    getSupplierDetails();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    getUserProducts();
    super.initState();
  }
  getSupplierDetails() async{
    var data = await crmService.getCompanyDetails();
    Company com = Company.fromJson(data["company"]);
    supplierDTO = new SupplierDTO();
    supplierDTO.supplierId = com.details.partyId;
    supplierDTO.supplierName = com.details.groupName;
    // supplierDTO.businessType = null;
    // supplierDTO.companyType =null;
    // supplierDTO.industryType  =null;
    // supplierDTO.noOfEmployees = null;
    // supplierDTO.rating = null;
    // supplierDTO.revenueCurrency = null;
    // supplierDTO.searchable = null;
    supplierDTO.supplierCity= com.address.city;
    supplierDTO.supplierCountry= com.address.country;
    // supplierDTO.supplierRevenue=com.details.;
    supplierDTO.supplierStatus= com.accountStatus.statusId;
    // supplierDTO.supplierSubscriptionId=null;
    // supplierDTO.supplierSubscriptionType=null;
    // supplierDTO.tlPreferredRating=null;
    // supplierDTO.userPreferredRating=null;
    // supplierDTO.yearsInBusiness= com.details.;

  }

  getUserProducts() async {
    print("getUserProducts");
    ProductCriteria productCriteria = new ProductCriteria();
    Pagination pagination = new Pagination();
    pagination.start = this.pageStart;
    pagination.limit= 10;
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
      appBar: AppBar(
        title: Text('My products'),
        backgroundColor: Constants.toolbarColor,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.of(context)
                .push(new MaterialPageRoute(builder: (context) => SelectCategoryRegion()));},
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      body: (this.userProducts != null)
          ? Container(
              // height: 400,
              constraints: BoxConstraints(minHeight: 100, maxHeight: 800),
              child: GridView.builder(
                  controller: _controller,
                  itemCount: this.userProductsList.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return SingleUserProduct(
                      productDTO: this.userProductsList[index],
                      supplierDTO: this.supplierDTO,
                    );
                  }))
          : Center(
            child: CircularProgressIndicator(),
          ),
    );
  }
}

class SingleUserProduct extends StatefulWidget {
  final productDTO;
  final supplierDTO;

  SingleUserProduct({
    this.productDTO,
    this.supplierDTO
  });
  @override
  _SingleUserProductState createState() => _SingleUserProductState();
}

class _SingleUserProductState extends State<SingleUserProduct> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: (){
          Navigator.of(context)
                .push(new MaterialPageRoute(builder: (context) => ProductDetails(productDTO:widget.productDTO ,supplierDTO: widget.supplierDTO,)));
        },
        child: Container(
          padding: EdgeInsets.all(4.0),
          child: Column(
            children: <Widget>[
              (widget.productDTO.primaryImageUrl != null)
                  ? Image.network(
                      (widget.productDTO.primaryImageUrl
                              .toString()
                              .contains('http'))
                          ? ('${widget.productDTO.primaryImageUrl}')
                          : ('${Constants.envUrl}${Constants.mongoImageUrl}/${widget.productDTO.primaryImageUrl}'),
                      width: 150,
                      height: 150,
                    )
                  : Container(
                      width: 150,
                      height: 150,
                    ),
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
