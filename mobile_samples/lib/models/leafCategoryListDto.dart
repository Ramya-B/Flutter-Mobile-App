import 'package:json_annotation/json_annotation.dart';

part 'leafCategoryListDto.g.dart';

@JsonSerializable()
class LeafCategoryListDto {
    LeafCategoryListDto();

    num categoryId;
    num parentId;
    String name;
    String path;
    
    factory LeafCategoryListDto.fromJson(Map<String,dynamic> json) => _$LeafCategoryListDtoFromJson(json);
    Map<String, dynamic> toJson() => _$LeafCategoryListDtoToJson(this);
}
