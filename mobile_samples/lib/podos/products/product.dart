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

class ProductSearchCriteriaDTO {
  Pagination pagination;
  ProductPrimarySearchCondition productPrimarySearchCondition;
  ProductFilters productFilters;
  var sortBy;
  var lobSelection;
  var countryId;
  var channel;
  var region;
  SiteCriteria siteCriteria;
  ProductSearchCriteriaDTO({
    this.pagination,
    this.productPrimarySearchCondition,
    this.productFilters,
    this.sortBy,
    this.lobSelection,
    this.countryId,
    this.channel,
    this.region,
    this.siteCriteria,
  });

  factory ProductSearchCriteriaDTO.fromJson(Map<String, dynamic> json) {
    return ProductSearchCriteriaDTO(
      pagination: Pagination.fromJson(json['pagination']),
      productPrimarySearchCondition: ProductPrimarySearchCondition.fromJson(json['productPrimarySearchCondition']),
      productFilters: ProductFilters.fromJson(json['productFilters']),
      sortBy: json['sortBy'],
      lobSelection: json['lobSelection'],
      countryId: json['countryId'],
      channel: json['channel'],
      region: json['region'],
      siteCriteria:SiteCriteria.fromJson( json['siteCriteria']),
    );
  }
  Map toJson() {
    Map pagination = this.pagination != null ? this.pagination.toJson() : null;
    Map productPrimarySearchCondition = this.productPrimarySearchCondition != null ? this.productPrimarySearchCondition.toJson() : null;
    Map siteCriteria = this.siteCriteria != null ? this.siteCriteria.toJson() : null;  
    return {
      'pagination': pagination,
      'productPrimarySearchCondition': productPrimarySearchCondition,
      'productFilters': productFilters,
      'sortBy': sortBy,
      'lobSelection': lobSelection,
      'countryId': countryId,
      'channel': channel,
      'region': region,
      'siteCriteria': siteCriteria,
    };
  }
}

class SiteCriteria {
  var channel;
  var site;
  var status;
  SiteCriteria({this.channel, this.site, this.status});
  factory SiteCriteria.fromJson(Map<String, dynamic> json) {
    return SiteCriteria(
      channel: json['channel'] as String,
      site: json['site'] as String,
      status: json['status'],
    );
  }
  Map toJson() {
    return {"channel": channel, "site": site, "status": status};
  }
}


class ProductFilters {
  var keyValueFacets = [];
  ProductFilters({this.keyValueFacets});
  factory ProductFilters.fromJson(Map<String, dynamic> json) {
    return ProductFilters(
      keyValueFacets: json['keyValueFacets'],
    );
  }
  Map toJson() {
    return {"keyValueFacets": keyValueFacets};
  }
}


class ProductPrimarySearchCondition {
  var condition;
  ProductPrimarySearchCondition({this.condition});
  factory ProductPrimarySearchCondition.fromJson(Map<String, dynamic> json) {
    return ProductPrimarySearchCondition(
      condition: json['condition'] as String,
    );
  }
  Map toJson() {
    return {"condition": condition};
  }
}

class Pagination {
  int start;
  int limit;
  Pagination({this.start, this.limit});
  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      start: json['channel'] as int,
      limit: json['site'] as int,
    );
  }

  Map toJson() {
    return {"start": start, "limit": limit};
  }
}