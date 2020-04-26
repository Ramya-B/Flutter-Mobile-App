import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tradeleaves/models/index.dart';
import 'package:tradeleaves/podos/products/product.dart';
import 'package:tradeleaves/tl-services/catalog/CatalogServiceImpl.dart';

import '../../service_locator.dart';
import 'favourite_screen.dart';

class Favourite extends StatefulWidget {
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  CatalogServiceImpl get catalogService => locator<CatalogServiceImpl>();
   UserFavorites favouriteList;
   List<FavouriteSuppliersDto> favSuppliers;

   getFavRecords() async {
    ProductSearchCriteriaDTO productSearchCriteriaDTO =
        ProductSearchCriteriaDTO();
    productSearchCriteriaDTO.criteriaWeights = [];
    productSearchCriteriaDTO.tlcriteriaWeights = [];
    productSearchCriteriaDTO.suppliercriteriaWeights = [];
    productSearchCriteriaDTO.suppliertlcriteriaWeights = [];
    var favResp = await catalogService.getFavourites(productSearchCriteriaDTO);
    print("favourites are ...!");
    print(favResp);
  setState(() {
     favouriteList =  UserFavorites.fromJson(favResp);
  });  
  }
  
  getFavSuppliers() async{
     var sup = await catalogService.getFavoriteSuppliers();
  setState(() {
    favSuppliers = List<FavouriteSuppliersDto>.from(sup["favouriteSuppliersDto"].map((data)=>FavouriteSuppliersDto.fromJson(data))).toList();
    
  });    

  }

  @override
  void initState() {
    favouriteList = null;
    favSuppliers = [];
    getFavRecords();
    getFavSuppliers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
             favouriteList!=null && favouriteList.favouriteProductsListDTO.length > 0 ||
             favSuppliers!=null && favSuppliers.length > 0 ? Container(
               child: FavouritePage(favProds: favouriteList.favouriteProductsListDTO,
               favSuppliers: favSuppliers,),
             ):Container();
           
  }
}
