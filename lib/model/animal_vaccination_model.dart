import 'package:json_annotation/json_annotation.dart';

part 'animal_vaccination_model.g.dart';

@JsonSerializable()
class AnimalVaccinationModel {
  int? id;
  int? animalId;
  int? productId;
  String? productBarcode;
  String? productDescription;
  int? unitId;
  String? unitCode;
  String? unitDescription;
  double? quantity;
  AnimalVaccinationStatus? animalVaccinationStatus;
  DateTime? applicationDay;
  String? insertUser;
  DateTime? insertDate;
  String? updateUser;
  DateTime? updateDate;

  AnimalVaccinationModel({
    this.id,
    this.animalId,
    this.productId,
    this.productBarcode,
    this.productDescription,
    this.unitId,
    this.unitCode,
    this.unitDescription,
    this.quantity,
    this.animalVaccinationStatus,
    this.applicationDay,
    this.insertUser,
    this.insertDate,
    this.updateUser,
    this.updateDate,
  });

  factory AnimalVaccinationModel.fromJson(Map<String, dynamic> json) => _$AnimalVaccinationModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnimalVaccinationModelToJson(this);
}

enum AnimalVaccinationStatus {
  NotApplied,
  Applied,
}
