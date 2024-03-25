// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_vaccination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllVaccinationModel _$AllVaccinationModelFromJson(Map<String, dynamic> json) {
  return AllVaccinationModel(
    id: json['id'] as int?,
    productId: json['productId'] as int?,
    productBarcode: json['productBarcode'] as String?,
    productDescription: json['productDescription'] as String?,
    quantity: (json['quantity'] as num?)?.toDouble(),
    unitId: json['unitId'] as int?,
    unitCode: json['unitCode'] as String?,
    unitDescription: json['unitDescription'] as String?,
    day: json['day'] as int?,
    insertUser: json['insertUser'] as String?,
    insertDate: json['insertDate'] == null
        ? null
        : DateTime.parse(json['insertDate'] as String),
    updateUser: json['updateUser'] as String?,
    updateDate: json['updateDate'] == null
        ? null
        : DateTime.parse(json['updateDate'] as String),
  );
}

Map<String, dynamic> _$AllVaccinationModelToJson(
    AllVaccinationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'productBarcode': instance.productBarcode,
      'productDescription': instance.productDescription,
      'quantity': instance.quantity,
      'unitId': instance.unitId,
      'unitCode': instance.unitCode,
      'unitDescription': instance.unitDescription,
      'day': instance.day,
      'insertUser': instance.insertUser,
      'insertDate': instance.insertDate?.toIso8601String(),
      'updateUser': instance.updateUser,
      'updateDate': instance.updateDate?.toIso8601String(),
    };
