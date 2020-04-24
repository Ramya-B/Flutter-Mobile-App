import 'package:json_annotation/json_annotation.dart';
import "requestDetails.dart";
part 'inquiriesResponseDto.g.dart';

@JsonSerializable()
class InquiriesResponseDto {
    InquiriesResponseDto();

    String parentRequestDTO;
    List<RequestDetails> requestDetails;
    num totalCount;
    
    factory InquiriesResponseDto.fromJson(Map<String,dynamic> json) => _$InquiriesResponseDtoFromJson(json);
    Map<String, dynamic> toJson() => _$InquiriesResponseDtoToJson(this);
}
