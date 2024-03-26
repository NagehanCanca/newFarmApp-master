// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bait_distrubition_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaitDistributionProductModel _$BaitDistributionProductModelFromJson(Map<String, dynamic> json) {
  return BaitDistributionProductModel(
    id: json['id'] as int,
    baitID: json['baitID'] as int,
    baitDistributionId: json['baitDistributionId'] as int,
    orderBy: json['orderBy'] as int,
    productID: json['productID'] as int,
    productName: json['productName'] as String,
    quantity: (json['quantity'] as num).toDouble(),
    totalQuantity: (json['totalQuantity'] as num).toDouble(),
    appliedTotalQuantity: (json['appliedTotalQuantity'] as num).toDouble(),
    loadUserID: json['loadUserID'] as int?,
    loadDate: json['loadDate'] == null
        ? null
        : DateTime.parse(json['loadDate'] as String),
    isManuel: json['isManuel'] as bool,
    insertUser: json['insertUser'] as int,
    insertUserDescription: json['insertUserDescription'] as String,
    insertDate: json['insertDate'] == null
        ? null
        : DateTime.parse(json['insertDate'] as String),
    updateUser: json['updateUser'] as int,
    updateUserDescription: json['updateUserDescription'] as String,
    updateDate: json['updateDate'] == null
        ? null
        : DateTime.parse(json['updateDate'] as String),
  );
}

Map<String, dynamic> _$BaitDistributionProductModelToJson(BaitDistributionProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'baitID': instance.baitID,
      'baitDistributionId': instance.baitDistributionId,
      'orderBy': instance.orderBy,
      'productID': instance.productID,
      'productName': instance.productName,
      'quantity': instance.quantity,
      'totalQuantity': instance.totalQuantity,
      'appliedTotalQuantity': instance.appliedTotalQuantity,
      'loadUserID': instance.loadUserID,
      'loadDate': instance.loadDate?.toIso8601String(),
      'isManuel': instance.isManuel,
      'insertUser': instance.insertUser,
      'insertUserDescription': instance.insertUserDescription,
      'insertDate': instance.insertDate?.toIso8601String(),
      'updateUser': instance.updateUser,
      'updateUserDescription': instance.updateUserDescription,
      'updateDate': instance.updateDate?.toIso8601String(),
    };
