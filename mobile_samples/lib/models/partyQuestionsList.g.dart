// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partyQuestionsList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartyQuestionsList _$PartyQuestionsListFromJson(Map<String, dynamic> json) {
  return PartyQuestionsList()
    ..questionsList = (json['questionsList'] as List)
        ?.map((e) =>
            e == null ? null : QuestionsDTO.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$PartyQuestionsListToJson(PartyQuestionsList instance) =>
    <String, dynamic>{'questionsList': instance.questionsList};
