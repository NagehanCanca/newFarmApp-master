import 'package:json_annotation/json_annotation.dart';

part 'bait_list_model.g.dart';

@JsonSerializable()
class BaitListModel {
  int? id;
  DateTime? date;
  BaitListStatus? baitListStatus;
  String? description;
  int? animalCount;
  int? appliedAnimalCount;
  int? scaleCount;
  double? elwg1;
  double? elwg2;
  double? elwg3;
  bool? dontPremix;
  int? copyBaitId;
  int? insertUser;
  String? insertUserDescription;
  DateTime? insertDate;
  int? updateUser;
  String? updateUserDescription;
  DateTime? updateDate;

  BaitListModel({
    this.id,
    this.date,
    this.baitListStatus,
    this.description,
    this.animalCount,
    this.appliedAnimalCount,
    this.scaleCount,
    this.elwg1,
    this.elwg2,
    this.elwg3,
    this.dontPremix,
    this.copyBaitId,
    this.insertUser,
    this.insertUserDescription,
    this.insertDate,
    this.updateUser,
    this.updateUserDescription,
    this.updateDate,
  });

  factory BaitListModel.fromJson(Map<String, dynamic> json) => _$BaitListModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaitListModelToJson(this);
}

enum BaitListStatus {
  Passive,
  Active,
  All,
}

