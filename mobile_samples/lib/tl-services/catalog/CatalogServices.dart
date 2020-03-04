import 'package:tradeleaves/podos/products/product.dart';

abstract class CatalogServices{
  Future search(ProductSearchCriteriaDTO productSearchCriteriaDTO);
  Future<List> getCategories();

}