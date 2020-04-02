import 'package:json_annotation/json_annotation.dart';
import "questionsDTO.dart";
part 'partyQuestionsList.g.dart';

@JsonSerializable()
class PartyQuestionsList {
    PartyQuestionsList();

    List<QuestionsDTO> questionsList;
    
    factory PartyQuestionsList.fromJson(Map<String,dynamic> json) => _$PartyQuestionsListFromJson(json);
    Map<String, dynamic> toJson() => _$PartyQuestionsListToJson(this);
}
