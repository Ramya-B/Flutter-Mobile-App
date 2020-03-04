import 'package:tradeleaves/podos/categories/categories.dart';
import 'package:tradeleaves/podos/products/product.dart';

abstract class CatalogServices {
  Future<List> search(ProductSearchCriteriaDTO productSearchCriteriaDTO);
  Future<List> getCategories();
  Future<List> getCategoryDetailsByLoB(
      CategoryDetailsLobDTO categoryDetailsLobDTO);
}
