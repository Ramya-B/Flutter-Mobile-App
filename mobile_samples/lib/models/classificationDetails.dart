import 'package:json_annotation/json_annotation.dart';

part 'classificationDetails.g.dart';

@JsonSerializable()
class ClassificationDetails {
    ClassificationDetails();

    String id;
    String type;
    String value;
    
    factory ClassificationDetails.fromJson(Map<String,dynamic> json) => _$ClassificationDetailsFromJson(json);
    Map<String, dynamic> toJson() => _$ClassificationDetailsToJson(this);
}
