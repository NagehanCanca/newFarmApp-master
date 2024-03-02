// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paddock_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaddockModel _$PaddockModelFromJson(Map<String, dynamic> json) => PaddockModel(
      id: json['id'] as int?,
      code: json['code'] as String?,
      description: json['description'] as String?,
      paddockType:
          $enumDecodeNullable(_$PaddockTypeEnumMap, json['paddockType']),
      isActive: json['isActive'] as bool?,
      buildingId: json['buildingId'] as int?,
      buildingDescription: json['buildingDescription'] as String?,
      sectionId: json['sectionId'] as int?,
      sectionDescription: json['sectionDescription'] as String?,
      animalCount: json['animalCount'] as int?,
      illAnimalCount: json['illAnimalCount'] as int?,
      trackingAnimalCount: json['trackingAnimalCount'] as int?,
      infectiousAnimalCount: json['infectiousAnimalCount'] as int?,
    );

Map<String, dynamic> _$PaddockModelToJson(PaddockModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'description': instance.description,
      'paddockType': _$PaddockTypeEnumMap[instance.paddockType],
      'isActive': instance.isActive,
      'buildingId': instance.buildingId,
      'buildingDescription': instance.buildingDescription,
      'sectionId': instance.sectionId,
      'sectionDescription': instance.sectionDescription,
      'animalCount': instance.animalCount,
      'illAnimalCount': instance.illAnimalCount,
      'trackingAnimalCount': instance.trackingAnimalCount,
      'infectiousAnimalCount': instance.infectiousAnimalCount,
    };

const _$PaddockTypeEnumMap = {
  PaddockType.Normal: 0,
  PaddockType.Infirmary: 1,
};
