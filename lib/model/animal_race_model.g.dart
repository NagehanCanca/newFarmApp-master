// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_race_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalRaceModel _$AnimalRaceModelFromJson(Map<String, dynamic> json) =>
    AnimalRaceModel(
      id: json['id'] as int?,
      raceName: json['raceName'] as String?,
      insertUser: json['insertUser'] as String?,
      insertDate: json['insertDate'] == null
          ? null
          : DateTime.parse(json['insertDate'] as String),
      updateUser: json['updateUser'] as String?,
      updateDate: json['updateDate'] == null
          ? null
          : DateTime.parse(json['updateDate'] as String),
    );

Map<String, dynamic> _$AnimalRaceModelToJson(AnimalRaceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'raceName': instance.raceName,
      'insertUser': instance.insertUser,
      'insertDate': instance.insertDate?.toIso8601String(),
      'updateUser': instance.updateUser,
      'updateDate': instance.updateDate?.toIso8601String(),
    };
