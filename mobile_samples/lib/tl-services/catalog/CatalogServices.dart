import 'package:tradeleaves/podos/categories/categories.dart';
import 'package:tradeleaves/podos/products/product.dart';

abstract class CatalogServices {
  Future search(ProductSearchCriteriaDTO productSearchCriteriaDTO);
  Future<List> getCategories(CategoryDetailsLobDTO categoryDetailsLobDTO);
  Future<List> getCategoryDetailsByLoB( CategoryDetailsLobDTO categoryDetailsLobDTO);
     
}
