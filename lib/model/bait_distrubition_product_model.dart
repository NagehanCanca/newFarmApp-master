import 'package:json_annotation/json_annotation.dart';

part 'bait_distrubition_product_model.g.dart';

@JsonSerializable()
class BaitDistributionProductModel {
  int id;
  int baitID;
  int baitDistributionId;
  int orderBy;
  int productID;
  String productName;
  double quantity;
  double totalQuantity;
  double appliedTotalQuantity;
  int? loadUserID;
  DateTime? loadDate;
  bool isManuel;
  int insertUser;
  String insertUserDescription;
  DateTime? insertDate;
  int updateUser;
  String updateUserDescription;
  DateTime? updateDate;

  BaitDistributionProductModel({
    required this.id,
    required this.baitID,
    required this.baitDistributionId,
    required this.orderBy,
    required this.productID,
    required this.productName,
    required this.quantity,
    required this.totalQuantity,
    required this.appliedTotalQuantity,
    this.loadUserID,
    this.loadDate,
    required this.isManuel,
    required this.insertUser,
    required this.insertUserDescription,
    this.insertDate,
    required this.updateUser,
    required this.updateUserDescription,
    this.updateDate,
  });

  factory BaitDistributionProductModel.fromJson(Map<String, dynamic> json) => _$BaitDistributionProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaitDistributionProductModelToJson(this);
}
