

class CategoryDetailsLobDTO {
  List<String> lobId;
  bool systemRootCategoryFlag;
  String categoryId;
  bool restrictFetchImage;
  bool active;

  CategoryDetailsLobDTO(
      {this.lobId, this.systemRootCategoryFlag, this.categoryId,this.restrictFetchImage,this.active});

  factory CategoryDetailsLobDTO.fromJson(Map<String, dynamic> json) {
    return CategoryDetailsLobDTO(
        lobId: json['lobId'],
        systemRootCategoryFlag: json['systemRootCategoryFlag'],
        restrictFetchImage: json['restrictFetchImage'],
        categoryId: json['categoryId'],
        active: json['active']
        );
         
  }
  Map<String, dynamic> toJson() {
    return {
      'lobId': lobId,
      'systemRootCategoryFlag': systemRootCategoryFlag,
      'categoryId': categoryId,
      'active': active,
      'active': active
    };
  }
}

class CategoryDetailsDTO {
  CategoryAndAttributesDTO categoryAndAttributesDTO;
  List<CategoryAndAttributesDTO> subCategoryAndAttributesDTO;

  CategoryDetailsDTO(
      {this.categoryAndAttributesDTO, this.subCategoryAndAttributesDTO});

  factory CategoryDetailsDTO.fromJson(Map<String, dynamic> json) {
    var subAttr = (json['subCategoryAndAttributesDTO'] != null)
        ? json['subCategoryAndAttributesDTO'] as List
        : [];
    List<CategoryAndAttributesDTO> _subCategoryAndAttributesDTO =
        subAttr.map((res) => CategoryAndAttributesDTO.fromJson(res)).toList();
    return CategoryDetailsDTO(
      categoryAndAttributesDTO:
          CategoryAndAttributesDTO.fromJson(json['categoryAndAttributesDTO']),
      subCategoryAndAttributesDTO: _subCategoryAndAttributesDTO,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'categoryAndAttributesDTO': categoryAndAttributesDTO,
      'subCategoryAndAttributesDTO': subCategoryAndAttributesDTO
    };
  }
}

class CategoryAndAttributesDTO {
  CategoryDTO categoryDTO;
  List<CategoryAttributeDTO> categoryAttribute;

  CategoryAndAttributesDTO({this.categoryDTO, this.categoryAttribute});

  factory CategoryAndAttributesDTO.fromJson(Map<String, dynamic> json) { 
    var catAttr = json['categoryAttribute']!=null ? json['categoryAttribute'] as List: [];
    List<CategoryAttributeDTO> _categoryAttributeDTO =  catAttr.map((data)=>CategoryAttributeDTO.fromJson(data)).toList();
    return CategoryAndAttributesDTO(
        categoryDTO: CategoryDTO.fromJson(json['categoryDTO']),
        categoryAttribute: _categoryAttributeDTO
        );
  }
  Map<String, dynamic> toJson() {
    return {
      'categoryDTO': categoryDTO,
      'categoryAttribute': categoryAttribute
    };
  }
}

class CategoryDTO {
  int id;
  String name;
  bool active;
  String start;
  String end;
  String seo;
  String description;
  bool hasSubCategories;
  bool hasActiveSubCategories;
  bool hasParentCategories;
  bool hasCategoryAttributes;
  int priority;
  List<CategoryAttributeDTO> categoryAttribute;
  List<CategoryLobDTO> categoryLobDtoList;
  String categoryImage;

  CategoryDTO(
      {this.id,
      this.name,
      this.active,
      this.start,
      this.end,
      this.seo,
      this.description,
      this.hasSubCategories,
      this.hasActiveSubCategories,
      this.hasParentCategories,
      this.hasCategoryAttributes,
      this.priority,
      this.categoryAttribute,
      this.categoryLobDtoList,
      this.categoryImage});

