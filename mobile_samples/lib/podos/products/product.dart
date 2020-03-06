

class ProductDTO {
  bool active;
  bool adminFlag;
  bool allowTrading;
  String catalogs;
  String categoryDTO;
  List<String> categoryIds;
  String displayTemplate;
  List<HsCodes> hsCodes = [];
  String lobcountryDTO;
  List priceList;
  String primaryImageUrl;
  List<ProductAttributeDetailDTO> productAttributeDetailDTO = [];
  String productId;
  List<ProductLobCountryStatusDTO> productLobCountryStatusDTO = [];
  String productName;
  List<ProductOptionDTO> productOptionDTO = [];
  String productUniqueId;
  String promotionPlansDTO;
  String rating;
  String serviceProviderId;
  String supplierId;
  String tlPreferredRating;
  String type;
  String userPreferredRating;

  ProductDTO({
    this.catalogs,
    this.categoryDTO,
    this.categoryIds,
    this.displayTemplate,
    this.hsCodes,
    this.lobcountryDTO,
    this.priceList,
    this.primaryImageUrl,
    this.productAttributeDetailDTO,
    this.productId,
    this.productLobCountryStatusDTO,
    this.productName,
    this.productOptionDTO,
    this.productUniqueId,
    this.promotionPlansDTO,
    this.rating,
    this.serviceProviderId,
    this.supplierId,
    this.tlPreferredRating,
    this.type,
    this.userPreferredRating,
  });

  factory ProductDTO.fromJson(Map<String, dynamic> json) {
    var tagObjsJson =(json['hsCodes'] != null) ? json['hsCodes'] as List:[];
    List<HsCodes> _hsCodes =
        tagObjsJson.map((tagJson) => HsCodes.fromJson(tagJson)).toList();
    var prodJson = (json['productAttributeDetailDTO'] != null) ? json['productAttributeDetailDTO'] as List:[];
    List<ProductAttributeDetailDTO> _productAttributeDetailDTO = prodJson
        .map((tagJson) => ProductAttributeDetailDTO.fromJson(tagJson))
        .toList();

    var lobCountryStatusDTO =  (json['productLobCountryStatusDTO'] != null) ? json['productLobCountryStatusDTO'] as List : [];
    List<ProductLobCountryStatusDTO> _productLobCountryStatusDTO =
        lobCountryStatusDTO
            .map((tagJson) => ProductLobCountryStatusDTO.fromJson(tagJson))
            .toList();

    var productOptionDTODup = (json['productOptionDTO'] != null) ?json['productOptionDTO'] as List:[];
    List<ProductOptionDTO> _productOptionDTO = productOptionDTODup
        .map((tagJson) => ProductOptionDTO.fromJson(tagJson))
        .toList();

    var cat = (json['categoryIds'] != null)?json['categoryIds'] as List:[];
    List<String> _categoryIds =
        cat.map((tagJson) => tagJson.toString()).toList();

    return ProductDTO(
        catalogs: json['catalogs'],
        categoryDTO: json['categoryDTO'],
        categoryIds: _categoryIds,
        displayTemplate: json['displayTemplate'],
        hsCodes: _hsCodes,
        lobcountryDTO: json['lobcountryDTO'],
        priceList: json['priceList'] as List,
        primaryImageUrl: json['primaryImageUrl'],
        productAttributeDetailDTO: _productAttributeDetailDTO,
        productId: json['productId'],
        productLobCountryStatusDTO: _productLobCountryStatusDTO,
        productName: json['productName'],
        productOptionDTO: _productOptionDTO,
        productUniqueId: json['productUniqueId'],
        promotionPlansDTO: json['promotionPlansDTO'],
        rating: json['rating'],
        serviceProviderId: json['serviceProviderId'],
        supplierId: json['supplierId'],
        tlPreferredRating: json['tlPreferredRating'],
        type: json['type'],
        userPreferredRating: json['userPreferredRating']);
  }
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productUniqueId': productUniqueId,
      'productName': productName,
      'primaryImageUrl': primaryImageUrl,
      'supplierId': supplierId,
      'categoryIds': categoryIds,
    };
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
      productPrimarySearchCondition: ProductPrimarySearchCondition.fromJson(
          json['productPrimarySearchCondition']),
      productFilters: ProductFilters.fromJson(json['productFilters']),
      sortBy: json['sortBy'],
      lobSelection: json['lobSelection'],
      countryId: json['countryId'],
      channel: json['channel'],
      region: json['region'],
      siteCriteria: SiteCriteria.fromJson(json['siteCriteria']),
    );
  }
  Map toJson() {
    Map pagination = this.pagination != null ? this.pagination.toJson() : null;
    Map productPrimarySearchCondition =
        this.productPrimarySearchCondition != null
            ? this.productPrimarySearchCondition.toJson()
            : null;
    Map siteCriteria =
        this.siteCriteria != null ? this.siteCriteria.toJson() : null;
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
  var region;
  SiteCriteria({this.channel, this.site, this.status, this.region});
  factory SiteCriteria.fromJson(Map<String, dynamic> json) {
    return SiteCriteria(
      channel: json['channel'] as String,
      site: json['site'] as String,
      status: json['status'],
    );
  }
  Map toJson() {
    return {"channel": channel, "site": site, "status": status, "region": region};
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
      start: json['start'] as int,
      limit: json['limit'] as int,
    );
  }

  Map toJson() {
    return {"start": start, "limit": limit};
  }
}

