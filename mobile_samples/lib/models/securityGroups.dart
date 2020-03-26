import 'package:json_annotation/json_annotation.dart';
import "securityAdmin.dart";
import "chatUser.dart";
import "systemAdmin.dart";
part 'securityGroups.g.dart';

@JsonSerializable()
class SecurityGroups {
    SecurityGroups();

    SecurityAdmin securityAdmin;
    ChatUser chatUser;
    SystemAdmin systemAdmin;
    
    factory SecurityGroups.fromJson(Map<String,dynamic> json) => _$SecurityGroupsFromJson(json);
    Map<String, dynamic> toJson() => _$SecurityGroupsToJson(this);
}
