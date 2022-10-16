// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

// ignore_for_file: camel_case_types

class centreVenteProduit {
  final String uid;
  final String nom_produit;
  final int quantite;
  final int montant;
  final int benefice;
  final String date_vente;
  final String vente_day;
  final String vente_month;
  centreVenteProduit({
    required this.uid,
    required this.nom_produit,
    required this.quantite,
    required this.montant,
    required this.benefice,
    required this.date_vente,
    required this.vente_day,
    required this.vente_month,
  });

  factory centreVenteProduit.fromfirestore(DocumentSnapshot doc) {
    return centreVenteProduit(
        benefice: (doc.data() as Map)['benefice'],
        date_vente: DateFormat('yyyy-MM-dd')
            .format((doc.data() as Map)['derniere_vente']),
        vente_day:
            DateFormat('dd').format((doc.data() as Map)['derniere_vente']),
        vente_month:
            DateFormat('MM').format((doc.data() as Map)['derniere_vente']),
        uid: doc.id,
        nom_produit: (doc.data() as Map<String, dynamic>)['nom'],
        quantite: (doc.data() as Map)['quantite'],
        montant: (doc.data() as Map)['montant']);
  }

  centreVenteProduit copyWith({
    String? uid,
    String? nom_produit,
    int? quantite,
    int? montant,
    int? benefice,
    String? date_vente,
    String? vente_day,
    String? vente_month,
  }) {
    return centreVenteProduit(
      uid: uid ?? this.uid,
      nom_produit: nom_produit ?? this.nom_produit,
      quantite: quantite ?? this.quantite,
      montant: montant ?? this.montant,
      benefice: benefice ?? this.benefice,
      date_vente: date_vente ?? this.date_vente,
      vente_day: vente_day ?? this.vente_day,
      vente_month: vente_month ?? this.vente_month,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'nom_produit': nom_produit});
    result.addAll({'quantite': quantite});
    result.addAll({'montant': montant});
    result.addAll({'benefice': benefice});
    result.addAll({'date_vente': date_vente});
    result.addAll({'vente_day': vente_day});
    result.addAll({'vente_month': vente_month});

    return result;
  }

  factory centreVenteProduit.fromMap(Map<String, dynamic> map) {
    return centreVenteProduit(
      uid: map['uid'] ?? '',
      nom_produit: map['nom_produit'] ?? '',
      quantite: map['quantite']?.toInt() ?? 0,
      montant: map['montant']?.toInt() ?? 0,
      benefice: map['benefice']?.toInt() ?? 0,
      date_vente: map['date_vente'] ?? '',
      vente_day: map['vente_day'] ?? '',
      vente_month: map['vente_month'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory centreVenteProduit.fromJson(String source) =>
      centreVenteProduit.fromMap(json.decode(source));

  @override
  String toString() {
    return 'centreVenteProduit(uid: $uid, nom_produit: $nom_produit, quantite: $quantite, montant: $montant, benefice: $benefice, date_vente: $date_vente, vente_day: $vente_day, vente_month: $vente_month)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is centreVenteProduit &&
        other.uid == uid &&
        other.nom_produit == nom_produit &&
        other.quantite == quantite &&
        other.montant == montant &&
        other.benefice == benefice &&
        other.date_vente == date_vente &&
        other.vente_day == vente_day &&
        other.vente_month == vente_month;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        nom_produit.hashCode ^
        quantite.hashCode ^
        montant.hashCode ^
        benefice.hashCode ^
        date_vente.hashCode ^
        vente_day.hashCode ^
        vente_month.hashCode;
  }
}
