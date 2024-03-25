import 'package:json_annotation/json_annotation.dart';

part 'all_vaccination_model.g.dart';

@JsonSerializable()
class AllVaccinationModel {
  int? id;
  int? productId;
  String? productBarcode;
  String? productDescription;
  double? quantity;
  int? unitId;
  String? unitCode;
  String? unitDescription;
  int? day;
  String? insertUser;
  DateTime? insertDate;
  String? updateUser;
  DateTime? updateDate;

  AllVaccinationModel({
    this.id,
    this.productId,
    this.productBarcode,
    this.productDescription,
    this.quantity,
    this.unitId,
    this.unitCode,
    this.unitDescription,
    this.day,
    this.insertUser,
    this.insertDate,
    this.updateUser,
    this.updateDate,
  });

  factory AllVaccinationModel.fromJson(Map<String, dynamic> json) => _$AllVaccinationModelFromJson(json);

  Map<String, dynamic> toJson() => _$AllVaccinationModelToJson(this);
}
