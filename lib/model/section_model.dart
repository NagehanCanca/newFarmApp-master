import 'package:json_annotation/json_annotation.dart';

part 'section_model.g.dart';

@JsonSerializable()
class SectionModel {
  int? id;
  String? code;
  String? description;
  bool? isActive;
  int? buildingId;
  String? buildingDescription;
  int? animalCount;
  int? illAnimalCount;
  int? trackingAnimalCount;
  int? infectiousAnimalCount;

  SectionModel({
    this.id,
    this.code,
    this.description,
    this.isActive,
    this.buildingId,
    this.buildingDescription,
    this.animalCount,
    this.illAnimalCount,
    this.trackingAnimalCount,
    this.infectiousAnimalCount,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) => _$SectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SectionModelToJson(this);
}
