import 'package:json_annotation/json_annotation.dart';
import "questionsDTO.dart";
part 'securityQuestionsResponse.g.dart';

@JsonSerializable()
class SecurityQuestionsResponse {
    SecurityQuestionsResponse();

    List<QuestionsDTO> questionsDTO;
    
    factory SecurityQuestionsResponse.fromJson(Map<String,dynamic> json) => _$SecurityQuestionsResponseFromJson(json);
    Map<String, dynamic> toJson() => _$SecurityQuestionsResponseToJson(this);
}
