import 'package:json_annotation/json_annotation.dart';
import "leafCategoryListDto.dart";
part 'childCategoryDto.g.dart';

@JsonSerializable()
class ChildCategoryDto {
    ChildCategoryDto();

    String parentCategoryName;
    num parentCategoryId;
    List<LeafCategoryListDto> leafCategoryListDto;
    
    factory ChildCategoryDto.fromJson(Map<String,dynamic> json) => _$ChildCategoryDtoFromJson(json);
    Map<String, dynamic> toJson() => _$ChildCategoryDtoToJson(this);
}
