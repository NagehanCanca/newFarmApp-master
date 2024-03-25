// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scale_device_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScaleDeviceModel _$ScaleDeviceModelFromJson(Map<String, dynamic> json) {
  return ScaleDeviceModel(
    id: json['id'] as int?,
    name: json['name'] as String?,
    scaleType: $enumDecodeNullable(_$ScaleTypeEnumMap, json['scaleType']),
    scaleStatus: $enumDecodeNullable(_$ScaleStatusEnumMap, json['scaleStatus']),
    blendId: json['blendId'] as int?,
    canBlend: json['canBlend'] as bool?,
    canDistribution: json['canDistribution'] as bool?,
    scaleConnectionType: $enumDecodeNullable(_$ScaleConnectionTypeEnumMap, json['scaleConnectionType']),
    connectionIp: json['connectionIp'] as String?,
    connectionPort: json['connectionPort'] as String?,
    connectionXmlUrl: json['connectionXmlUrl'] as String?,
    connectionSqlHostName: json['connectionSqlHostName'] as String?,
    connectionSqlUserName: json['connectionSqlUserName'] as String?,
    connectionSqlPassword: json['connectionSqlPassword'] as String?,
    connectionSqlDatabase: json['connectionSqlDatabase'] as String?,
    insertUser: json['insertUser'] as int?,
    insertUserDescription: json['insertUserDescription'] as String?,
    insertDate: json['insertDate'] == null ? null : DateTime.parse(json['insertDate'] as String),
    updateUser: json['updateUser'] as int?,
    updateUserDescription: json['updateUserDescription'] as String?,
    updateDate: json['updateDate'] == null ? null : DateTime.parse(json['updateDate'] as String),
  );
}

Map<String, dynamic> _$ScaleDeviceModelToJson(ScaleDeviceModel instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'scaleType': _$ScaleTypeEnumMap[instance.scaleType],
    'scaleStatus': _$ScaleStatusEnumMap[instance.scaleStatus],
    'blendId': instance.blendId,
    'canBlend': instance.canBlend,
    'canDistribution': instance.canDistribution,
    'scaleConnectionType': _$ScaleConnectionTypeEnumMap[instance.scaleConnectionType],
    'connectionIp': instance.connectionIp,
    'connectionPort': instance.connectionPort,
    'connectionXmlUrl': instance.connectionXmlUrl,
    'connectionSqlHostName': instance.connectionSqlHostName,
    'connectionSqlUserName': instance.connectionSqlUserName,
    'connectionSqlPassword': instance.connectionSqlPassword,
    'connectionSqlDatabase': instance.connectionSqlDatabase,
    'insertUser': instance.insertUser,
    'insertUserDescription': instance.insertUserDescription,
    'insertDate': instance.insertDate?.toIso8601String(),
    'updateUser': instance.updateUser,
    'updateUserDescription': instance.updateUserDescription,
    'updateDate': instance.updateDate?.toIso8601String(),
  };
  return val;
}

const _$ScaleTypeEnumMap = {
  ScaleType.FeedMixingScale: 0,
  ScaleType.AnimalScale: 1,
};

const _$ScaleStatusEnumMap = {
  ScaleStatus.Ready: 0,
  ScaleStatus.InUse: 1,
};

const _$ScaleConnectionTypeEnumMap = {
  ScaleConnectionType.Port: 0,
  ScaleConnectionType.XmlUrl: 1,
  ScaleConnectionType.Sql: 2,
};
