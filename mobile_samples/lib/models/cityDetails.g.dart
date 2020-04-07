// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cityDetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityDetails _$CityDetailsFromJson(Map<String, dynamic> json) {
  return CityDetails()
    ..ID = json['ID'] as num
    ..countryCode = json['countryCode'] as String
    ..postalCode = json['postalCode'] as String
    ..village = json['village'] as String
    ..state = json['state'] as String
    ..stateID = json['stateID'] as String
    ..city = json['city'] as String
    ..column_6 = json['column_6'] as String
    ..town = json['town'] as String
    ..column_8 = json['column_8'] as String
    ..latitude = json['latitude'] as num
    ..longitude = json['longitude'] as num
    ..column_11 = json['column_11'] as String
    ..cityImage = json['cityImage'] as String
    ..modified = json['modified'] as String
    ..created = json['created'] as String
    ..location = json['location'] == null
        ? null
        : Location.fromJson(json['location'] as Map<String, dynamic>)
    ..isPopular = json['isPopular'] as bool
    ..isActive = json['isActive'] as bool;
}

Map<String, dynamic> _$CityDetailsToJson(CityDetails instance) =>
    <String, dynamic>{
      'ID': instance.ID,
      'countryCode': instance.countryCode,
      'postalCode': instance.postalCode,
      'village': instance.village,
      'state': instance.state,
      'stateID': instance.stateID,
      'city': instance.city,
      'column_6': instance.column_6,
      'town': instance.town,
      'column_8': instance.column_8,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'column_11': instance.column_11,
      'cityImage': instance.cityImage,
      'modified': instance.modified,
      'created': instance.created,
      'location': instance.location,
      'isPopular': instance.isPopular,
      'isActive': instance.isActive
    };
