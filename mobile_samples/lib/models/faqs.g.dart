// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faqs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Faqs _$FaqsFromJson(Map<String, dynamic> json) {
  return Faqs()
    ..modifiedBy = json['modifiedBy'] as String
    ..active = json['active'] as bool
    ..answer = json['answer'] as String
    ..question = json['question'] as String
    ..name = json['name'] as String
    ..modified = json['modified'] as String
    ..created = json['created'] as String;
}

Map<String, dynamic> _$FaqsToJson(Faqs instance) => <String, dynamic>{
      'modifiedBy': instance.modifiedBy,
      'active': instance.active,
      'answer': instance.answer,
      'question': instance.question,
      'name': instance.name,
      'modified': instance.modified,
      'created': instance.created
    };
