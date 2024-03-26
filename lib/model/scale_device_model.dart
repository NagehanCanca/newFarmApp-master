import 'package:json_annotation/json_annotation.dart';

part 'scale_device_model.g.dart';

@JsonSerializable()
class ScaleDeviceModel {
  int? id;
  String? name;
  ScaleType? scaleType;
  ScaleStatus? scaleStatus;
  int? baitDistrubitonId;
  bool? canBlend;
  bool? canDistribution;
  ScaleConnectionType? scaleConnectionType;
  String? connectionIp;
  String? connectionPort;
  String? connectionXmlUrl;
  String? connectionSqlHostName;
  String? connectionSqlUserName;
  String? connectionSqlPassword;
  String? connectionSqlDatabase;
  int? insertUser;
  String? insertUserDescription;
  DateTime? insertDate;
  int? updateUser;
  String? updateUserDescription;
  DateTime? updateDate;

  ScaleDeviceModel({
    this.id,
    this.name,
    this.scaleType,
    this.scaleStatus,
    this.baitDistrubitonId,
    this.canBlend,
    this.canDistribution,
    this.scaleConnectionType,
    this.connectionIp,
    this.connectionPort,
    this.connectionXmlUrl,
    this.connectionSqlHostName,
    this.connectionSqlUserName,
    this.connectionSqlPassword,
    this.connectionSqlDatabase,
    this.insertUser,
    this.insertUserDescription,
    this.insertDate,
    this.updateUser,
    this.updateUserDescription,
    this.updateDate,
  });

  factory ScaleDeviceModel.fromJson(Map<String, dynamic> json) => _$ScaleDeviceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScaleDeviceModelToJson(this);
}

enum ScaleType
{
  FeedMixingScale,
  AnimalScale
}

enum ScaleStatus
{
  Ready,
  InUse
}

enum ScaleConnectionType
{
  Port,
  XmlUrl,
  Sql
}
