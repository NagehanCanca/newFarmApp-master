// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_unit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductUnitModel _$ProductUnitModelFromJson(Map<String, dynamic> json) {
  return ProductUnitModel(
    id: json['id'] as int,
    producId: json['producId'] as int,
    unitId: json['unitId'] as int,
    code: json['code'] as String,
    description: json['description'] as String,
    quantity: (json['quantity'] as num).toDouble(),
    isMain: json['isMain'] as bool,
    insertUser: json['insertUser'] as String,
    insertDate: json['insertDate'] == null
        ? null
        : DateTime.parse(json['insertDate'] as String),
    updateUser: json['updateUser'] as String,
    updateDate: json['updateDate'] == null
        ? null
        : DateTime.parse(json['updateDate'] as String),
  );
}

Map<String, dynamic> _$ProductUnitModelToJson(ProductUnitModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'producId': instance.producId,
      'unitId': instance.unitId,
      'code': instance.code,
      'description': instance.description,
      'quantity': instance.quantity,
      'isMain': instance.isMain,
      'insertUser': instance.insertUser,
      'insertDate': instance.insertDate?.toIso8601String(),
      'updateUser': instance.updateUser,
      'updateDate': instance.updateDate?.toIso8601String(),
    };
