import 'package:json_annotation/json_annotation.dart';

part 'treatment_model.g.dart';

@JsonSerializable()
class TreatmentModel {
  int id;
  TreatmentStatus treatmentStatus;
  int animalID;
  String? animalEarringNumber;
  String? paddockName;
  DateTime date;
  int diseaseDiagnoseId;
  String? diseaseDiagnoseDescription;
  String? notes;
  int? endUserId;
  String? endUserDescription;
  DateTime? endDate;
  TreatmentEndType? treatmentEndType;
  String? treatmentEndMessage;
  int insertUser;
  String? insertUserDescription;
  DateTime? insertDate;
  int? updateUser;
  String? updateUserDescription;
  DateTime? updateDate;

  TreatmentModel({
    required this.id,
    required this.treatmentStatus,
    required this.animalID,
    this.animalEarringNumber,
    this.paddockName,
    required this.date,
    required this.diseaseDiagnoseId,
    this.diseaseDiagnoseDescription,
    this.notes,
    this.endUserId,
    this.endUserDescription,
    this.endDate,
    this.treatmentEndType,
    this.treatmentEndMessage,
    required this.insertUser,
    this.insertUserDescription,
    this.insertDate,
    this.updateUser,
    this.updateUserDescription,
    this.updateDate,
  });

  factory TreatmentModel.fromJson(Map<String, dynamic> json) => _$TreatmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$TreatmentModelToJson(this);
}

enum TreatmentEndType {
  Cured,
  ToFollow,
  Ex,
}
enum TreatmentStatus {
  NewTreatment,
  EndedTreatment,
  Finished,
}
