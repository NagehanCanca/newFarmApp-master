import 'package:json_annotation/json_annotation.dart';

part 'treatment_product_model.g.dart';

@JsonSerializable()
class TreatmentProductModel {
  int? id;
  int? treatmentId;
  int? animalId;
  int? productId;
  String? productDescription;
  int? unitId;
  double? quantity;
  int? insertUser;
  String? insertUserDescription;
  DateTime? insertDate;
  int? updateUser;
  String? updateUserDescription;
  DateTime? updateDate;

  TreatmentProductModel({
    this.id,
    this.treatmentId,
    this.animalId,
    this.productId,
    this.productDescription,
    this.unitId,
    this.quantity,
    this.insertUser,
    this.insertUserDescription,
    this.insertDate,
    this.updateUser,
    this.updateUserDescription,
    this.updateDate,
  });

  factory TreatmentProductModel.fromJson(Map<String, dynamic> json) =>
      _$TreatmentProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$TreatmentProductModelToJson(this);
}
