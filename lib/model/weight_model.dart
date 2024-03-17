import 'package:json_annotation/json_annotation.dart';

part 'weight_model.g.dart';

@JsonSerializable()
class WeightModel {
  int id;
  DateTime date;
  WeightStatus weightStatus;
  int paddockId;
  String paddockDescription;
  int sectionId;
  String sectionDescription;
  int buildingId;
  String buildingDescription;
  int scaleDeviceId;
  String scaleDeviceDescription;
  bool isNewAnimal;
  int insertUser;
  String insertUserDescription;
  DateTime? insertDate;
  int? updateUser;
  String? updateUserDescription;
  DateTime? updateDate;

  WeightModel({
    required this.id,
    required this.date,
    required this.weightStatus,
    required this.paddockId,
    required this.paddockDescription,
    required this.sectionId,
    required this.sectionDescription,
    required this.buildingId,
    required this.buildingDescription,
    required this.scaleDeviceId,
    required this.scaleDeviceDescription,
    required this.isNewAnimal,
    required this.insertUser,
    required this.insertUserDescription,
    required this.insertDate,
    required this.updateUser,
    required this.updateUserDescription,
    required this.updateDate,
  });

  factory WeightModel.fromJson(Map<String, dynamic> json) => _$WeightModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeightModelToJson(this);
}

enum WeightStatus {
  NewList,
  AcceptedList,
}
