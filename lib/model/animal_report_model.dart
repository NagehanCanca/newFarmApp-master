import 'package:json_annotation/json_annotation.dart';

part 'animal_report_model.g.dart';

@JsonSerializable()
class AnimalReportModel {
  int? animalId;
  AnimalReportStatus? animalReportStatus;
  String? description;
  int? acceptUser;
  DateTime? date;
  DateTime? acceptDate;

  AnimalReportModel({
    this.animalId,
    this.animalReportStatus,
    this.description,
    this.acceptUser,
    this.date,
    this.acceptDate,
  });

  factory AnimalReportModel.fromJson(Map<String, dynamic> json) => _$AnimalReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnimalReportModelToJson(this);
}

enum AnimalReportStatus {
  NewReport,
  AcceptedReport,
}
