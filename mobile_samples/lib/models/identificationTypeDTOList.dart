import 'package:json_annotation/json_annotation.dart';
import "identificationFieldsList.dart";
part 'identificationTypeDTOList.g.dart';

@JsonSerializable()
class IdentificationTypeDTOList {
    IdentificationTypeDTOList();

    String identificationTypeId;
    String identificationTypeName;
    String attributeName;
    String attributeType;
    String attributeValue;
    List<IdentificationFieldsList> identificationFieldsList;
    String identificationGroupId;
    String attributeNameWithOutBucketName;
    
    factory IdentificationTypeDTOList.fromJson(Map<String,dynamic> json) => _$IdentificationTypeDTOListFromJson(json);
    Map<String, dynamic> toJson() => _$IdentificationTypeDTOListToJson(this);
}
