// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SectionModel _$SectionModelFromJson(Map<String, dynamic> json) => SectionModel(
      id: json['id'] as int?,
      code: json['code'] as String?,
      description: json['description'] as String?,
      isActive: json['isActive'] as bool?,
      buildingId: json['buildingId'] as int?,
      buildingDescription: json['buildingDescription'] as String?,
      animalCount: json['animalCount'] as int?,
      illAnimalCount: json['illAnimalCount'] as int?,
      trackingAnimalCount: json['trackingAnimalCount'] as int?,
      infectiousAnimalCount: json['infectiousAnimalCount'] as int?,
    );

Map<String, dynamic> _$SectionModelToJson(SectionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'description': instance.description,
      'isActive': instance.isActive,
      'buildingId': instance.buildingId,
      'buildingDescription': instance.buildingDescription,
      'animalCount': instance.animalCount,
      'illAnimalCount': instance.illAnimalCount,
      'trackingAnimalCount': instance.trackingAnimalCount,
      'infectiousAnimalCount': instance.infectiousAnimalCount,
    };
