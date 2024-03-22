import 'package:json_annotation/json_annotation.dart';

part 'product_unit_model.g.dart';

@JsonSerializable()
class ProductUnitModel {
  int? id;
  int producId;
  int unitId;
  String? code;
  String? description;
  double quantity;
  bool? isMain;
  String insertUser;
  DateTime? insertDate;
  String? updateUser;
  DateTime? updateDate;

  ProductUnitModel({
    this.id,
    required this.producId,
    required this.unitId,
    this.code,
    this.description,
    required this.quantity,
    this.isMain,
    required this.insertUser,
    this.insertDate,
    this.updateUser,
    this.updateDate,
  });

  factory ProductUnitModel.fromJson(Map<String, dynamic> json) =>
      _$ProductUnitModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductUnitModelToJson(this);
}
