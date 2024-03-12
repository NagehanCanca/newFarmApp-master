import 'package:json_annotation/json_annotation.dart';

part 'animal_report_model.g.dart';

@JsonSerializable()
class AnimalReportModel {
  int? id;
  int? animalId;
  AnimalReportStatus? animalReportStatus;
  DateTime? date;
  String? description;
  int? acceptUser;
  String? acceptUserDescription;
  DateTime? acceptDate;
  String? earringNumber;
  String? rfId;
  AnimalGender? animalGender;
  String? buildDescription;
  String? sectionDescription;
  String? paddockDescription;
  bool? isInfectious;
  bool? isTracking;
  String? trackingUser;
  String? origin;
  DateTime? farmInsertDate;
  String? animalRaceDescription;
  int? insertUser;
  String? insertUserDescription;
  DateTime? insertDate;
  int? updateUser;
  String? updateUserDescription;
  DateTime? updateDate;

  AnimalReportModel({
    this.id,
    this.animalId,
    this.animalReportStatus,
    this.date,
    this.description,
    this.acceptUser,
    this.acceptUserDescription,
    this.acceptDate,
    this.earringNumber,
    this.rfId,
    this.animalGender,
    this.buildDescription,
    this.sectionDescription,
    this.paddockDescription,
    this.isInfectious,
    this.isTracking,
    this.trackingUser,
    this.origin,
    this.farmInsertDate,
    this.animalRaceDescription,
    this.insertUser,
    this.insertUserDescription,
    this.insertDate,
    this.updateUser,
    this.updateUserDescription,
    this.updateDate,
  });

  factory AnimalReportModel.fromJson(Map<String, dynamic> json) =>
      _$AnimalReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnimalReportModelToJson(this);
}

enum AnimalReportStatus {
  NewReport,
  AcceptedReport,
}

enum AnimalGender {
  Feminine,
  Masculine,
}