// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'securityQuestionRequestObject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SecurityQuestionRequestObject _$SecurityQuestionRequestObjectFromJson(
    Map<String, dynamic> json) {
  return SecurityQuestionRequestObject()
    ..questionId = json['questionId'] as String
    ..categoryId = json['categoryId'] as String
    ..answer = json['answer'] as String;
}

Map<String, dynamic> _$SecurityQuestionRequestObjectToJson(
        SecurityQuestionRequestObject instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'categoryId': instance.categoryId,
      'answer': instance.answer
    };
