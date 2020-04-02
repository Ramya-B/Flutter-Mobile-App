// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questionsList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionsList _$QuestionsListFromJson(Map<String, dynamic> json) {
  return QuestionsList()
    ..questionId = json['questionId'] as String
    ..categoryId = json['categoryId'] as String
    ..question = json['question'] as String;
}

Map<String, dynamic> _$QuestionsListToJson(QuestionsList instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'categoryId': instance.categoryId,
      'question': instance.question
    };
