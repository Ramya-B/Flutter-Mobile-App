import 'package:json_annotation/json_annotation.dart';

part 'questionsDTO.g.dart';

@JsonSerializable()
class QuestionsDTO {
    QuestionsDTO();

    String questionId;
    String categoryId;
    String question;
    String answer;
    
    factory QuestionsDTO.fromJson(Map<String,dynamic> json) => _$QuestionsDTOFromJson(json);
    Map<String, dynamic> toJson() => _$QuestionsDTOToJson(this);
}
