import 'package:json_annotation/json_annotation.dart';

part 'animal_race_model.g.dart';

@JsonSerializable()
class AnimalRaceModel {
  int? id;
  String? raceName;
  String? insertUser;
  DateTime? insertDate;
  String? updateUser;
  DateTime? updateDate;

  AnimalRaceModel({
    this.id,
    this.raceName,
    this.insertUser,
    this.insertDate,
    this.updateUser,
    this.updateDate,
  });

  factory AnimalRaceModel.fromJson(Map<String, dynamic> json) => _$AnimalRaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnimalRaceModelToJson(this);
}
