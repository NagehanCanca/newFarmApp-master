// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalTypeModel _$AnimalTypeModelFromJson(Map<String, dynamic> json) =>
    AnimalTypeModel(
      id: json['id'] as int?,
      description: json['description'] as String?,
      insertUser: json['insertUser'] as String?,
      insertDate: json['insertDate'] == null
          ? null
          : DateTime.parse(json['insertDate'] as String),
      updateUser: json['updateUser'] as String?,
      updateDate: json['updateDate'] == null
          ? null
          : DateTime.parse(json['updateDate'] as String),
    );

Map<String, dynamic> _$AnimalTypeModelToJson(AnimalTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'insertUser': instance.insertUser,
      'insertDate': instance.insertDate?.toIso8601String(),
      'updateUser': instance.updateUser,
      'updateDate': instance.updateDate?.toIso8601String(),
    };
