import 'package:json_annotation/json_annotation.dart';

part 'animal_type_model.g.dart';

@JsonSerializable()
class AnimalTypeModel {
  int? id;
  String? description;
  int? insertUser;
  String? insertUserDescription;
  DateTime? insertDate;
  int? updateUser;
  String? updateUserDescription;
  DateTime? updateDate;

  AnimalTypeModel({
    this.id,
    this.description,
    this.insertUser,
    this.insertUserDescription,
    this.insertDate,
    this.updateUser,
    this.updateUserDescription,
    this.updateDate,
  });

  factory AnimalTypeModel.fromJson(Map<String, dynamic> json) {
    return AnimalTypeModel(
      id: json['id'],
      description: json['description'],
      insertUser: json['insertUser'],
      insertUserDescription: json['insertUserDescription'],
      insertDate: json['insertDate'] != null
          ? DateTime.parse(json['insertDate'])
          : null,
      updateUser: json['updateUser'],
      updateUserDescription: json['updateUserDescription'],
      updateDate: json['updateDate'] != null
          ? DateTime.parse(json['updateDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'insertUser': insertUser,
      'insertUserDescription': insertUserDescription,
      'insertDate': insertDate?.toIso8601String(),
      'updateUser': updateUser,
      'updateUserDescription' : updateUserDescription,
      'updateDate': updateDate?.toIso8601String(),
    };
  }

  @override
  int get hashCode => description.hashCode ^ id.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AnimalTypeModel &&
        other.description == description &&
        other.id == id;
  }
}
