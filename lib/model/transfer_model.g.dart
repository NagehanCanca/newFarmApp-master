// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferModel _$TransferModelFromJson(Map<String, dynamic> json) =>
    TransferModel(
      id: json['id'] as int,
      animalId: json['animalId'] as int,
      oldPaddockId: json['oldPaddockId'] as int?,
      oldPaddock: json['oldPaddock'] as String,
      oldSectionId: json['oldSectionId'] as int?,
      oldSection: json['oldSection'] as String,
      oldBuildingId: json['oldBuildingId'] as int?,
      oldBuilding: json['oldBuilding'] as String,
      newPaddockId: json['newPaddockId'] as int,
      newPaddock: json['newPaddock'] as String,
      newSectionId: json['newSectionId'] as int?,
      newSection: json['newSection'] as String?,
      newBuildingId: json['newBuildingId'] as int?,
      newBuilding: json['newBuilding'] as String?,
      date: DateTime.parse(json['date'] as String),
      insertUser: json['insertUser'] as String,
      insertDate: json['insertDate'] == null
          ? null
          : DateTime.parse(json['insertDate'] as String),
      updateUser: json['updateUser'] as String,
      updateDate: json['updateDate'] == null
          ? null
          : DateTime.parse(json['updateDate'] as String),
    );

Map<String, dynamic> _$TransferModelToJson(TransferModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'animalId': instance.animalId,
      'oldPaddockId': instance.oldPaddockId,
      'oldPaddock': instance.oldPaddock,
      'oldSectionId': instance.oldSectionId,
      'oldSection': instance.oldSection,
      'oldBuildingId': instance.oldBuildingId,
      'oldBuilding': instance.oldBuilding,
      'newPaddockId': instance.newPaddockId,
      'newPaddock': instance.newPaddock,
      'newSectionId': instance.newSectionId,
      'newSection': instance.newSection,
      'newBuildingId': instance.newBuildingId,
      'newBuilding': instance.newBuilding,
      'date': instance.date?.toIso8601String(),
      'insertUser': instance.insertUser,
      'insertDate': instance.insertDate?.toIso8601String(),
      'updateUser': instance.updateUser,
      'updateDate': instance.updateDate?.toIso8601String(),
    };
