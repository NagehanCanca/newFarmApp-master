import 'package:json_annotation/json_annotation.dart';

part 'bait_distrubition_model.g.dart';

@JsonSerializable()
class BaitDistributionModel {
  int? id;
  int? baitId;
  String? baitDescription;
  int? baitAnimalCount;
  int? baitAppliedAnimalCount;
  int? baitScaleCount;
  bool? baitDontPremix;
  BaitDistributionStatus? baitDistributionStatus;
  DateTime? baitDistributionDate;
  int? scaleDeviceId;
  String? scaleDeviceDescription;
  int? blendUserId;
  String? blendUserDescription;
  DateTime? blendDate;
  int? distributionUserId;
  String? distributionUserDescription;
  DateTime? distributionDate;
  int? insertUser;
  String? insertUserDescription;
  DateTime? insertDate;
  int? updateUser;
  String? updateUserDescription;
  DateTime? updateDate;

  BaitDistributionModel({
    this.id,
    this.baitId,
    this.baitDescription,
    this.baitAnimalCount,
    this.baitAppliedAnimalCount,
    this.baitScaleCount,
    this.baitDontPremix,
    this.baitDistributionStatus,
    this.baitDistributionDate,
    this.scaleDeviceId,
    this.scaleDeviceDescription,
    this.blendUserId,
    this.blendUserDescription,
    this.blendDate,
    this.distributionUserId,
    this.distributionUserDescription,
    this.distributionDate,
    this.insertUser,
    this.insertUserDescription,
    this.insertDate,
    this.updateUser,
    this.updateUserDescription,
    this.updateDate,
  });

  factory BaitDistributionModel.fromJson(Map<String, dynamic> json) => _$BaitDistributionModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaitDistributionModelToJson(this);
}

enum BaitDistributionStatus {
  New,
  Blending,
  Ready,
  Distributed
}
