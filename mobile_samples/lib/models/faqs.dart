import 'package:json_annotation/json_annotation.dart';

part 'faqs.g.dart';

@JsonSerializable()
class Faqs {
    Faqs();

    String modifiedBy;
    bool active;
    String answer;
    String question;
    String name;
    String modified;
    String created;
    
    factory Faqs.fromJson(Map<String,dynamic> json) => _$FaqsFromJson(json);
    Map<String, dynamic> toJson() => _$FaqsToJson(this);
}
