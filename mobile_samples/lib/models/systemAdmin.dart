import 'package:json_annotation/json_annotation.dart';
import "securityPermissionDTO.dart";
part 'systemAdmin.g.dart';

@JsonSerializable()
class SystemAdmin {
    SystemAdmin();

    String description;
    String groupId;
    List<SecurityPermissionDTO> securityPermissionDTO;
    
    factory SystemAdmin.fromJson(Map<String,dynamic> json) => _$SystemAdminFromJson(json);
    Map<String, dynamic> toJson() => _$SystemAdminToJson(this);
}
