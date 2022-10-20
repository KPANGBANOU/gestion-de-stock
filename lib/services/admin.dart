// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Admin {
  final String nom;
  final String prenom;
  final String email;
  final String telephone;
  final String role;
  final String sexe;
  final String date_naissance;
  final String uid;
  final String domaine;
  final String photo_url;
  final bool admin;
  final bool is_active;
  final String mdp;
  final String email_reception_rapport;
  final String numero_watsapp_reception_message;
  Admin({
    required this.nom,
    required this.prenom,
    required this.email,
    required this.telephone,
    required this.role,
    required this.sexe,
    required this.date_naissance,
    required this.uid,
    required this.domaine,
    required this.photo_url,
    required this.admin,
    required this.is_active,
    required this.mdp,
    required this.email_reception_rapport,
    required this.numero_watsapp_reception_message,
  });

  factory Admin.fromFirestore(DocumentSnapshot snap) {
    return Admin(
        mdp: (snap.data() as Map<String, dynamic>)['mdp'],
        email_reception_rapport:
            (snap.data() as Map<String, dynamic>)['email_reception_rapport'],
        numero_watsapp_reception_message: (snap.data()
            as Map<String, dynamic>)['numero_watsapp_reception_rapport'],
        nom: (snap.data() as Map<String, dynamic>)["nom"],
        prenom: (snap.data() as Map<String, dynamic>)["prenom"],
        email: (snap.data() as Map<String, dynamic>)["email"],
        telephone: (snap.data() as Map<String, dynamic>)["telephone"],
        role: (snap.data() as Map<String, dynamic>)["role"],
        sexe: (snap.data() as Map<String, dynamic>)["sexe"],
        date_naissance: (snap.data() as Map<String, dynamic>)["date_naissance"],
        uid: snap.id,
        domaine: (snap.data() as Map<String, dynamic>)["domaine"],
        photo_url: (snap.data() as Map<String, dynamic>)["photo_url"],
        admin: (snap.data() as Map)["admin"],
        is_active: (snap.data() as Map)["is_active"]);
  }

  Admin copyWith({
    String? nom,
    String? prenom,
    String? email,
    String? telephone,
    String? role,
    String? sexe,
    String? date_naissance,
    String? uid,
    String? domaine,
    String? photo_url,
    bool? admin,
    bool? is_active,
    String? mdp,
    String? email_reception_rapport,
    String? numero_watsapp_reception_message,
  }) {
    return Admin(
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
      email: email ?? this.email,
      telephone: telephone ?? this.telephone,
      role: role ?? this.role,
      sexe: sexe ?? this.sexe,
      date_naissance: date_naissance ?? this.date_naissance,
      uid: uid ?? this.uid,
      domaine: domaine ?? this.domaine,
      photo_url: photo_url ?? this.photo_url,
      admin: admin ?? this.admin,
      is_active: is_active ?? this.is_active,
      mdp: mdp ?? this.mdp,
      email_reception_rapport:
          email_reception_rapport ?? this.email_reception_rapport,
      numero_watsapp_reception_message: numero_watsapp_reception_message ??
          this.numero_watsapp_reception_message,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'nom': nom});
    result.addAll({'prenom': prenom});
    result.addAll({'email': email});
    result.addAll({'telephone': telephone});
    result.addAll({'role': role});
    result.addAll({'sexe': sexe});
    result.addAll({'date_naissance': date_naissance});
    result.addAll({'uid': uid});
    result.addAll({'domaine': domaine});
    result.addAll({'photo_url': photo_url});
    result.addAll({'admin': admin});
    result.addAll({'is_active': is_active});
    result.addAll({'mdp': mdp});
    result.addAll({'email_reception_rapport': email_reception_rapport});
    result.addAll(
        {'numero_watsapp_reception_message': numero_watsapp_reception_message});

    return result;
  }

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      nom: map['nom'] ?? '',
      prenom: map['prenom'] ?? '',
      email: map['email'] ?? '',
      telephone: map['telephone'] ?? '',
      role: map['role'] ?? '',
      sexe: map['sexe'] ?? '',
      date_naissance: map['date_naissance'] ?? '',
      uid: map['uid'] ?? '',
      domaine: map['domaine'] ?? '',
      photo_url: map['photo_url'] ?? '',
      admin: map['admin'] ?? false,
      is_active: map['is_active'] ?? false,
      mdp: map['mdp'] ?? '',
      email_reception_rapport: map['email_reception_rapport'] ?? '',
      numero_watsapp_reception_message:
          map['numero_watsapp_reception_message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Admin.fromJson(String source) => Admin.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Admin(nom: $nom, prenom: $prenom, email: $email, telephone: $telephone, role: $role, sexe: $sexe, date_naissance: $date_naissance, uid: $uid, domaine: $domaine, photo_url: $photo_url, admin: $admin, is_active: $is_active, mdp: $mdp, email_reception_rapport: $email_reception_rapport, numero_watsapp_reception_message: $numero_watsapp_reception_message)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Admin &&
        other.nom == nom &&
        other.prenom == prenom &&
        other.email == email &&
        other.telephone == telephone &&
        other.role == role &&
        other.sexe == sexe &&
        other.date_naissance == date_naissance &&
        other.uid == uid &&
        other.domaine == domaine &&
        other.photo_url == photo_url &&
        other.admin == admin &&
        other.is_active == is_active &&
        other.mdp == mdp &&
        other.email_reception_rapport == email_reception_rapport &&
        other.numero_watsapp_reception_message ==
            numero_watsapp_reception_message;
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
        domaine.hashCode ^
        photo_url.hashCode ^
        admin.hashCode ^
        is_active.hashCode ^
        mdp.hashCode ^
        email_reception_rapport.hashCode ^
        numero_watsapp_reception_message.hashCode;
  }
}
