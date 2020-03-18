import 'package:json_annotation/json_annotation.dart';
import "childCategoryDto.dart";
part 'categoryTreePathDto.g.dart';

@JsonSerializable()
class CategoryTreePathDto {
    CategoryTreePathDto();

    List<ChildCategoryDto> childCategoryDto;
    
    factory CategoryTreePathDto.fromJson(Map<String,dynamic> json) => _$CategoryTreePathDtoFromJson(json);
    Map<String, dynamic> toJson() => _$CategoryTreePathDtoToJson(this);
}
