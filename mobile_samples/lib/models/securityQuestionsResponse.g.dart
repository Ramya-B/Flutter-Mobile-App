// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'securityQuestionsResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SecurityQuestionsResponse _$SecurityQuestionsResponseFromJson(
    Map<String, dynamic> json) {
  return SecurityQuestionsResponse()
    ..questionsDTO = (json['questionsDTO'] as List)
        ?.map((e) =>
            e == null ? null : QuestionsDTO.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$SecurityQuestionsResponseToJson(
        SecurityQuestionsResponse instance) =>
    <String, dynamic>{'questionsDTO': instance.questionsDTO};
