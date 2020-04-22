// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productAttributeDetailDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductAttributeDetailDTO _$ProductAttributeDetailDTOFromJson(
    Map<String, dynamic> json) {
  return ProductAttributeDetailDTO()
    ..attributeName = json['attributeName'] as String
    ..valueType = json['valueType'] as String
    ..required = json['required'] as bool
    ..displayType = json['displayType'] as String
    ..categoryProductAttributeId = json['categoryProductAttributeId'] as num
    ..productAttributeId = json['productAttributeId'] as String
    ..facet = json['facet'] as bool
    ..searchable = json['searchable'] as bool
    ..variant = json['variant'] as bool
    ..sortable = json['sortable'] as bool
    ..fieldId = json['fieldId'] as String
    ..value = json['value'] as String
    ..lobId = json['lobId'] as String
    ..prodAttrId = json['prodAttrId'] as String
    ..startTime = json['startTime'] as String
    ..endTime = json['endTime'] as String
    ..selectedPeriod = json['selectedPeriod'] as String
    ..price = json['price'] == null
        ? null
        : Price.fromJson(json['price'] as Map<String, dynamic>)
    ..unitType = json['unitType'] == null
        ? null
        : UnitType.fromJson(json['unitType'] as Map<String, dynamic>)
    ..perUnitWeight = json['perUnitWeight'] as String
    ..minOrderQty = json['minOrderQty'] as String
    ..valuesList = json['valuesList'] as List
    ..currency = json['currency'] as String
    ..catProdAttrValue = json['catProdAttrValue'] == null
        ? null
        : CatProdAttrValues.fromJson(
            json['catProdAttrValue'] as Map<String, dynamic>)
    ..country = json['country'] == null
        ? null
        : Country.fromJson(json['country'] as Map<String, dynamic>)
    ..uom = json['uom'] == null
        ? null
        : UomDTO.fromJson(json['uom'] as Map<String, dynamic>)
    ..incoterm = json['incoterm'] == null
        ? null
        : IncotermDto.fromJson(json['incoterm'] as Map<String, dynamic>)
    ..attributeId = json['attributeId'] as String
    ..selectedItem = json['selectedItem'] as String;
}

Map<String, dynamic> _$ProductAttributeDetailDTOToJson(
        ProductAttributeDetailDTO instance) =>
    <String, dynamic>{
      'attributeName': instance.attributeName,
      'valueType': instance.valueType,
      'required': instance.required,
      'displayType': instance.displayType,
      'categoryProductAttributeId': instance.categoryProductAttributeId,
      'productAttributeId': instance.productAttributeId,
      'facet': instance.facet,
      'searchable': instance.searchable,
      'variant': instance.variant,
      'sortable': instance.sortable,
      'fieldId': instance.fieldId,
      'value': instance.value,
      'lobId': instance.lobId,
      'prodAttrId': instance.prodAttrId,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'selectedPeriod': instance.selectedPeriod,
      'price': instance.price,
      'unitType': instance.unitType,
      'perUnitWeight': instance.perUnitWeight,
      'minOrderQty': instance.minOrderQty,
      'valuesList': instance.valuesList,
      'currency': instance.currency,
      'catProdAttrValue': instance.catProdAttrValue,
      'country': instance.country,
      'uom': instance.uom,
      'incoterm': instance.incoterm,
      'attributeId': instance.attributeId,
      'selectedItem': instance.selectedItem
    };
