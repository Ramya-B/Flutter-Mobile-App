// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questionsDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionsDTO _$QuestionsDTOFromJson(Map<String, dynamic> json) {
  return QuestionsDTO()
    ..questionId = json['questionId'] as String
    ..categoryId = json['categoryId'] as String
    ..question = json['question'] as String
    ..answer = json['answer'] as String;
}

Map<String, dynamic> _$QuestionsDTOToJson(QuestionsDTO instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'categoryId': instance.categoryId,
      'question': instance.question,
      'answer': instance.answer
    };
