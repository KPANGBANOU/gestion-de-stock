// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: camel_case_types

class produits {
  final String uid;
  final String nom;
  final int quantite_initial;
  final int quantite_physique;
  final int seuil_approvisionnement;
  final int prix_unitaire;
  produits({
    required this.uid,
    required this.nom,
    required this.quantite_initial,
    required this.quantite_physique,
    required this.seuil_approvisionnement,
    required this.prix_unitaire,
  });

  factory produits.fromfirestore(DocumentSnapshot document) {
    return produits(
        uid: document.id,
        nom: (document.data() as Map<String, dynamic>)['nom'],
        quantite_initial: (document.data() as Map)['quantite_initial'],
        quantite_physique: (document.data() as Map)['quantite_physique'],
        prix_unitaire: (document.data() as Map)['prix_unitaire'],
        seuil_approvisionnement:
            (document.data() as Map)['seuil_approvisionnement']);
  }

  produits copyWith({
    String? uid,
    String? nom,
    int? quantite_initial,
    int? quantite_physique,
    int? seuil_approvisionnement,
    int? prix_unitaire,
  }) {
    return produits(
      uid: uid ?? this.uid,
      nom: nom ?? this.nom,
      quantite_initial: quantite_initial ?? this.quantite_initial,
      quantite_physique: quantite_physique ?? this.quantite_physique,
      seuil_approvisionnement:
          seuil_approvisionnement ?? this.seuil_approvisionnement,
      prix_unitaire: prix_unitaire ?? this.prix_unitaire,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'nom': nom});
    result.addAll({'quantite_initial': quantite_initial});
    result.addAll({'quantite_physique': quantite_physique});
    result.addAll({'seuil_approvisionnement': seuil_approvisionnement});
    result.addAll({'prix_unitaire': prix_unitaire});

    return result;
  }

  factory produits.fromMap(Map<String, dynamic> map) {
    return produits(
      uid: map['uid'] ?? '',
      nom: map['nom'] ?? '',
      quantite_initial: map['quantite_initial']?.toInt() ?? 0,
      quantite_physique: map['quantite_physique']?.toInt() ?? 0,
      seuil_approvisionnement: map['seuil_approvisionnement']?.toInt() ?? 0,
      prix_unitaire: map['prix_unitaire']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory produits.fromJson(String source) =>
      produits.fromMap(json.decode(source));

  @override
  String toString() {
    return 'produits(uid: $uid, nom: $nom, quantite_initial: $quantite_initial, quantite_physique: $quantite_physique, seuil_approvisionnement: $seuil_approvisionnement, prix_unitaire: $prix_unitaire)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is produits &&
        other.uid == uid &&
        other.nom == nom &&
        other.quantite_initial == quantite_initial &&
        other.quantite_physique == quantite_physique &&
        other.seuil_approvisionnement == seuil_approvisionnement &&
        other.prix_unitaire == prix_unitaire;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        nom.hashCode ^
        quantite_initial.hashCode ^
        quantite_physique.hashCode ^
        seuil_approvisionnement.hashCode ^
        prix_unitaire.hashCode;
  }
}
