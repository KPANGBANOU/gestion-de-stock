// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: camel_case_types

class donnesBierresGrandModel {
  final int prix_unitaire;
  final int quantite_initial;
  final int uantite_physique;
  final int seuil_approvisionnement;
  final String nom;
  final String type;
  final String uid;
  donnesBierresGrandModel({
    required this.prix_unitaire,
    required this.quantite_initial,
    required this.uantite_physique,
    required this.seuil_approvisionnement,
    required this.nom,
    required this.type,
    required this.uid,
  });

  factory donnesBierresGrandModel.fromFirestore(DocumentSnapshot document) {
    return donnesBierresGrandModel(
        prix_unitaire:
            (document.data() as Map<String, dynamic>)['quantite_unitaire'],
        quantite_initial:
            (document.data() as Map<String, dynamic>)['quantite_initial'],
        uantite_physique:
            (document.data() as Map<String, dynamic>)['quantite_physique'],
        seuil_approvisionnement: (document.data()
            as Map<String, dynamic>)['seuil_approvisionnement'],
        nom: (document.data() as Map<String, dynamic>)['nom'],
        type: (document.data() as Map<String, dynamic>)['type'],
        uid: (document.id));
  }

  donnesBierresGrandModel copyWith({
    int? prix_unitaire,
    int? quantite_initial,
    int? uantite_physique,
    int? seuil_approvisionnement,
    String? nom,
    String? type,
    String? uid,
  }) {
    return donnesBierresGrandModel(
      prix_unitaire: prix_unitaire ?? this.prix_unitaire,
      quantite_initial: quantite_initial ?? this.quantite_initial,
      uantite_physique: uantite_physique ?? this.uantite_physique,
      seuil_approvisionnement:
          seuil_approvisionnement ?? this.seuil_approvisionnement,
      nom: nom ?? this.nom,
      type: type ?? this.type,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'prix_unitaire': prix_unitaire,
      'quantite_initial': quantite_initial,
      'uantite_physique': uantite_physique,
      'seuil_approvisionnement': seuil_approvisionnement,
      'nom': nom,
      'type': type,
      'uid': uid,
    };
  }

  factory donnesBierresGrandModel.fromMap(Map<String, dynamic> map) {
    return donnesBierresGrandModel(
      prix_unitaire: map['prix_unitaire']?.toInt() ?? 0,
      quantite_initial: map['quantite_initial']?.toInt() ?? 0,
      uantite_physique: map['uantite_physique']?.toInt() ?? 0,
      seuil_approvisionnement: map['seuil_approvisionnement']?.toInt() ?? 0,
      nom: map['nom'] ?? '',
      type: map['type'] ?? '',
      uid: map['uid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory donnesBierresGrandModel.fromJson(String source) =>
      donnesBierresGrandModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'donnesBierresGrandModel(prix_unitaire: $prix_unitaire, quantite_initial: $quantite_initial, uantite_physique: $uantite_physique, seuil_approvisionnement: $seuil_approvisionnement, nom: $nom, type: $type, uid: $uid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is donnesBierresGrandModel &&
        other.prix_unitaire == prix_unitaire &&
        other.quantite_initial == quantite_initial &&
        other.uantite_physique == uantite_physique &&
        other.seuil_approvisionnement == seuil_approvisionnement &&
        other.nom == nom &&
        other.type == type &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return prix_unitaire.hashCode ^
        quantite_initial.hashCode ^
        uantite_physique.hashCode ^
        seuil_approvisionnement.hashCode ^
        nom.hashCode ^
        type.hashCode ^
        uid.hashCode;
  }
}
