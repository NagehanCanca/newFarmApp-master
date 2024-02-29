import 'package:json_annotation/json_annotation.dart';

part 'building_model.g.dart';

@JsonSerializable()
class BuildingModel {
  int? id;
  String? code;
  String? description;
  bool? isActive;
  int? animalCount;
  int? illAnimalCount;
  int? trackingAnimalCount;
  int? infectiousAnimalCount;

  BuildingModel({
    this.id,
    this.code,
    this.description,
    this.isActive,
    this.animalCount,
    this.illAnimalCount,
    this.trackingAnimalCount,
    this.infectiousAnimalCount,
  });

  factory BuildingModel.fromJson(Map<String, dynamic> json) => _$BuildingModelFromJson(json);

  Map<String, dynamic> toJson() => _$BuildingModelToJson(this);
}
