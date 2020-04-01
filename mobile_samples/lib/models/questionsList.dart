import 'package:json_annotation/json_annotation.dart';

part 'questionsList.g.dart';

@JsonSerializable()
class QuestionsList {
    QuestionsList();

    String questionId;
    String categoryId;
    String question;
    
    factory QuestionsList.fromJson(Map<String,dynamic> json) => _$QuestionsListFromJson(json);
    Map<String, dynamic> toJson() => _$QuestionsListToJson(this);
}
