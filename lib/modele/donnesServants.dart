// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: camel_case_types

class donnesServants {
  final String? nom;
  final String? prenom;
  final String? email;
  final String? telephone;
  final String? role;
  final String? sexe;
  final String? date_naissance;
  final String uid;

  final bool? admin;
  final bool? is_active;
  donnesServants({
    this.nom,
    this.prenom,
    this.email,
    this.telephone,
    this.role,
    this.sexe,
    this.date_naissance,
    required this.uid,
    this.admin,
    this.is_active,
  });

  factory donnesServants.fromFiresotre(DocumentSnapshot snap) {
    return donnesServants(
        uid: snap.id,
        nom: (snap.data() as Map<String, dynamic>)["nom"] ?? "",
        prenom: (snap.data() as Map<String, dynamic>)['prenom'],
        email: (snap.data() as Map<String, dynamic>)['email'],
        telephone: (snap.data() as Map<String, dynamic>)['telephone'],
        role: (snap.data() as Map<String, dynamic>)['role'],
        sexe: (snap.data() as Map<String, dynamic>)['sexe'],
        date_naissance: (snap.data() as Map<String, dynamic>)['date_naissance'],
        admin: (snap.data() as Map<String, dynamic>)['admin'],
        is_active: (snap.data() as Map<String, dynamic>)['is_active']);
  }

  donnesServants copyWith({
    String? nom,
    String? prenom,
    String? email,
    String? telephone,
    String? role,
    String? sexe,
    String? date_naissance,
    String? uid,
    bool? admin,
    bool? is_active,
  }) {
    return donnesServants(
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
      email: email ?? this.email,
      telephone: telephone ?? this.telephone,
      role: role ?? this.role,
      sexe: sexe ?? this.sexe,
      date_naissance: date_naissance ?? this.date_naissance,
      uid: uid ?? this.uid,
      admin: admin ?? this.admin,
      is_active: is_active ?? this.is_active,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (nom != null) {
      result.addAll({'nom': nom});
    }
    if (prenom != null) {
      result.addAll({'prenom': prenom});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (telephone != null) {
      result.addAll({'telephone': telephone});
    }
    if (role != null) {
      result.addAll({'role': role});
    }
    if (sexe != null) {
      result.addAll({'sexe': sexe});
    }
    if (date_naissance != null) {
      result.addAll({'date_naissance': date_naissance});
    }
    result.addAll({'uid': uid});
    if (admin != null) {
      result.addAll({'admin': admin});
    }
    if (is_active != null) {
      result.addAll({'is_active': is_active});
    }

    return result;
  }

  factory donnesServants.fromMap(Map<String, dynamic> map) {
    return donnesServants(
      nom: map['nom'],
      prenom: map['prenom'],
      email: map['email'],
      telephone: map['telephone'],
      role: map['role'],
      sexe: map['sexe'],
      date_naissance: map['date_naissance'],
      uid: map['uid'] ?? '',
      admin: map['admin'],
      is_active: map['is_active'],
    );
  }

  String toJson() => json.encode(toMap());

  factory donnesServants.fromJson(String source) =>
      donnesServants.fromMap(json.decode(source));

  @override
  String toString() {
    return 'donnesServants(nom: $nom, prenom: $prenom, email: $email, telephone: $telephone, role: $role, sexe: $sexe, date_naissance: $date_naissance, uid: $uid, admin: $admin, is_active: $is_active)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is donnesServants &&
        other.nom == nom &&
        other.prenom == prenom &&
        other.email == email &&
        other.telephone == telephone &&
        other.role == role &&
        other.sexe == sexe &&
        other.date_naissance == date_naissance &&
        other.uid == uid &&
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
        uid.hashCode ^
        admin.hashCode ^
        is_active.hashCode;
  }
}
