// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

// ignore_for_file: camel_case_types

class venteteeshirts {
  final String uid;
  final int quantite;
  final int montant;
  final String nom_tee_shirts;
  final String qualite;
  final int benefice;
  final String date_vente;
  final String date_vente_day;
  final String date_vente_month;
  venteteeshirts({
    required this.uid,
    required this.quantite,
    required this.montant,
    required this.nom_tee_shirts,
    required this.qualite,
    required this.benefice,
    required this.date_vente,
    required this.date_vente_day,
    required this.date_vente_month,
  });

  factory venteteeshirts.fromfirestore(DocumentSnapshot document) {
    return venteteeshirts(
      benefice: (document.data() as Map)['benefice'],
      date_vente: DateFormat('yyyy-MM-dd')
          .format((document.data() as Map)['derniere_vente']),
      date_vente_day:
          DateFormat('dd').format((document.data() as Map)['derniere_vente']),
      date_vente_month:
          DateFormat('MM').format((document.data() as Map)['derniere_vente']),
      uid: document.id,
      quantite: (document.data() as Map)['quantite'],
      montant: (document.data() as Map)['montant'],
      nom_tee_shirts:
          (document.data() as Map<String, dynamic>)['nom_tee_shirt'],
      qualite: (document.data() as Map<String, dynamic>)['qualite'],
    );
  }

  venteteeshirts copyWith({
    String? uid,
    int? quantite,
    int? montant,
    String? nom_tee_shirts,
    String? qualite,
    int? benefice,
    String? date_vente,
    String? date_vente_day,
    String? date_vente_month,
  }) {
    return venteteeshirts(
      uid: uid ?? this.uid,
      quantite: quantite ?? this.quantite,
      montant: montant ?? this.montant,
      nom_tee_shirts: nom_tee_shirts ?? this.nom_tee_shirts,
      qualite: qualite ?? this.qualite,
      benefice: benefice ?? this.benefice,
      date_vente: date_vente ?? this.date_vente,
      date_vente_day: date_vente_day ?? this.date_vente_day,
      date_vente_month: date_vente_month ?? this.date_vente_month,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'quantite': quantite});
    result.addAll({'montant': montant});
    result.addAll({'nom_tee_shirts': nom_tee_shirts});
    result.addAll({'qualite': qualite});
    result.addAll({'benefice': benefice});
    result.addAll({'date_vente': date_vente});
    result.addAll({'date_vente_day': date_vente_day});
    result.addAll({'date_vente_month': date_vente_month});

    return result;
  }

  factory venteteeshirts.fromMap(Map<String, dynamic> map) {
    return venteteeshirts(
      uid: map['uid'] ?? '',
      quantite: map['quantite']?.toInt() ?? 0,
      montant: map['montant']?.toInt() ?? 0,
      nom_tee_shirts: map['nom_tee_shirts'] ?? '',
      qualite: map['qualite'] ?? '',
      benefice: map['benefice']?.toInt() ?? 0,
      date_vente: map['date_vente'] ?? '',
      date_vente_day: map['date_vente_day'] ?? '',
      date_vente_month: map['date_vente_month'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory venteteeshirts.fromJson(String source) =>
      venteteeshirts.fromMap(json.decode(source));

  @override
  String toString() {
    return 'venteteeshirts(uid: $uid, quantite: $quantite, montant: $montant, nom_tee_shirts: $nom_tee_shirts, qualite: $qualite, benefice: $benefice, date_vente: $date_vente, date_vente_day: $date_vente_day, date_vente_month: $date_vente_month)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is venteteeshirts &&
        other.uid == uid &&
        other.quantite == quantite &&
        other.montant == montant &&
        other.nom_tee_shirts == nom_tee_shirts &&
        other.qualite == qualite &&
        other.benefice == benefice &&
        other.date_vente == date_vente &&
        other.date_vente_day == date_vente_day &&
        other.date_vente_month == date_vente_month;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        quantite.hashCode ^
        montant.hashCode ^
        nom_tee_shirts.hashCode ^
        qualite.hashCode ^
        benefice.hashCode ^
        date_vente.hashCode ^
        date_vente_day.hashCode ^
        date_vente_month.hashCode;
  }
}
