// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(1)
  String? id;
  @HiveField(2)
  String? fullname;
  @HiveField(3)
  String? phoneNumber;
  @HiveField(4)
  String? adresseuser;
  @HiveField(5)
  String? datenaissance;
  @HiveField(6)
  String? lieunaissance;
  @HiveField(7)
  String? email;
  @HiveField(8)
  String? statut;
  @HiveField(9)
  String? niveau;
  @HiveField(10)
  String? password;
  @HiveField(11)
  int? v;
  @HiveField(12)
  String? idSociete;

  UserModel({
    this.id,
    this.fullname,
    this.phoneNumber,
    this.adresseuser,
    this.datenaissance,
    this.lieunaissance,
    this.email,
    this.statut,
    this.niveau,
    this.password,
    this.v,
    this.idSociete,
  });

  factory UserModel.fromJSON(Map json) => UserModel(
    id: json["_id"],
    fullname: json["fullname"],
    phoneNumber: json["phoneNumber"],
    adresseuser: json["adresseuser"],
    datenaissance: json["datenaissance"],
    lieunaissance: json["lieunaissance"],
    email: json["email"],
    statut: json["statut"],
    niveau: json["niveau"],
    password: json["password"],
    v: json["__v"],
    idSociete: json["id_societe"],
  );

  Map<String, dynamic> toJSON() => {
    "_id": id,
    "fullname": fullname,
    "phoneNumber": phoneNumber,
    "adresseuser": adresseuser,
    "datenaissance": datenaissance,
    "lieunaissance": lieunaissance,
    "email": email,
    "statut": statut,
    "niveau": niveau,
    "password": password,
    "__v": v,
    "id_societe": idSociete,
  };
}

class AuthModel {
  UserModel user;
  String? token;
  AuthModel({required this.user, this.token});

  static fromJSON(json) {
    return AuthModel(user: UserModel.fromJSON(json), token: json['token']);
  }

  toJSON() {
    return {...user.toJSON(), 'token': token};
  }
}
