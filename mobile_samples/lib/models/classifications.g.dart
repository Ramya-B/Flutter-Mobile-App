// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classifications.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Classifications _$ClassificationsFromJson(Map<String, dynamic> json) {
  return Classifications()
    ..details = (json['details'] as List)
        ?.map((e) => e == null
            ? null
            : ClassificationDetails.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ClassificationsToJson(Classifications instance) =>
    <String, dynamic>{'details': instance.details};
