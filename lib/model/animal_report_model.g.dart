// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalReportModel _$AnimalReportModelFromJson(Map<String, dynamic> json) =>
    AnimalReportModel(
      id: json['id'] as int?,
      animalId: json['animalId'] as int?,
      animalReportStatus: $enumDecodeNullable(
          _$AnimalReportStatusEnumMap, json['animalReportStatus']),
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      description: json['description'] as String?,
      acceptUser: json['acceptUser'] as int?,
      acceptUserDescription: json['acceptUserDescription'] as String?,
      acceptDate: json['acceptDate'] == null
          ? null
          : DateTime.parse(json['acceptDate'] as String),
      earringNumber: json['earringNumber'] as String?,
      rfId: json['rfId'] as String?,
      animalGender:
          $enumDecodeNullable(_$AnimalGenderEnumMap, json['animalGender']),
      buildDescription: json['buildDescription'] as String?,
      sectionDescription: json['sectionDescription'] as String?,
      paddockDescription: json['paddockDescription'] as String?,
      isInfectious: json['isInfectious'] as bool?,
      isTracking: json['isTracking'] as bool?,
      trackingUser: json['trackingUser'] as String?,
      origin: json['origin'] as String?,
      farmInsertDate: json['farmInsertDate'] == null
          ? null
          : DateTime.parse(json['farmInsertDate'] as String),
      animalRaceDescription: json['animalRaceDescription'] as String?,
      insertUser: json['insertUser'] as int?,
      insertUserDescription: json['insertUserDescription'] as String?,
      insertDate: json['insertDate'] == null
          ? null
          : DateTime.parse(json['insertDate'] as String),
      updateUser: json['updateUser'] as int?,
      updateUserDescription: json['updateUserDescription'] as String?,
      updateDate: json['updateDate'] == null
          ? null
          : DateTime.parse(json['updateDate'] as String),
    );

Map<String, dynamic> _$AnimalReportModelToJson(AnimalReportModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'animalId': instance.animalId,
      'animalReportStatus':
          _$AnimalReportStatusEnumMap[instance.animalReportStatus],
      'date': instance.date?.toIso8601String(),
      'description': instance.description,
      'acceptUser': instance.acceptUser,
      'acceptUserDescription': instance.acceptUserDescription,
      'acceptDate': instance.acceptDate?.toIso8601String(),
      'earringNumber': instance.earringNumber,
      'rfId': instance.rfId,
      'animalGender': _$AnimalGenderEnumMap[instance.animalGender],
      'buildDescription': instance.buildDescription,
      'sectionDescription': instance.sectionDescription,
      'paddockDescription': instance.paddockDescription,
      'isInfectious': instance.isInfectious,
      'isTracking': instance.isTracking,
      'trackingUser': instance.trackingUser,
      'origin': instance.origin,
      'farmInsertDate': instance.farmInsertDate?.toIso8601String(),
      'animalRaceDescription': instance.animalRaceDescription,
      'insertUser': instance.insertUser,
      'insertUserDescription': instance.insertUserDescription,
      'insertDate': instance.insertDate?.toIso8601String(),
      'updateUser': instance.updateUser,
      'updateUserDescription': instance.updateUserDescription,
      'updateDate': instance.updateDate?.toIso8601String(),
    };

const _$AnimalReportStatusEnumMap = {
  AnimalReportStatus.NewReport: 0,
  AnimalReportStatus.AcceptedReport: 1,
};

const _$AnimalGenderEnumMap = {
  AnimalGender.Feminine: 0,
  AnimalGender.Masculine: 1,
};
