import 'package:json_annotation/json_annotation.dart';

part 'paddock_model.g.dart';

@JsonSerializable()
class PaddockModel {
  int? id;
  String? code;
  String? description;
  PaddockType? paddockType;
  bool? isActive;
  int? buildingId;
  String? buildingDescription;
  int? sectionId;
  String? sectionDescription;
  int? animalCount;
  int? illAnimalCount;
  int? trackingAnimalCount;
  int? infectiousAnimalCount;

  PaddockModel({
    this.id,
    this.code,
    this.description,
    this.paddockType,
    this.isActive,
    this.buildingId,
    this.buildingDescription,
    this.sectionId,
    this.sectionDescription,
    this.animalCount,
    this.illAnimalCount,
    this.trackingAnimalCount,
    this.infectiousAnimalCount,
  });

  factory PaddockModel.fromJson(Map<String, dynamic> json) => _$PaddockModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaddockModelToJson(this);
}

enum PaddockType {
  Normal,
  Infirmary,
}
