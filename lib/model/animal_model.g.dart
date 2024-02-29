// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalModel _$AnimalModelFromJson(Map<String, dynamic> json) => AnimalModel(
      id: json['id'] as int?,
      animalBuyingDetailId: json['animalBuyingDetailId'] as int?,
      animalStatus:
          $enumDecodeNullable(_$AnimalStatusEnumMap, json['animalStatus']),
      rfid: json['rfid'] as String?,
      earringNumber: json['earringNumber'] as String?,
      animalTypeId: json['animalTypeId'] as int?,
      animalTypeDescription: json['animalTypeDescription'] as String?,
      animalGender:
          $enumDecodeNullable(_$AnimalGenderEnumMap, json['animalGender']),
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      buildId: json['buildId'] as int?,
      buildDescription: json['buildDescription'] as String?,
      sectionId: json['sectionId'] as int?,
      sectionDescription: json['sectionDescription'] as String?,
      paddockId: json['paddockId'] as int?,
      paddockDescription: json['paddockDescription'] as String?,
      isInfectious: json['isInfectious'] as bool?,
      isTracking: json['isTracking'] as bool?,
      trackingUserId: json['trackingUserId'] as int?,
      trackingUser: json['trackingUser'] as String?,
      origin: json['origin'] as String?,
      image: json['image'] as String?,
      farmInsertDate: json['farmInsertDate'] == null
          ? null
          : DateTime.parse(json['farmInsertDate'] as String),
      animalRaceId: json['animalRaceId'] as int?,
      exDate: json['exDate'] == null
          ? null
          : DateTime.parse(json['exDate'] as String),
      insertUser: json['insertUser'] as String?,
      insertDate: json['insertDate'] == null
          ? null
          : DateTime.parse(json['insertDate'] as String),
      updateUser: json['updateUser'] as String?,
      updateDate: json['updateDate'] == null
          ? null
          : DateTime.parse(json['updateDate'] as String),
    );

Map<String, dynamic> _$AnimalModelToJson(AnimalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'animalBuyingDetailId': instance.animalBuyingDetailId,
      'animalStatus': _$AnimalStatusEnumMap[instance.animalStatus],
      'rfid': instance.rfid,
      'earringNumber': instance.earringNumber,
      'animalTypeId': instance.animalTypeId,
      'animalTypeDescription': instance.animalTypeDescription,
      'animalGender': _$AnimalGenderEnumMap[instance.animalGender],
      'birthDate': instance.birthDate?.toIso8601String(),
      'buildId': instance.buildId,
      'buildDescription': instance.buildDescription,
      'sectionId': instance.sectionId,
      'sectionDescription': instance.sectionDescription,
      'paddockId': instance.paddockId,
      'paddockDescription': instance.paddockDescription,
      'isInfectious': instance.isInfectious,
      'isTracking': instance.isTracking,
      'trackingUserId': instance.trackingUserId,
      'trackingUser': instance.trackingUser,
      'origin': instance.origin,
      'image': instance.image,
      'farmInsertDate': instance.farmInsertDate?.toIso8601String(),
      'animalRaceId': instance.animalRaceId,
      'exDate': instance.exDate?.toIso8601String(),
      'insertUser': instance.insertUser,
      'insertDate': instance.insertDate?.toIso8601String(),
      'updateUser': instance.updateUser,
      'updateDate': instance.updateDate?.toIso8601String(),
    };

const _$AnimalStatusEnumMap = {
  AnimalStatus.Normal: 'Normal',
  AnimalStatus.Ill: 'Ill',
  AnimalStatus.Ex: 'Ex',
  AnimalStatus.Sold: 'Sold',
};

const _$AnimalGenderEnumMap = {
  AnimalGender.Feminine: 'Feminine',
  AnimalGender.Masculine: 'Masculine',
};
