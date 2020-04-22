import 'package:json_annotation/json_annotation.dart';
import "classificationDetails.dart";
part 'classifications.g.dart';

@JsonSerializable()
class Classifications {
    Classifications();

    List<ClassificationDetails> details;
    
    factory Classifications.fromJson(Map<String,dynamic> json) => _$ClassificationsFromJson(json);
    Map<String, dynamic> toJson() => _$ClassificationsToJson(this);
}
