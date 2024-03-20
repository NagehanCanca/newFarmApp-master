import 'package:json_annotation/json_annotation.dart';

part 'product_unit_model.g.dart';

@JsonSerializable()
class ProductUnitModel {
  int id;
  int producId;
  int unitId;
  String code;
  String description;
  double quantity;
  bool isMain;
  String insertUser;
  DateTime? insertDate;
  String updateUser;
  DateTime? updateDate;

  ProductUnitModel({
    required this.id,
    required this.producId,
    required this.unitId,
    required this.code,
    required this.description,
    required this.quantity,
    required this.isMain,
    required this.insertUser,
    required this.insertDate,
    required this.updateUser,
    required this.updateDate,
  });

  factory ProductUnitModel.fromJson(Map<String, dynamic> json) =>
      _$ProductUnitModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductUnitModelToJson(this);
}
