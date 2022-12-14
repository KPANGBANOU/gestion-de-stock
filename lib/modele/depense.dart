import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

// ignore_for_file: non_constant_identifier_names, camel_case_types

class donnesDepense {
  final String uid;
  final String description;
  final int montant;
  final String date;
  final String user_nom;
  final String user_prenom;
  final String user_uid;
  donnesDepense({
    required this.uid,
    required this.description,
    required this.montant,
    required this.date,
    required this.user_nom,
    required this.user_prenom,
    required this.user_uid,
  });

  factory donnesDepense.fromFirestore(DocumentSnapshot document) {
    return donnesDepense(
        user_uid: (document.data() as Map<String, dynamic>)['user_uid'],
        date: DateFormat('yyyy-MM-dd')
            .format((document.data() as Map)['created_at']),
        user_nom: (document.data() as Map<String, dynamic>)['user_nom'],
        user_prenom: (document.data() as Map<String, dynamic>)['user_prenom'],
        uid: document.id,
        description: (document.data() as Map<String, dynamic>)['description'],
        montant: (document.data() as Map)['montant']);
  }

  donnesDepense copyWith({
    String? uid,
    String? description,
    int? montant,
    String? date,
    String? user_nom,
    String? user_prenom,
    String? user_uid,
  }) {
    return donnesDepense(
      uid: uid ?? this.uid,
      description: description ?? this.description,
      montant: montant ?? this.montant,
      date: date ?? this.date,
      user_nom: user_nom ?? this.user_nom,
      user_prenom: user_prenom ?? this.user_prenom,
      user_uid: user_uid ?? this.user_uid,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'description': description});
    result.addAll({'montant': montant});
    result.addAll({'date': date});
    result.addAll({'user_nom': user_nom});
    result.addAll({'user_prenom': user_prenom});
    result.addAll({'user_uid': user_uid});

    return result;
  }

  factory donnesDepense.fromMap(Map<String, dynamic> map) {
    return donnesDepense(
      uid: map['uid'] ?? '',
      description: map['description'] ?? '',
      montant: map['montant']?.toInt() ?? 0,
      date: map['date'] ?? '',
      user_nom: map['user_nom'] ?? '',
      user_prenom: map['user_prenom'] ?? '',
      user_uid: map['user_uid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory donnesDepense.fromJson(String source) =>
      donnesDepense.fromMap(json.decode(source));

  @override
  String toString() {
    return 'donnesDepense(uid: $uid, description: $description, montant: $montant, date: $date, user_nom: $user_nom, user_prenom: $user_prenom, user_uid: $user_uid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is donnesDepense &&
        other.uid == uid &&
        other.description == description &&
        other.montant == montant &&
        other.date == date &&
        other.user_nom == user_nom &&
        other.user_prenom == user_prenom &&
        other.user_uid == user_uid;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        description.hashCode ^
        montant.hashCode ^
        date.hashCode ^
        user_nom.hashCode ^
        user_prenom.hashCode ^
        user_uid.hashCode;
  }
}
