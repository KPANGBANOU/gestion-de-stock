// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

// ignore_for_file: camel_case_types

class venteGrandModele {
  final String uid;
  final int quantite;
  final int montant;
  final String nom_bierre;
  final String category;
  final int benefice;
  final String date_vente;
  final String date_vente_day;
  final String date_vente_month;
  venteGrandModele({
    required this.uid,
    required this.quantite,
    required this.montant,
    required this.nom_bierre,
    required this.category,
    required this.benefice,
    required this.date_vente,
    required this.date_vente_day,
    required this.date_vente_month,
  });

  factory venteGrandModele.fromFirestore(DocumentSnapshot document) {
    return venteGrandModele(
        benefice: (document.data() as Map)['benefice'],
        date_vente_day:
            DateFormat('dd').format((document.data() as Map)['derniere_vente']),
        date_vente_month:
            DateFormat('MM').format((document.data() as Map)['derniere_vente']),
        date_vente: DateFormat('yyyy-MM-dd')
            .format((document.data() as Map)['derniere_vente']),
        nom_bierre: (document.data() as Map)['nom_bierre'],
        category: (document.data() as Map)['type'],
        quantite: (document.data() as Map)['quantite'],
        montant: (document.data() as Map)['montant'],
        uid: document.id);
  }

  venteGrandModele copyWith({
    String? uid,
    int? quantite,
    int? montant,
    String? nom_bierre,
    String? category,
    int? benefice,
    String? date_vente,
    String? date_vente_day,
    String? date_vente_month,
  }) {
    return venteGrandModele(
      uid: uid ?? this.uid,
      quantite: quantite ?? this.quantite,
      montant: montant ?? this.montant,
      nom_bierre: nom_bierre ?? this.nom_bierre,
      category: category ?? this.category,
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
    result.addAll({'nom_bierre': nom_bierre});
    result.addAll({'category': category});
    result.addAll({'benefice': benefice});
    result.addAll({'date_vente': date_vente});
    result.addAll({'date_vente_day': date_vente_day});
    result.addAll({'date_vente_month': date_vente_month});

    return result;
  }

  factory venteGrandModele.fromMap(Map<String, dynamic> map) {
    return venteGrandModele(
      uid: map['uid'] ?? '',
      quantite: map['quantite']?.toInt() ?? 0,
      montant: map['montant']?.toInt() ?? 0,
      nom_bierre: map['nom_bierre'] ?? '',
      category: map['category'] ?? '',
      benefice: map['benefice']?.toInt() ?? 0,
      date_vente: map['date_vente'] ?? '',
      date_vente_day: map['date_vente_day'] ?? '',
      date_vente_month: map['date_vente_month'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory venteGrandModele.fromJson(String source) =>
      venteGrandModele.fromMap(json.decode(source));

  @override
  String toString() {
    return 'venteGrandModele(uid: $uid, quantite: $quantite, montant: $montant, nom_bierre: $nom_bierre, category: $category, benefice: $benefice, date_vente: $date_vente, date_vente_day: $date_vente_day, date_vente_month: $date_vente_month)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is venteGrandModele &&
        other.uid == uid &&
        other.quantite == quantite &&
        other.montant == montant &&
        other.nom_bierre == nom_bierre &&
        other.category == category &&
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
        nom_bierre.hashCode ^
        category.hashCode ^
        benefice.hashCode ^
        date_vente.hashCode ^
        date_vente_day.hashCode ^
        date_vente_month.hashCode;
  }
}
