import 'package:json_annotation/json_annotation.dart';
import "identificationAttributesList.dart";
part 'identificationNumbers.g.dart';

@JsonSerializable()
class IdentificationNumbers {
    IdentificationNumbers();

    List<IdentificationAttributesList> identificationAttributesList;
    
    factory IdentificationNumbers.fromJson(Map<String,dynamic> json) => _$IdentificationNumbersFromJson(json);
    Map<String, dynamic> toJson() => _$IdentificationNumbersToJson(this);
}
