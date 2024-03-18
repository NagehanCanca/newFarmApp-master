// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disease_diagnose_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiseaseDiagnoseModel _$DiseaseDiagnoseModelFromJson(
        Map<String, dynamic> json) =>
    DiseaseDiagnoseModel(
      id: json['id'] as int,
      code: json['code'] as String,
      name: json['name'] as String,
      isInfectious: json['isInfectious'] as bool,
      insertUser: json['insertUser'] as int,
      insertDate: json['insertDate'] == null
          ? null
          : DateTime.parse(json['insertDate'] as String),
      updateUser: json['updateUser'] as int?,
      updateDate: json['updateDate'] == null
          ? null
          : DateTime.parse(json['updateDate'] as String),
    );

Map<String, dynamic> _$DiseaseDiagnoseModelToJson(
        DiseaseDiagnoseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'isInfectious': instance.isInfectious,
      'insertUser': instance.insertUser,
      'insertDate': instance.insertDate?.toIso8601String(),
      'updateUser': instance.updateUser,
      'updateDate': instance.updateDate?.toIso8601String(),
    };
