import 'package:tradeleaves/models/index.dart';
import 'package:tradeleaves/podos/categories/categories.dart';
import 'package:tradeleaves/podos/products/product.dart';

abstract class CatalogServices {
  Future search(ProductSearchCriteriaDTO productSearchCriteriaDTO);
  Future<List> getCategories(CategoryDetailsLobDTO categoryDetailsLobDTO);
  Future<List> getCategoryDetailsByLoB( CategoryDetailsLobDTO categoryDetailsLobDTO);
  Future<List> getPromotedProducts(PromoProductCriteria promoProductCriteria);  
  Future getProductsByCategoryId(ProductInfo productInfo);   
  Future getUserProducts(ProductCriteria productCriteria);   
  Future getSavedCategories(String companyId); 
  Future getLeafCategories(CategoryDetailsLobDTO categoryDetailsLobDTO);
  Future getProductAttributesByLob(ListCatProdAttrLoBDTO listCatProdAttrLoBDTO);   
  Future saveProduct(ProductDTO productDTO);
  Future getProductById(String productId);
  Future getFavourites(ProductSearchCriteriaDTO productSearchCriteriaDTO);
  Future handleFavorites(FavouriteProductsDTO favouriteProductsDTO);
  Future getFavoriteSuppliers();
}