  factory CategoryDTO.fromJson(Map<String, dynamic> json) {
        var catAttr =  json['categoryAttribute'] != null ? json['categoryAttribute'] as List :[];
       List<CategoryAttributeDTO> _categoryAttribute =  catAttr.map((data)=>CategoryAttributeDTO.fromJson(data)).toList();
         var catLob =   json['categoryLobDtoList'] != null ? json['categoryLobDtoList'] as List:[];
          List<CategoryLobDTO> _categoryLobDtoList  =  catLob.map((data)=>CategoryLobDTO.fromJson(data)).toList();
    return CategoryDTO(
        id: json['id'],
        name: json['name'],
        active: json['active'],
        start: json['start'],
        end: json['end'],
        seo: json['seo'],
        description: json['description'],
        hasSubCategories: json['hasSubCategories'],
        hasActiveSubCategories: json['hasActiveSubCategories'],
        hasParentCategories: json['hasParentCategories'],
        hasCategoryAttributes: json['hasCategoryAttributes'],
        priority: json['priority'],
        categoryAttribute: _categoryAttribute,
        categoryLobDtoList: _categoryLobDtoList,
        categoryImage: json['categoryImage']);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'active': active,
      'start': start,
      'end': end,
      'seo': seo,
      'description': description,
      'hasSubCategories': hasSubCategories,
      'hasActiveSubCategories': hasActiveSubCategories,
      'hasParentCategories': hasParentCategories,
      'hasCategoryAttributes': hasCategoryAttributes,
      'priority': priority,
      'categoryAttribute': categoryAttribute,
      'categoryLobDtoList': categoryLobDtoList
    };
  }
}

class CategoryLobDTO {
  String categoryLobId;
  String categoryId;
  String lobId;
  DateTime effectiveStartDate;
  String isActive;

  CategoryLobDTO(
      {this.categoryLobId,
      this.categoryId,
      this.lobId,
      this.effectiveStartDate,
      this.isActive});

  factory CategoryLobDTO.fromJson(Map<String, dynamic> json) {
    return CategoryLobDTO(
        categoryLobId: json['categoryLobId'],
        categoryId: json['categoryId'],
        lobId: json['lobId'],
        effectiveStartDate: json['effectiveStartDate'],
        isActive: json['isActive']);
  }
  Map<String, dynamic> toJson() {
    return {
      'categoryLobId': categoryLobId,
      'categoryId': categoryId,
      'lobId': lobId,
      'effectiveStartDate': effectiveStartDate,
      'isActive': isActive
    };
  }
}

class CategoryAttributeDTO {
  int attributeId;
  String attributeName;
  String attributeValue;
  int categoryId;
  bool isRequired;
  String archived;

  CategoryAttributeDTO(
      {this.attributeId,
      this.attributeName,
      this.attributeValue,
      this.categoryId,
      this.isRequired,
      this.archived});

  factory CategoryAttributeDTO.fromJson(Map<String, dynamic> json) {
    return CategoryAttributeDTO(
        attributeId: json['attributeId'],
        attributeName: json['attributeName'],
        attributeValue: json['attributeValue'],
        categoryId: json['categoryId'],
        isRequired: json['isRequired'],
        archived: json['archived']);
  }
  Map<String, dynamic> toJson() {
    return {
      'attributeId': attributeId,
      'attributeName': attributeName,
      'attributeValue': attributeValue,
      'categoryId': categoryId,
      'isRequired': isRequired,
      'archived': archived,
    };
  }
}

// class SavedCategories{
//   List<CategoryDTO> savedCategories;
//    SavedCategories({this.savedCategories,});
//   factory SavedCategories.fromJson(Map<String, dynamic> json) {
//      var saveCats = json['savedCategories'] != null ? json['savedCategories'] as List : [];
//    List<CategoryDTO> _savedCategories = saveCats.map((data)=>CategoryDTO.fromJson(data));
//     return SavedCategories(
//         savedCategories: _savedCategories
//     );
//   }
//   Map<String, dynamic> toJson() {
//     return {
//       'savedCategories': savedCategories,
//     };
//   }
// }

