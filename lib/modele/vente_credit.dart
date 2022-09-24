// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: camel_case_types

class venteCredit {
  final String uid;
  final String nom;
  final int montant;
  final String derniere_vente;
  venteCredit({
    required this.uid,
    required this.nom,
    required this.montant,
    required this.derniere_vente,
  });

  factory venteCredit.fromFirestore(DocumentSnapshot snap) {
    return venteCredit(
        uid: snap.id,
        nom: (snap.data() as Map<String, dynamic>)['nom_reseau'],
        montant: (snap.data() as Map)['montant'],
        derniere_vente: (snap.data() as Map)['date_dernierre_vente']);
  }

  venteCredit copyWith({
    String? uid,
    String? nom,
    int? montant,
    String? derniere_vente,
  }) {
    return venteCredit(
      uid: uid ?? this.uid,
      nom: nom ?? this.nom,
      montant: montant ?? this.montant,
      derniere_vente: derniere_vente ?? this.derniere_vente,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'nom': nom});
    result.addAll({'montant': montant});
    result.addAll({'derniere_vente': derniere_vente});

    return result;
  }

  factory venteCredit.fromMap(Map<String, dynamic> map) {
    return venteCredit(
      uid: map['uid'] ?? '',
      nom: map['nom'] ?? '',
      montant: map['montant']?.toInt() ?? 0,
      derniere_vente: map['derniere_vente'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory venteCredit.fromJson(String source) =>
      venteCredit.fromMap(json.decode(source));

  @override
  String toString() {
    return 'venteCredit(uid: $uid, nom: $nom, montant: $montant, derniere_vente: $derniere_vente)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is venteCredit &&
        other.uid == uid &&
        other.nom == nom &&
        other.montant == montant &&
        other.derniere_vente == derniere_vente;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        nom.hashCode ^
        montant.hashCode ^
        derniere_vente.hashCode;
  }
}
