import 'package:json_annotation/json_annotation.dart';
import "partyQuestionsList.dart";
part 'partyQuestionsListRequest.g.dart';

@JsonSerializable()
class PartyQuestionsListRequest {
    PartyQuestionsListRequest();

    PartyQuestionsList partyQuestionsList;
    
    factory PartyQuestionsListRequest.fromJson(Map<String,dynamic> json) => _$PartyQuestionsListRequestFromJson(json);
    Map<String, dynamic> toJson() => _$PartyQuestionsListRequestToJson(this);
}
