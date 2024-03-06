// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_vaccination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalVaccinationModel _$AnimalVaccinationModelFromJson(
        Map<String, dynamic> json) =>
    AnimalVaccinationModel(
      id: json['id'] as int?,
      animalId: json['animalId'] as int?,
      productId: json['productId'] as int?,
      productBarcode: json['productBarcode'] as String?,
      productDescription: json['productDescription'] as String?,
      unitId: json['unitId'] as int?,
      unitCode: json['unitCode'] as String?,
      unitDescription: json['unitDescription'] as String?,
      quantity: (json['quantity'] as num?)?.toDouble(),
      animalVaccinationStatus: $enumDecodeNullable(
          _$AnimalVaccinationStatusEnumMap, json['animalVaccinationStatus']),
      applicationDay: json['applicationDay'] == null
          ? null
          : DateTime.parse(json['applicationDay'] as String),
      insertUser: json['insertUser'] as String?,
      insertDate: json['insertDate'] == null
          ? null
          : DateTime.parse(json['insertDate'] as String),
      updateUser: json['updateUser'] as String?,
      updateDate: json['updateDate'] == null
          ? null
          : DateTime.parse(json['updateDate'] as String),
    );

Map<String, dynamic> _$AnimalVaccinationModelToJson(
        AnimalVaccinationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'animalId': instance.animalId,
      'productId': instance.productId,
      'productBarcode': instance.productBarcode,
      'productDescription': instance.productDescription,
      'unitId': instance.unitId,
      'unitCode': instance.unitCode,
      'unitDescription': instance.unitDescription,
      'quantity': instance.quantity,
      'animalVaccinationStatus':
          _$AnimalVaccinationStatusEnumMap[instance.animalVaccinationStatus],
      'applicationDay': instance.applicationDay?.toIso8601String(),
      'insertUser': instance.insertUser,
      'insertDate': instance.insertDate?.toIso8601String(),
      'updateUser': instance.updateUser,
      'updateDate': instance.updateDate?.toIso8601String(),
    };

const _$AnimalVaccinationStatusEnumMap = {
  AnimalVaccinationStatus.NotApplied: 'NotApplied',
  AnimalVaccinationStatus.Applied: 'Applied',
};
