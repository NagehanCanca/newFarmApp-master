// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreatmentProductModel _$TreatmentProductModelFromJson(
        Map<String, dynamic> json) =>
    TreatmentProductModel(
      id: json['id'] as int,
      treatmentId: json['treatmentId'] as int,
      animalId: json['animalId'] as int,
      productId: json['productId'] as int,
      productDescription: json['productDescription'] as String,
      unitId: json['unitId'] as int,
      quantity: (json['quantity'] as num).toDouble(),
      insertUser: json['insertUser'] as int,
      insertUserDescription: json['insertUserDescription'] as String,
      insertDate: DateTime.parse(json['insertDate'] as String),
      updateUser: json['updateUser'] as int,
      updateUserDescription: json['updateUserDescription'] as String,
      updateDate: json['updateDate'] == null
          ? null
          : DateTime.parse(json['updateDate'] as String),
    );

Map<String, dynamic> _$TreatmentProductModelToJson(
        TreatmentProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'treatmentId': instance.treatmentId,
      'animalId': instance.animalId,
      'productId': instance.productId,
      'productDescription': instance.productDescription,
      'unitId': instance.unitId,
      'quantity': instance.quantity,
      'insertUser': instance.insertUser,
      'insertUserDescription': instance.insertUserDescription,
      'insertDate': instance.insertDate.toIso8601String(),
      'updateUser': instance.updateUser,
      'updateUserDescription': instance.updateUserDescription,
      'updateDate': instance.updateDate?.toIso8601String(),
    };
