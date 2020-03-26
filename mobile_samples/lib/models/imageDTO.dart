import 'package:json_annotation/json_annotation.dart';

part 'imageDTO.g.dart';

@JsonSerializable()
class ImageDTO {
    ImageDTO();

    String imageType;
    String imageUrl;
    bool isCoverPhoto;
    bool isHide;
    String lobId;
    String name;
    
    factory ImageDTO.fromJson(Map<String,dynamic> json) => _$ImageDTOFromJson(json);
    Map<String, dynamic> toJson() => _$ImageDTOToJson(this);
}
