import 'package:json_annotation/json_annotation.dart';

part 'chatCredentials.g.dart';

@JsonSerializable()
class ChatCredentials {
    ChatCredentials();

    String jid;
    String sid;
    num rid;
    
    factory ChatCredentials.fromJson(Map<String,dynamic> json) => _$ChatCredentialsFromJson(json);
    Map<String, dynamic> toJson() => _$ChatCredentialsToJson(this);
}
