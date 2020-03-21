import 'package:json_annotation/json_annotation.dart';
import "identificationFieldsList.dart";
part 'identificationTypeDTOList.g.dart';

@JsonSerializable()
class IdentificationTypeDTOList {
    IdentificationTypeDTOList();

    String identificationTypeId;
    String identificationTypeName;
    List<IdentificationFieldsList> identificationFieldsList;
    
    factory IdentificationTypeDTOList.fromJson(Map<String,dynamic> json) => _$IdentificationTypeDTOListFromJson(json);
    Map<String, dynamic> toJson() => _$IdentificationTypeDTOListToJson(this);
}
