import 'package:json_annotation/json_annotation.dart';

part 'animal_model.g.dart';

@JsonSerializable()
class AnimalModel {
  int? id;
  int? animalBuyingDetailId;
  AnimalStatus? animalStatus;
  String? rfid;
  String? earringNumber;
  int? animalTypeId;
  String? animalTypeDescription;
  AnimalGender? animalGender;
  DateTime? birthDate;
  int? buildId;
  String? buildDescription;
  int? sectionId;
  String? sectionDescription;
  int? paddockId;
  String? paddockDescription;
  bool? isInfectious;
  bool? isTracking;
  int? trackingUserId;
  String? trackingUser;
  String? origin;
  String? image;
  DateTime? farmInsertDate;
  int? animalRaceId;
  DateTime? exDate;
  String? insertUser;
  DateTime? insertDate;
  String? updateUser;
  DateTime? updateDate;

  AnimalModel({
    this.id,
    this.animalBuyingDetailId,
    this.animalStatus,
    this.rfid,
    this.earringNumber,
    this.animalTypeId,
    this.animalTypeDescription,
    this.animalGender,
    this.birthDate,
    this.buildId,
    this.buildDescription,
    this.sectionId,
    this.sectionDescription,
    this.paddockId,
    this.paddockDescription,
    this.isInfectious,
    this.isTracking,
    this.trackingUserId,
    this.trackingUser,
    this.origin,
    this.image,
    this.farmInsertDate,
    this.animalRaceId,
    this.exDate,
    this.insertUser,
    this.insertDate,
    this.updateUser,
    this.updateDate,
  });

  factory AnimalModel.fromJson(Map<String, dynamic> json) => _$AnimalModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnimalModelToJson(this);
}

enum AnimalStatus {
  Normal,
  Ill,
  Ex,
  Sold,
}

enum AnimalGender {
  Feminine,
  Masculine,
}
