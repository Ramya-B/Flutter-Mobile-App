import 'package:json_annotation/json_annotation.dart';

part 'ratingReviewCriterias.g.dart';

@JsonSerializable()
class RatingReviewCriterias {
    RatingReviewCriterias();

    List companyCritMapDto;
    List userCritMapDto;
    
    factory RatingReviewCriterias.fromJson(Map<String,dynamic> json) => _$RatingReviewCriteriasFromJson(json);
    Map<String, dynamic> toJson() => _$RatingReviewCriteriasToJson(this);
}
