import 'package:json_annotation/json_annotation.dart';

part 'animal_type_model.g.dart';

@JsonSerializable()
class AnimalTypeModel {
  int? id;
  String? description;
  String? insertUser;
  DateTime? insertDate;
  String? updateUser;
  DateTime? updateDate;

  AnimalTypeModel({
    this.id,
    this.description,
    this.insertUser,
    this.insertDate,
    this.updateUser,
    this.updateDate,
  });

  factory AnimalTypeModel.fromJson(Map<String, dynamic> json) => _$AnimalTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnimalTypeModelToJson(this);

  @override
  bool operator ==(Object other){
    if(identical(this,other))return true;
    return other is AnimalTypeModel && other.description == description && other.id == id;
  }
}
