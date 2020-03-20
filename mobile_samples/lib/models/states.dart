import 'package:json_annotation/json_annotation.dart';

part 'states.g.dart';

@JsonSerializable()
class States {
    States();

    String code;
    String name;
    
    factory States.fromJson(Map<String,dynamic> json) => _$StatesFromJson(json);
    Map<String, dynamic> toJson() => _$StatesToJson(this);
}
