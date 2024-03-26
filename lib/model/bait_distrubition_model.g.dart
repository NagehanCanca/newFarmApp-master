// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bait_distrubition_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaitDistributionModel _$BaitDistributionModelFromJson(Map<String, dynamic> json) {
  return BaitDistributionModel(
    id: json['id'] as int?,
    baitId: json['baitId'] as int?,
    baitDescription: json['baitDescription'] as String?,
    baitAnimalCount: json['baitAnimalCount'] as int?,
    baitAppliedAnimalCount: json['baitAppliedAnimalCount'] as int?,
    baitScaleCount: json['baitScaleCount'] as int?,
    baitDontPremix: json['baitDontPremix'] as bool?,
    baitDistributionStatus: $enumDecodeNullable(_$BaitDistributionStatusEnumMap, json['baitDistributionStatus']),
    baitDistributionDate: json['baitDistributionDate'] == null ? null : DateTime.parse(json['baitDistributionDate'] as String),
    scaleDeviceId: json['scaleDeviceId'] as int?,
    scaleDeviceDescription: json['scaleDeviceDescription'] as String?,
    blendUserId: json['blendUserId'] as int?,
    blendUserDescription: json['blendUserDescription'] as String?,
    blendDate: json['blendDate'] == null ? null : DateTime.parse(json['blendDate'] as String),
    distributionUserId: json['distributionUserId'] as int?,
    distributionUserDescription: json['distributionUserDescription'] as String?,
    distributionDate: json['distributionDate'] == null ? null : DateTime.parse(json['distributionDate'] as String),
    insertUser: json['insertUser'] as int?,
    insertUserDescription: json['insertUserDescription'] as String?,
    insertDate: json['insertDate'] == null ? null : DateTime.parse(json['insertDate'] as String),
    updateUser: json['updateUser'] as int?,
    updateUserDescription: json['updateUserDescription'] as String?,
    updateDate: json['updateDate'] == null ? null : DateTime.parse(json['updateDate'] as String),
  );
}

Map<String, dynamic> _$BaitDistributionModelToJson(BaitDistributionModel instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'baitId': instance.baitId,
    'baitDescription': instance.baitDescription,
    'baitAnimalCount': instance.baitAnimalCount,
    'baitAppliedAnimalCount': instance.baitAppliedAnimalCount,
    'baitScaleCount': instance.baitScaleCount,
    'baitDontPremix': instance.baitDontPremix,
    'baitDistributionStatus': _$BaitDistributionStatusEnumMap[instance.baitDistributionStatus],
    'baitDistributionDate': instance.baitDistributionDate?.toIso8601String(),
    'scaleDeviceId': instance.scaleDeviceId,
    'scaleDeviceDescription': instance.scaleDeviceDescription,
    'blendUserId': instance.blendUserId,
    'blendUserDescription': instance.blendUserDescription,
    'blendDate': instance.blendDate?.toIso8601String(),
    'distributionUserId': instance.distributionUserId,
    'distributionUserDescription': instance.distributionUserDescription,
    'distributionDate': instance.distributionDate?.toIso8601String(),
    'insertUser': instance.insertUser,
    'insertUserDescription': instance.insertUserDescription,
    'insertDate': instance.insertDate?.toIso8601String(),
    'updateUser': instance.updateUser,
    'updateUserDescription': instance.updateUserDescription,
    'updateDate': instance.updateDate?.toIso8601String(),
  };
  return val;
}

const _$BaitDistributionStatusEnumMap = {
  BaitDistributionStatus.New: 0,
  BaitDistributionStatus.Blending: 1,
  BaitDistributionStatus.Ready: 2,
  BaitDistributionStatus.Distributed: 3,
};
