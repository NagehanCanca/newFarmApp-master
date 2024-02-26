import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class UserModel {
  @HiveField(0)
  int? id;
  int? insertUser;
  String? insertDate;
  int? updateUser;
  String? updateDate;
  @HiveField(1)
  String? username;
  @HiveField(2)
  String? email;
  String? password;
  @HiveField(3)
  String? firstName;
  @HiveField(4)
  String? lastName;

  UserModel(
      {this.id,
        this.insertUser,
        this.insertDate,
        this.updateUser,
        this.updateDate,
        this.username,
        this.email,
        this.password,
        this.firstName,
        this.lastName});

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
