import 'package:json_annotation/json_annotation.dart';
import "requestDetailDto.dart";
part 'leadDetailResponseDto.g.dart';

@JsonSerializable()
class LeadDetailResponseDto {
    LeadDetailResponseDto();

    RequestDetailDto requestDTO;
    
    factory LeadDetailResponseDto.fromJson(Map<String,dynamic> json) => _$LeadDetailResponseDtoFromJson(json);
    Map<String, dynamic> toJson() => _$LeadDetailResponseDtoToJson(this);
}
