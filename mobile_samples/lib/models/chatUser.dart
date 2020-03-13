import 'package:json_annotation/json_annotation.dart';
import "securityPermissionDTO.dart";
part 'chatUser.g.dart';

@JsonSerializable()
class ChatUser {
    ChatUser();

    String description;
    String groupId;
    List<SecurityPermissionDTO> securityPermissionDTO;
    
    factory ChatUser.fromJson(Map<String,dynamic> json) => _$ChatUserFromJson(json);
    Map<String, dynamic> toJson() => _$ChatUserToJson(this);
}
