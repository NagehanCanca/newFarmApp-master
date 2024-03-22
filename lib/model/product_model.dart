import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  int id;
  int productGroupId;
  String productGroupDescription;
  int productUnitId;
  String productUnitDescription;
  String code;
  String barcode;
  String description;
  double minimumQuantity;
  double maximumQuantity;
  bool isStock;
  bool isActive;
  String? image;
  int insertUser;
  String insertUserDescription;
  DateTime? insertDate;
  int updateUser;
  String updateUserDescription;
  DateTime? updateDate;

  ProductModel({
    required this.id,
    required this.productGroupId,
    required this.productGroupDescription,
    required this.productUnitId,
    required this.productUnitDescription,
    required this.code,
    required this.barcode,
    required this.description,
    required this.minimumQuantity,
    required this.maximumQuantity,
    required this.isStock,
    required this.isActive,
    required this.image,
    required this.insertUser,
    required this.insertUserDescription,
    required this.insertDate,
    required this.updateUser,
    required this.updateUserDescription,
    required this.updateDate,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
