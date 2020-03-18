import 'package:json_annotation/json_annotation.dart';
import "categoryTreePathDto.dart";
part 'leafResp.g.dart';

@JsonSerializable()
class LeafResp {
    LeafResp();

    CategoryTreePathDto categoryTreePathDto;
    
    factory LeafResp.fromJson(Map<String,dynamic> json) => _$LeafRespFromJson(json);
    Map<String, dynamic> toJson() => _$LeafRespToJson(this);
}
