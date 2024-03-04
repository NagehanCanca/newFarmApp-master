import 'package:json_annotation/json_annotation.dart';

part 'transfer_model.g.dart';

@JsonSerializable()
class TransferModel {
  final int id;
  final int animalId;
  final int? oldPaddockId;
  final String? oldPaddock;
  final int? oldSectionId;
  final String? oldSection;
  final int? oldBuildingId;
  final String? oldBuilding;
  final int newPaddockId;
  final String newPaddock;
  final int newSectionId;
  final String newSection;
  final int newBuildingId;
  final String newBuilding;
  final DateTime? date;
  final String insertUser;
  final DateTime insertDate;
  final String? updateUser;
  final DateTime? updateDate;

  TransferModel({
    required this.id,
    required this.animalId,
    this.oldPaddockId,
    this.oldPaddock,
    this.oldSectionId,
    this.oldSection,
    this.oldBuildingId,
    this.oldBuilding,
    required this.newPaddockId,
    required this.newPaddock,
    required this.newSectionId,
    required this.newSection,
    required this.newBuildingId,
    required this.newBuilding,
    required this.date,
    required this.insertUser,
    required this.insertDate,
    required this.updateUser,
    this.updateDate,
  });
  String oldPaddockString(){
    String mesaj ="";
    if(oldBuilding != '') {
      mesaj += oldBuilding?.replaceAll('. BİNA', '') ?? '';
      mesaj += '-';
      mesaj += oldSection?.replaceAll('. Bölüm', '') ?? '';
      mesaj += '-';
      mesaj += oldPaddock?.replaceAll('. Padok', '') ?? '';
    }
    return mesaj;
}
  String newPaddockString(){
    String mesaj ="";
    if(newBuilding != null) {
      mesaj += newBuilding?.replaceAll('. BİNA', '') ?? '';
      mesaj += '-';
      mesaj += newSection?.replaceAll('. Bölüm', '') ?? '';
      mesaj += '-';
      mesaj += newPaddock!.replaceAll('. Padok', '');
    }
    return mesaj;
  }
  factory TransferModel.fromJson(Map<String, dynamic> json) =>
      _$TransferModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransferModelToJson(this);
}
