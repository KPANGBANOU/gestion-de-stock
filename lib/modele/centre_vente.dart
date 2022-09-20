// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: camel_case_types

class centreVente {
  final String uid;
  final String nom_produit;
  final int quantite;
  final int montant;
  centreVente({
    required this.uid,
    required this.nom_produit,
    required this.quantite,
    required this.montant,
  });

  factory centreVente.fromfirestore(DocumentSnapshot doc) {
    return centreVente(
        uid: doc.id,
        nom_produit: (doc.data() as Map<String, dynamic>)['nom_produit'],
        quantite: (doc.data() as Map)['quantite'],
        montant: (doc.data() as Map)['montant']);
  }

  centreVente copyWith({
    String? uid,
    String? nom_produit,
    int? quantite,
    int? montant,
  }) {
    return centreVente(
      uid: uid ?? this.uid,
      nom_produit: nom_produit ?? this.nom_produit,
      quantite: quantite ?? this.quantite,
      montant: montant ?? this.montant,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'nom_produit': nom_produit});
    result.addAll({'quantite': quantite});
    result.addAll({'montant': montant});

    return result;
  }

  factory centreVente.fromMap(Map<String, dynamic> map) {
    return centreVente(
      uid: map['uid'] ?? '',
      nom_produit: map['nom_produit'] ?? '',
      quantite: map['quantite']?.toInt() ?? 0,
      montant: map['montant']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory centreVente.fromJson(String source) =>
      centreVente.fromMap(json.decode(source));

  @override
  String toString() {
    return 'centreVente(uid: $uid, nom_produit: $nom_produit, quantite: $quantite, montant: $montant)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is centreVente &&
        other.uid == uid &&
        other.nom_produit == nom_produit &&
        other.quantite == quantite &&
        other.montant == montant;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        nom_produit.hashCode ^
        quantite.hashCode ^
        montant.hashCode;
  }
}
