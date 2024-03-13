// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreatmentModel _$TreatmentModelFromJson(Map<String, dynamic> json) =>
    TreatmentModel(
      id: json['id'] as int,
      treatmentStatus:
          $enumDecode(_$TreatmentStatusEnumMap, json['treatmentStatus']),
      animalID: json['animalID'] as int,
      animalEarringNumber: json['animalEarringNumber'] ?? '',
      paddockName: json['paddockName'] as String,
      date: DateTime.parse(json['date'] as String),
      diseaseDiagnoseId: json['diseaseDiagnoseId'] as int,
      diseaseDiagnoseDescription: json['diseaseDiagnoseDescription'] ?? '',
      notes: json['notes'] ?? '',
      endUserId: json['endUserId'] as int?,
      endUserDescription: json['endUserDescription'] as String?,
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      treatmentEndType: $enumDecodeNullable(
          _$TreatmentEndTypeEnumMap, json['treatmentEndType']),
      treatmentEndMessage: json['treatmentEndMessage'] ?? '',
      insertUser: json['insertUser'] as int,
      insertUserDescription: json['insertUserDescription'] as String,
      insertDate: json['insertDate'] == null
          ? null
          : DateTime.parse(json['insertDate'] as String),
      updateUser: json['updateUser'] as int?,
      updateUserDescription: json['updateUserDescription'] as String?,
      updateDate: json['updateDate'] == null
          ? null
          : DateTime.parse(json['updateDate'] as String),
    );

Map<String, dynamic> _$TreatmentModelToJson(TreatmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'treatmentStatus': _$TreatmentStatusEnumMap[instance.treatmentStatus]!,
      'animalID': instance.animalID,
      'animalEarringNumber': instance.animalEarringNumber,
      'paddockName': instance.paddockName,
      'date': instance.date.toIso8601String(),
      'diseaseDiagnoseId': instance.diseaseDiagnoseId,
      'diseaseDiagnoseDescription': instance.diseaseDiagnoseDescription,
      'notes': instance.notes,
      'endUserId': instance.endUserId,
      'endUserDescription': instance.endUserDescription,
      'endDate': instance.endDate?.toIso8601String(),
      'treatmentEndType': _$TreatmentEndTypeEnumMap[instance.treatmentEndType],
      'treatmentEndMessage': instance.treatmentEndMessage,
      'insertUser': instance.insertUser,
      'insertUserDescription': instance.insertUserDescription,
      'insertDate': instance.insertDate?.toIso8601String(),
      'updateUser': instance.updateUser,
      'updateUserDescription': instance.updateUserDescription,
      'updateDate': instance.updateDate?.toIso8601String(),
    };

const _$TreatmentStatusEnumMap = {
  TreatmentStatus.NewTreatment: 0,
  TreatmentStatus.EndedTreatment: 1,
};

const _$TreatmentEndTypeEnumMap = {
  TreatmentEndType.Cured: 0,
  TreatmentEndType.ToFollow: 1,
  TreatmentEndType.Ex: 2,
};
