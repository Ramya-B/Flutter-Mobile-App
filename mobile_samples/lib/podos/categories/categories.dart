class CategoryDetailsLobDTO {
  List<String> lobId;
  bool systemRootCategoryFlag;
  String categoryId;
  bool restrictFetchImage;

  CategoryDetailsLobDTO(
      {this.lobId, this.systemRootCategoryFlag, this.categoryId,this.restrictFetchImage});

  factory CategoryDetailsLobDTO.fromJson(Map<String, dynamic> json) {
    return CategoryDetailsLobDTO(
        lobId: json['lobId'],
        systemRootCategoryFlag: json['systemRootCategoryFlag'],
        restrictFetchImage: json['restrictFetchImage'],
        categoryId: json['categoryId']);
  }
  Map<String, dynamic> toJson() {
    return {
      'lobId': lobId,
      'systemRootCategoryFlag': systemRootCategoryFlag,
      'categoryId': categoryId,
      'restrictFetchImage': restrictFetchImage
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
  List<CategoryAttributeDTO> categoryAttributeDTO;

  CategoryAndAttributesDTO({this.categoryDTO, this.categoryAttributeDTO});

  factory CategoryAndAttributesDTO.fromJson(Map<String, dynamic> json) {
    return CategoryAndAttributesDTO(
        categoryDTO: CategoryDTO.fromJson(json['categoryDTO']),
        categoryAttributeDTO: json['categoryAttributeDTO']);
  }
  Map<String, dynamic> toJson() {
    return {
      'categoryDTO': categoryDTO,
      'categoryAttributeDTO': categoryAttributeDTO
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
        categoryAttribute: json['categoryAttribute'],
        categoryLobDtoList: json['categoryLobDtoList'],
        categoryImage: json['categoryLobDtoList']);
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
