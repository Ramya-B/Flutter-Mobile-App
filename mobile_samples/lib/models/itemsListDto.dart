import 'package:json_annotation/json_annotation.dart';

part 'itemsListDto.g.dart';

@JsonSerializable()
class ItemsListDto {
    ItemsListDto();

    String customerRequestItemId;
    num customerRequestId;
    String statusId;
    String priority;
    String sequenceNum;
    String requiredByDate;
    String productId;
    num quantity;
    String quantityType;
    num selectedAmount;
    String maximumAmount;
    String reservStart;
    String reservLength;
    String reservPersons;
    String description;
    String story;
    String reqByDate;
    String globalPriceFlag;
    
    factory ItemsListDto.fromJson(Map<String,dynamic> json) => _$ItemsListDtoFromJson(json);
    Map<String, dynamic> toJson() => _$ItemsListDtoToJson(this);
}
