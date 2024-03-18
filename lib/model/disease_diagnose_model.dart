import 'package:json_annotation/json_annotation.dart';

part 'disease_diagnose_model.g.dart';

@JsonSerializable()
class DiseaseDiagnoseModel {
  int id;
  String code;
  String name;
  bool isInfectious;
  int insertUser;
  DateTime? insertDate;
  int? updateUser;
  DateTime? updateDate;

  DiseaseDiagnoseModel({
    required this.id,
    required this.code,
    required this.name,
    required this.isInfectious,
    required this.insertUser,
    this.insertDate,
    this.updateUser,
    this.updateDate,
  });

  factory DiseaseDiagnoseModel.fromJson(Map<String, dynamic> json) => _$DiseaseDiagnoseModelFromJson(json);

  Map<String, dynamic> toJson() => _$DiseaseDiagnoseModelToJson(this);
}
