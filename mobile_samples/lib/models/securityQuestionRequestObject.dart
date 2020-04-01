import 'package:json_annotation/json_annotation.dart';

part 'securityQuestionRequestObject.g.dart';

@JsonSerializable()
class SecurityQuestionRequestObject {
    SecurityQuestionRequestObject();

    String questionId;
    String categoryId;
    String answer;
    
    factory SecurityQuestionRequestObject.fromJson(Map<String,dynamic> json) => _$SecurityQuestionRequestObjectFromJson(json);
    Map<String, dynamic> toJson() => _$SecurityQuestionRequestObjectToJson(this);
}