class PromoProductCriteria {
   Pagination pagination;
   SiteCriteria siteCriteria;
   CategoryCriteria categoryCriteria;
   String promotionID;
   PromoProductCriteria({
    this.pagination,
    this.siteCriteria,
    this.promotionID,
    this.categoryCriteria
   });
     factory PromoProductCriteria.fromJson(Map<String, dynamic> json) {
    return PromoProductCriteria(
      pagination: Pagination.fromJson(json['pagination']),
       siteCriteria: SiteCriteria.fromJson(json['siteCriteria']),
        categoryCriteria: CategoryCriteria.fromJson(json['categoryCriteria']),
         promotionID: json['promotionID'] as String,

    );
  }
  Map toJson() {
    Map pagination = this.pagination != null ? this.pagination.toJson() : null;
    Map categoryCriteria =
        this.categoryCriteria != null
            ? this.categoryCriteria.toJson()
            : null;
    Map siteCriteria =
        this.siteCriteria != null ? this.siteCriteria.toJson() : null;
    return {"pagination": pagination, "siteCriteria": siteCriteria, 
    "categoryCriteria": categoryCriteria, "promotionID": promotionID};
  }
}
class CategoryCriteria{
  List<String> categoryId;
  CategoryCriteria({
    this.categoryId
  });
  factory CategoryCriteria.fromJson(Map<String, dynamic> json) {
    return CategoryCriteria(
      categoryId: json['categoryId'] as List<String>
    );
  }
  Map toJson() {
    return {"categoryId": categoryId};
  }
}

class ProductAttributeDetailDTO {
  String valueId;
  String attributeName;
  String valueType;
  String value;
  String priority;
  String lobId;
  String lobName;
  String prodAttrId;
  bool facet;
  bool searchable;
  bool variant;

  ProductAttributeDetailDTO({
    this.valueId,
    this.attributeName,
    this.valueType,
    this.value,
    this.priority,
    this.lobId,
    this.lobName,
    this.prodAttrId,
    this.facet,
    this.searchable,
    this.variant,
  });
  factory ProductAttributeDetailDTO.fromJson(Map<String, dynamic> json) {
    return ProductAttributeDetailDTO(
      valueId: json['valueId'],
      attributeName: json['attributeName '],
      valueType: json['valueType '],
      value: json['value '],
      priority: json['priority'],
      lobId: json['lobId '],
      lobName: json['lobName'],
      prodAttrId: json['prodAttrId '],
      facet: json['facet'],
      searchable: json['searchable'],
      variant: json['variant'],
    );
  }

  Map toJson() {
    return {
      "valueId": valueId,
      'attributeName': attributeName,
      'valueType': valueType,
      'value': value,
      'priority': priority,
      'lobId': lobId,
      'lobName': lobName,
      'prodAttrId': prodAttrId,
      'facet': facet,
      'searchable': searchable,
      'variant': variant,
    };
  }
}

class ImageDTO {
  String id;
  String imageType;
  String imageUrl;
  String lobId;
  String name;
  ImageDTO({
    this.id,
    this.imageType,
    this.imageUrl,
    this.lobId,
    this.name,
  });
  factory ImageDTO.fromJson(Map<String, dynamic> json) {
    return ImageDTO(
      id: json['id'],
      imageType: json['imageType '],
      imageUrl: json['imageUrl '],
      lobId: json['lobId '],
      name: json['name'],
    );
  }

  Map toJson() {
    return {
      "id": id,
      'imageType': imageType,
      'imageUrl': imageUrl,
      'lobId': lobId,
      'name': name,
    };
  }
}

