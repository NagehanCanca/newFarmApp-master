import 'package:json_annotation/json_annotation.dart';

part 'treatment_product_model.g.dart';

@JsonSerializable()
class TreatmentProductModel {
  int id;
  int treatmentId;
  int animalId;
  int productId;
  String productDescription;
  int unitId;
  double quantity;
  int insertUser;
  String insertUserDescription;
  DateTime insertDate;
  int updateUser;
  String updateUserDescription;
  DateTime? updateDate;

  TreatmentProductModel({
    required this.id,
    required this.treatmentId,
    required this.animalId,
    required this.productId,
    required this.productDescription,
    required this.unitId,
    required this.quantity,
    required this.insertUser,
    required this.insertUserDescription,
    required this.insertDate,
    required this.updateUser,
    required this.updateUserDescription,
    this.updateDate,
  });

  factory TreatmentProductModel.fromJson(Map<String, dynamic> json) =>
      _$TreatmentProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$TreatmentProductModelToJson(this);
}
