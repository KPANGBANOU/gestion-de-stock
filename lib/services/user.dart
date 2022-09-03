import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: non_constant_identifier_names, camel_case_types, unnecessary_this

class donnesUtilisateur {
  final String? nom;
  final String? prenom;
  final String? email;
  final String? telephone;
  final String? role;
  final String? sexe;
  final String? date_naissance;

  final bool? admin;
  final bool? is_active;
  donnesUtilisateur({
    this.nom,
    this.prenom,
    this.email,
    this.telephone,
    this.role,
    this.sexe,
    this.date_naissance,
    this.admin,
    this.is_active,
  });

  factory donnesUtilisateur.fromFiresotre(DocumentSnapshot snap) {
    return donnesUtilisateur(
        nom: (snap.data() as Map<String, dynamic>)["nom"] ?? "",
        prenom: (snap.data() as Map<String, dynamic>)['prenom'],
        email: (snap.data() as Map<String, dynamic>)['emai'],
        telephone: (snap.data() as Map<String, dynamic>)['telephone'],
        role: (snap.data() as Map<String, dynamic>)['role'],
        sexe: (snap.data() as Map<String, dynamic>)['sexe'],
        date_naissance: (snap.data() as Map<String, dynamic>)['date_naissance'],
        admin: (snap.data() as Map<String, dynamic>)['admin'],
        is_active: (snap.data() as Map<String, dynamic>)['is_active']);
  }

  donnesUtilisateur copyWith({
    String? nom,
    String? prenom,
    String? email,
    String? telephone,
    String? role,
    String? sexe,
    String? date_naissance,
    bool? admin,
    bool? is_active,
  }) {
    return donnesUtilisateur(
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
      email: email ?? this.email,
      telephone: telephone ?? this.telephone,
      role: role ?? this.role,
      sexe: sexe ?? this.sexe,
      date_naissance: date_naissance ?? this.date_naissance,
      admin: admin ?? this.admin,
      is_active: is_active ?? this.is_active,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'telephone': telephone,
      'role': role,
      'sexe': sexe,
      'date_naissance': date_naissance,
      'admin': admin,
      'is_active': is_active,
    };
  }

  factory donnesUtilisateur.fromMap(Map<String, dynamic> map) {
    return donnesUtilisateur(
      nom: map['nom'],
      prenom: map['prenom'],
      email: map['email'],
      telephone: map['telephone'],
      role: map['role'],
      sexe: map['sexe'],
      date_naissance: map['date_naissance'],
      admin: map['admin'],
      is_active: map['is_active'],
    );
  }

  String toJson() => json.encode(toMap());

  factory donnesUtilisateur.fromJson(String source) =>
      donnesUtilisateur.fromMap(json.decode(source));

  @override
  String toString() {
    return 'donnesUtilisateur(nom: $nom, prenom: $prenom, email: $email, telephone: $telephone, role: $role, sexe: $sexe, date_naissance: $date_naissance, admin: $admin, is_active: $is_active)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is donnesUtilisateur &&
        other.nom == nom &&
        other.prenom == prenom &&
        other.email == email &&
        other.telephone == telephone &&
        other.role == role &&
        other.sexe == sexe &&
        other.date_naissance == date_naissance &&
        other.admin == admin &&
        other.is_active == is_active;
  }

  @override
  int get hashCode {
    return nom.hashCode ^
        prenom.hashCode ^
        email.hashCode ^
        telephone.hashCode ^
        role.hashCode ^
        sexe.hashCode ^
        date_naissance.hashCode ^
        admin.hashCode ^
        is_active.hashCode;
  }
}

class Utilisateur {
  final String uid;
  Utilisateur({
    required this.uid,
  });
}
