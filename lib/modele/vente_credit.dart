// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

// ignore_for_file: camel_case_types

class venteCredit {
  final String uid;
  final String nom;
  final int montant;
  final String date_vente_day;
  final String date_vente_month;
  final String date_vente;
  final int benefice;
  venteCredit({
    required this.uid,
    required this.nom,
    required this.montant,
    required this.date_vente_day,
    required this.date_vente_month,
    required this.date_vente,
    required this.benefice,
  });

  factory venteCredit.fromFirestore(DocumentSnapshot snap) {
    return venteCredit(
      benefice: (snap.data() as Map)['benefice'],
      date_vente_day:
          DateFormat('dd').format((snap.data() as Map)['derniere_vente']),
      date_vente_month:
          DateFormat('MM').format((snap.data() as Map)['derniere_vente']),
      date_vente: DateFormat('yyyy-MM-dd')
          .format((snap.data() as Map)['derniere_vente']),
      uid: snap.id,
      nom: (snap.data() as Map<String, dynamic>)['nom'],
      montant: (snap.data() as Map)['montant'],
    );
  }

  venteCredit copyWith({
    String? uid,
    String? nom,
    int? montant,
    String? date_vente_day,
    String? date_vente_month,
    String? date_vente,
    int? benefice,
  }) {
    return venteCredit(
      uid: uid ?? this.uid,
      nom: nom ?? this.nom,
      montant: montant ?? this.montant,
      date_vente_day: date_vente_day ?? this.date_vente_day,
      date_vente_month: date_vente_month ?? this.date_vente_month,
      date_vente: date_vente ?? this.date_vente,
      benefice: benefice ?? this.benefice,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'nom': nom});
    result.addAll({'montant': montant});
    result.addAll({'date_vente_day': date_vente_day});
    result.addAll({'date_vente_month': date_vente_month});
    result.addAll({'date_vente': date_vente});
    result.addAll({'benefice': benefice});

    return result;
  }

  factory venteCredit.fromMap(Map<String, dynamic> map) {
    return venteCredit(
      uid: map['uid'] ?? '',
      nom: map['nom'] ?? '',
      montant: map['montant']?.toInt() ?? 0,
      date_vente_day: map['date_vente_day'] ?? '',
      date_vente_month: map['date_vente_month'] ?? '',
      date_vente: map['date_vente'] ?? '',
      benefice: map['benefice']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory venteCredit.fromJson(String source) =>
      venteCredit.fromMap(json.decode(source));

  @override
  String toString() {
    return 'venteCredit(uid: $uid, nom: $nom, montant: $montant, date_vente_day: $date_vente_day, date_vente_month: $date_vente_month, date_vente: $date_vente, benefice: $benefice)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is venteCredit &&
        other.uid == uid &&
        other.nom == nom &&
        other.montant == montant &&
        other.date_vente_day == date_vente_day &&
        other.date_vente_month == date_vente_month &&
        other.date_vente == date_vente &&
        other.benefice == benefice;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        nom.hashCode ^
        montant.hashCode ^
        date_vente_day.hashCode ^
        date_vente_month.hashCode ^
        date_vente.hashCode ^
        benefice.hashCode;
  }
}