class ProductOptionDTO {
  List deliveryScheduleDTO;
  String displayTemplate;
  String end;
  List<ImageDTO> imageDTO;
  List<PriceList> priceList;
  String primaryImageUrl;
  String productAttributeDetailDTO;
  String productOptionId;
  String productOptionName;
  String start;
  String supplierSKUId;

  ProductOptionDTO({
     this.deliveryScheduleDTO,
    this.displayTemplate,
    this.end,
    this.imageDTO,
    this.priceList,
    this.primaryImageUrl,
    this.productAttributeDetailDTO,
    this.productOptionId,
    this.start,
    this.supplierSKUId,
    this.productOptionName,
  });
  factory ProductOptionDTO.fromJson(Map<String, dynamic> json) {
    var prices = json['priceList'] != null ? json['priceList'] as List : null;
    List<PriceList> _priceList = prices!= null ? prices.map((res) => PriceList.fromJson(res)).toList():null;
    var images = json['imageDTO'] as List;
    List<ImageDTO> _imageDTO = images.map((res) => ImageDTO.fromJson(res)).toList();
    return ProductOptionDTO(
      deliveryScheduleDTO: json['deliveryScheduleDTO'] as List,
      displayTemplate: json['displayTemplate'],
      end: json['end'],
      imageDTO: _imageDTO,
      priceList: _priceList,
      primaryImageUrl: json['primaryImageUrl'],
      productAttributeDetailDTO: json['productAttributeDetailDTO'],
      productOptionId: json['productOptionId'],
      productOptionName: json['productOptionName'],
      start: json['start'],
      supplierSKUId: json['supplierSKUId'],
    );
  }

  Map toJson() {
    return {
      'deliveryScheduleDTO': deliveryScheduleDTO,
      'displayTemplate': displayTemplate,
      'end': end,
      'imageDTO': imageDTO,
      'priceList': priceList,
      'primaryImageUrl': primaryImageUrl,
      'productAttributeDetailDTO': productAttributeDetailDTO,
      'productOptionId': productOptionId,
      'productOptionName': productOptionName,
      'start': start,
      'supplierSKUId': supplierSKUId,
    };
  }
}

class PriceList {
  String priceId ;
  double mfgPrice ;
  double sellablePrice ;
  String unitType ;
  String currency;
  String priceType ;
  List<ProductPriceSlabs> productPriceSlabs;
  String lobId ;

PriceList({
this.priceId ,
this.mfgPrice ,
this.sellablePrice ,
this.unitType ,
this.currency,
this.priceType ,
this.productPriceSlabs,
this.lobId ,
});
  factory PriceList.fromJson(Map<String, dynamic> json) {
    var productPriceSlab = json['productPriceSlabs'] !=null ? json['productPriceSlabs']  as List:[];
   List<ProductPriceSlabs> _productPriceSlabs = productPriceSlab.map((res) => ProductPriceSlabs.fromJson(res)).toList();
    return PriceList(
      priceId: json['priceId'],
      mfgPrice: json['mfgPrice'],
      sellablePrice: json['sellablePrice'],
      unitType: json['unitType'],
      currency: json['currency'],
      priceType: json['priceType'],
      productPriceSlabs: _productPriceSlabs,
      lobId: json['lobId'],
    );
  }

  Map toJson() {
    return {
      'priceId': priceId,
      'mfgPrice': mfgPrice,
      'sellablePrice': sellablePrice,
      'unitType': unitType,
      'currency': currency,
      'priceType': priceType,
      'productPriceSlabs': productPriceSlabs,
      'lobId': lobId,
    };
  }
}
  
class ProductPriceSlabs {
  int rangeStart ;
  String price;
  ProductPriceSlabs({this.price,this.rangeStart});
   factory ProductPriceSlabs.fromJson(Map<String, dynamic> json) {
    return ProductPriceSlabs(
      rangeStart: json['rangeStart'],
      price: json['price'],
    );
  }

  Map toJson() {
    return {
      'rangeStart': rangeStart,
      'price': price,
    };
  }

}

class HsCodes {
  String countryCode;
  String direction;
  String hscode;
  String lobId;
  HsCodes({
    this.countryCode,
    this.direction,
    this.hscode,
    this.lobId,
  });
  factory HsCodes.fromJson(Map<String, dynamic> json) {
    return HsCodes(
      countryCode: json['countryCode'],
      direction: json['direction '],
      hscode: json['hscode '],
      lobId: json['lobId '],
    );
  }

  Map toJson() {
    return {
      "countryCode": countryCode,
      'direction': direction,
      'hscode': hscode,
      'lobId': lobId,
    };
  }
}

class ProductLobCountryStatusDTO {
  String countryId;
  String lobId;
  String productId;
  String productLobCountryStatusId;
  String reason;
  String regionId;
  String statusId;

