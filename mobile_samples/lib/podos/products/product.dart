class ProductDTO {

  String productId;
  String productUniqueId;
  String productName;
  String primaryImageUrl;
  String supplierId;
  String categoryId;

  ProductDTO({this.productId, this.productUniqueId, this.productName,  this.primaryImageUrl,  this.supplierId,  this.categoryId });

  factory ProductDTO.fromJson(Map<String, dynamic> json) {
    return ProductDTO(
      productId: json['productId'] as String,
      productUniqueId: json['productUniqueId'] as String,
      productName: json['productName'] as String,
      primaryImageUrl: json['primaryImageUrl'] as String,
      supplierId: json['supplierId'] as String,
      categoryId: json['categoryId'] as String
    );
  }

}