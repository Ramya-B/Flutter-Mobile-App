import 'package:json_annotation/json_annotation.dart';

part 'email.g.dart';

@JsonSerializable()
class Email {
    Email();

    String verified;
    String emailType;
    String emailAddress;
    String id;
    
    factory Email.fromJson(Map<String,dynamic> json) => _$EmailFromJson(json);
    Map<String, dynamic> toJson() => _$EmailToJson(this);
}