  ProductLobCountryStatusDTO({
    this.countryId,
    this.lobId,
    this.productId,
    this.productLobCountryStatusId,
    this.reason,
    this.regionId,
    this.statusId,
  });
  factory ProductLobCountryStatusDTO.fromJson(Map<String, dynamic> json) {
    return ProductLobCountryStatusDTO(
      countryId: json['countryId'],
      lobId: json['lobId '],
      productId: json['productId '],
      productLobCountryStatusId: json['productLobCountryStatusId '],
      reason: json['reason'],
      regionId: json['regionId'],
      statusId: json['statusId'],
    );
  }

  Map toJson() {
    return {
      "countryId": countryId,
      'lobId': lobId,
      'productId': productId,
      'productLobCountryStatusId': productLobCountryStatusId,
      'reason': reason,
      'regionId': regionId,
      'statusId': statusId,
    };
  }
}

class ProductInfo {
  String categoryId;
  bool isService;
  Filters filters;
  String countryId;
  String channel;
  String region;
  String lobSelection;
  String location;
  ProductInfo({this.categoryId,this.isService,this.filters,this.countryId,this.channel,this.region,this.lobSelection,this.location});
   factory ProductInfo.fromJson(Map<String, dynamic> json) {
    return ProductInfo(
      categoryId: json['categoryId'],
      isService: json['isService'],
      filters: Filters.fromJson(json['filters ']),
      countryId: json['countryId'],
      channel: json['channel'],
      region: json['region'],
      lobSelection: json['lobSelection'],
      location: json['location'],
    );
  }

  Map toJson() {
    return {
      "categoryId": categoryId,
      'isService': isService,
      'filters': filters,
      'countryId': countryId,
      'channel': channel,
      'region': region,
      'lobSelection': lobSelection,
      'location': location
    };
  }

}


class Filters{
  Pagination pagination;
  List<TlCriteriaWeights> tlcriteriaWeights;
  List<TlCriteriaWeights> suppliertlcriteriaWeights;
  CategoryCriteria categoryCriteria;
  String sortBy;
  Filters({this.pagination,this.tlcriteriaWeights,this.suppliertlcriteriaWeights,this.categoryCriteria,this.sortBy});
   factory Filters.fromJson(Map<String, dynamic> json) {
     var tlcriteria = json['tlcriteriaWeights'] != null ? json['tlcriteriaWeights']: [];
     List<TlCriteriaWeights>  _tlcriteriaWeights = tlcriteria.map((data)=>TlCriteriaWeights.fromJson(data)).toList();
      var tlSupplireCriteria = json['suppliertlcriteriaWeights'] != null ? json['suppliertlcriteriaWeights']: [];
     List<TlCriteriaWeights>  _suppliertlcriteriaWeights = tlSupplireCriteria.map((data)=>TlCriteriaWeights.fromJson(data)).toList();
    return Filters(
      pagination: Pagination.fromJson(json['pagination']),
      tlcriteriaWeights: _tlcriteriaWeights,
      suppliertlcriteriaWeights: _suppliertlcriteriaWeights,
      categoryCriteria: CategoryCriteria.fromJson(json['categoryCriteria']),
      sortBy: json['sortBy'],
    );
  }

  Map toJson() {
    return {
      "pagination": pagination,
      'tlcriteriaWeights': tlcriteriaWeights,
      'suppliertlcriteriaWeights': suppliertlcriteriaWeights,
      'categoryCriteria': categoryCriteria,
      'sortBy': sortBy,
    };
  }

}

class TlCriteriaWeights{
   String criteriaId;
   String criteriaUniqueName;
   String criteriaName;
   String weightPercentage;
   String functionName;
   String functionPercentage;
   TlCriteriaWeights({this.criteriaId,this.criteriaName,this.criteriaUniqueName,this.functionName,this.functionPercentage,this.weightPercentage});
    factory TlCriteriaWeights.fromJson(Map<String, dynamic> json) {
    return TlCriteriaWeights(
      criteriaId: json['criteriaId'],
      criteriaName: json['criteriaName '],
      criteriaUniqueName: json['criteriaUniqueName'],
      functionName: json['functionName'],
      functionPercentage: json['functionPercentage'],
      weightPercentage: json['weightPercentage'],
    );
  }

  Map toJson() {
    return {
      "criteriaId": criteriaId,
      'criteriaName': criteriaName,
      'criteriaUniqueName': criteriaUniqueName,
      'functionName': functionName,
      'functionPercentage': functionPercentage,
      'weightPercentage': weightPercentage,
    };
  }

}

