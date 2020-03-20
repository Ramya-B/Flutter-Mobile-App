import 'package:json_annotation/json_annotation.dart';
import "identificationTypeDTOList.dart";
part 'identificationGroups.g.dart';

@JsonSerializable()
class IdentificationGroups {
    IdentificationGroups();

    String identificationGroupId;
    String companyTypeId;
    String name;
    String description;
    List<IdentificationTypeDTOList> identificationTypeDTOList;
    
    factory IdentificationGroups.fromJson(Map<String,dynamic> json) => _$IdentificationGroupsFromJson(json);
    Map<String, dynamic> toJson() => _$IdentificationGroupsToJson(this);
}
