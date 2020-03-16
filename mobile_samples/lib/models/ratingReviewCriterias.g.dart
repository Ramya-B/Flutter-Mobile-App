// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ratingReviewCriterias.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingReviewCriterias _$RatingReviewCriteriasFromJson(
    Map<String, dynamic> json) {
  return RatingReviewCriterias()
    ..companyCritMapDto = json['companyCritMapDto'] as List
    ..userCritMapDto = json['userCritMapDto'] as List;
}

Map<String, dynamic> _$RatingReviewCriteriasToJson(
        RatingReviewCriterias instance) =>
    <String, dynamic>{
      'companyCritMapDto': instance.companyCritMapDto,
      'userCritMapDto': instance.userCritMapDto
    };
