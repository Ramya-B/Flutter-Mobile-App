// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partyQuestionsListRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartyQuestionsListRequest _$PartyQuestionsListRequestFromJson(
    Map<String, dynamic> json) {
  return PartyQuestionsListRequest()
    ..partyQuestionsList = json['partyQuestionsList'] == null
        ? null
        : PartyQuestionsList.fromJson(
            json['partyQuestionsList'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PartyQuestionsListRequestToJson(
        PartyQuestionsListRequest instance) =>
    <String, dynamic>{'partyQuestionsList': instance.partyQuestionsList};
