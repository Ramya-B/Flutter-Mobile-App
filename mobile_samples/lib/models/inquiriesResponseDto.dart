import 'package:json_annotation/json_annotation.dart';
import "parentRequestDTO.dart";
import "requestDetails.dart";
part 'inquiriesResponseDto.g.dart';

@JsonSerializable()
class InquiriesResponseDto {
    InquiriesResponseDto();

    ParentRequestDTO parentRequestDTO;
    List<RequestDetails> requestDetails;
    num totalCount;
    
    factory InquiriesResponseDto.fromJson(Map<String,dynamic> json) => _$InquiriesResponseDtoFromJson(json);
    Map<String, dynamic> toJson() => _$InquiriesResponseDtoToJson(this);
}
