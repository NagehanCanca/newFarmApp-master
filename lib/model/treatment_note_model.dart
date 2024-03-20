import 'package:json_annotation/json_annotation.dart';

part 'treatment_note_model.g.dart';

@JsonSerializable()
class TreatmentNoteModel {
  int? id;
  int treatmentId;
  DateTime date;
  String notes;
  int insertUser;
  String? insertUserDescription;
  DateTime? insertDate;
  int? updateUser;
  String? updateUserDescription;
  DateTime? updateDate;

  TreatmentNoteModel({
    this.id,
    required this.treatmentId,
    required this.date,
    required this.notes,
    required this.insertUser,
    this.insertUserDescription,
    this.insertDate,
    this.updateUser,
    this.updateUserDescription,
    this.updateDate,
  });

  factory TreatmentNoteModel.fromJson(Map<String, dynamic> json) =>
      _$TreatmentNoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$TreatmentNoteModelToJson(this);
}
