// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment_note_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreatmentNoteModel _$TreatmentNoteModelFromJson(Map<String, dynamic> json) =>
    TreatmentNoteModel(
      id: json['id'] as int?,
      treatmentId: json['treatmentId'] as int,
      date: DateTime.parse(json['date'] as String),
      notes: json['notes'] as String,
      insertUser: json['insertUser'] as int,
      insertUserDescription: json['insertUserDescription'] as String?,
      insertDate: json['insertDate'] == null
          ? null
          : DateTime.parse(json['insertDate'] as String),
      updateUser: json['updateUser'] as int?,
      updateUserDescription: json['updateUserDescription'] as String?,
      updateDate: json['updateDate'] == null
          ? null
          : DateTime.parse(json['updateDate'] as String),
    );

Map<String, dynamic> _$TreatmentNoteModelToJson(TreatmentNoteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'treatmentId': instance.treatmentId,
      'date': instance.date.toIso8601String(),
      'notes': instance.notes,
      'insertUser': instance.insertUser,
      'insertUserDescription': instance.insertUserDescription,
      'insertDate': instance.insertDate?.toIso8601String(),
      'updateUser': instance.updateUser,
      'updateUserDescription': instance.updateUserDescription,
      'updateDate': instance.updateDate?.toIso8601String(),
    };
