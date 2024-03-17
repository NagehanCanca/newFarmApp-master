// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeightModel _$WeightModelFromJson(Map<String, dynamic> json) {
  return WeightModel(
    id: json['id'] as int,
    date: DateTime.parse(json['date'] as String),
    weightStatus:
    $enumDecode(_$WeightStatusEnumMap, json['weightStatus']),
    paddockId: json['paddockId'] as int,
    paddockDescription: json['paddockDescription'] as String,
    sectionId: json['sectionId'] as int,
    sectionDescription: json['sectionDescription'] as String,
    buildingId: json['buildingId'] as int,
    buildingDescription: json['buildingDescription'] as String,
    scaleDeviceId: json['scaleDeviceId'] as int,
    scaleDeviceDescription: json['scaleDeviceDescription'] as String,
    isNewAnimal: json['isNewAnimal'] as bool,
    insertUser: json['insertUser'] as int,
    insertUserDescription: json['insertUserDescription'] as String,
    insertDate: json['insertDate'] == null
        ? null
        : DateTime.parse(json['insertDate'] as String),
    updateUser: json['updateUser'] as int?,
    updateUserDescription: json['updateUserDescription'] as String?,
    updateDate: json['updateDate'] == null
        ? null
        : DateTime.parse(json['updateDate'] as String),
  );
}

Map<String, dynamic> _$WeightModelToJson(WeightModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'weightStatus': _$WeightStatusEnumMap[instance.weightStatus],
      'paddockId': instance.paddockId,
      'paddockDescription': instance.paddockDescription,
      'sectionId': instance.sectionId,
      'sectionDescription': instance.sectionDescription,
      'buildingId': instance.buildingId,
      'buildingDescription': instance.buildingDescription,
      'scaleDeviceId': instance.scaleDeviceId,
      'scaleDeviceDescription': instance.scaleDeviceDescription,
      'isNewAnimal': instance.isNewAnimal,
      'insertUser': instance.insertUser,
      'insertUserDescription': instance.insertUserDescription,
      'insertDate': instance.insertDate?.toIso8601String(),
      'updateUser': instance.updateUser,
      'updateUserDescription': instance.updateUserDescription,
      'updateDate': instance.updateDate?.toIso8601String(),
    };

const _$WeightStatusEnumMap = {
  WeightStatus.NewList: 0,
  WeightStatus.AcceptedList: 1,
};
