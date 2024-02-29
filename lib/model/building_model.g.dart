// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuildingModel _$BuildingModelFromJson(Map<String, dynamic> json) =>
    BuildingModel(
      id: json['id'] as int?,
      code: json['code'] as String?,
      description: json['description'] as String?,
      isActive: json['isActive'] as bool?,
      animalCount: json['animalCount'] as int?,
      illAnimalCount: json['illAnimalCount'] as int?,
      trackingAnimalCount: json['trackingAnimalCount'] as int?,
      infectiousAnimalCount: json['infectiousAnimalCount'] as int?,
    );

Map<String, dynamic> _$BuildingModelToJson(BuildingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'description': instance.description,
      'isActive': instance.isActive,
      'animalCount': instance.animalCount,
      'illAnimalCount': instance.illAnimalCount,
      'trackingAnimalCount': instance.trackingAnimalCount,
      'infectiousAnimalCount': instance.infectiousAnimalCount,
    };
