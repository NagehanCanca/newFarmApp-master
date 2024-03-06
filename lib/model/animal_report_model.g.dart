// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalReportModel _$AnimalReportModelFromJson(Map<String, dynamic> json) =>
    AnimalReportModel(
      animalId: json['animalId'] as int?,
      animalReportStatus: $enumDecodeNullable(
          _$AnimalReportStatusEnumMap, json['animalReportStatus']),
      description: json['description'] as String?,
      acceptUser: json['acceptUser'] as int?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      acceptDate: json['acceptDate'] == null
          ? null
          : DateTime.parse(json['acceptDate'] as String),
    );

Map<String, dynamic> _$AnimalReportModelToJson(AnimalReportModel instance) =>
    <String, dynamic>{
      'animalId': instance.animalId,
      'animalReportStatus':
          _$AnimalReportStatusEnumMap[instance.animalReportStatus],
      'description': instance.description,
      'acceptUser': instance.acceptUser,
      'date': instance.date?.toIso8601String(),
      'acceptDate': instance.acceptDate?.toIso8601String(),
    };

const _$AnimalReportStatusEnumMap = {
  AnimalReportStatus.NewReport: 0,
  AnimalReportStatus.AcceptedReport: 1,
};
