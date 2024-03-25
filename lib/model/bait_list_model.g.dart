// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bait_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaitListModel _$BaitListModelFromJson(Map<String, dynamic> json) {
  return BaitListModel(
    id: json['id'] as int?,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    baitListStatus: $enumDecodeNullable(_$BaitListStatusEnumMap, json['baitListStatus']),
    description: json['description'] as String?,
    animalCount: json['animalCount'] as int?,
    appliedAnimalCount: json['appliedAnimalCount'] as int?,
    scaleCount: json['scaleCount'] as int?,
    elwg1: (json['elwg1'] as num?)?.toDouble(),
    elwg2: (json['elwg2'] as num?)?.toDouble(),
    elwg3: (json['elwg3'] as num?)?.toDouble(),
    dontPremix: json['dontPremix'] as bool?,
    copyBaitId: json['copyBaitId'] as int?,
    insertUser: json['insertUser'] as int?,
    insertUserDescription: json['insertUserDescription'] as String?,
    insertDate: json['insertDate'] == null ? null : DateTime.parse(json['insertDate'] as String),
    updateUser: json['updateUser'] as int?,
    updateUserDescription: json['updateUserDescription'] as String?,
    updateDate: json['updateDate'] == null ? null : DateTime.parse(json['updateDate'] as String),
  );
}

Map<String, dynamic> _$BaitListModelToJson(BaitListModel instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'date': instance.date?.toIso8601String(),
    'baitListStatus': _$BaitListStatusEnumMap[instance.baitListStatus],
    'description': instance.description,
    'animalCount': instance.animalCount,
    'appliedAnimalCount': instance.appliedAnimalCount,
    'scaleCount': instance.scaleCount,
    'elwg1': instance.elwg1,
    'elwg2': instance.elwg2,
    'elwg3': instance.elwg3,
    'dontPremix': instance.dontPremix,
    'copyBaitId': instance.copyBaitId,
    'insertUser': instance.insertUser,
    'insertUserDescription': instance.insertUserDescription,
    'insertDate': instance.insertDate?.toIso8601String(),
    'updateUser': instance.updateUser,
    'updateUserDescription': instance.updateUserDescription,
    'updateDate': instance.updateDate?.toIso8601String(),
  };
  return val;
}

const _$BaitListStatusEnumMap = {
  BaitListStatus.Passive: 0,
  BaitListStatus.Active: 1,
  BaitListStatus.All: 2,
};
