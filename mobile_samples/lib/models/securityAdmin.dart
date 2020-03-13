import 'package:json_annotation/json_annotation.dart';
import "securityPermissionDTO.dart";
part 'securityAdmin.g.dart';

@JsonSerializable()
class SecurityAdmin {
    SecurityAdmin();

    String description;
    String groupId;
    List<SecurityPermissionDTO> securityPermissionDTO;
    
    factory SecurityAdmin.fromJson(Map<String,dynamic> json) => _$SecurityAdminFromJson(json);
    Map<String, dynamic> toJson() => _$SecurityAdminToJson(this);
}
