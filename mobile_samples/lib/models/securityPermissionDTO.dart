import 'package:json_annotation/json_annotation.dart';

part 'securityPermissionDTO.g.dart';

@JsonSerializable()
class SecurityPermissionDTO {
    SecurityPermissionDTO();

    String description;
    String permissionId;
    
    factory SecurityPermissionDTO.fromJson(Map<String,dynamic> json) => _$SecurityPermissionDTOFromJson(json);
    Map<String, dynamic> toJson() => _$SecurityPermissionDTOToJson(this);
}
