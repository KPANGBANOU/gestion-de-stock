// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: camel_case_types

class products {
  final int prix_unitaire;
  final int quantite_initial;
  final int quantite_physique;
  final int seuil_approvisionnement;
  final String nom;
  final String uid;
  final int benefice;
  final int prix_unitaire_achat;
  final int montant_vendu;
  products({
    required this.prix_unitaire,
    required this.quantite_initial,
    required this.quantite_physique,
    required this.seuil_approvisionnement,
    required this.nom,
    required this.uid,
    required this.benefice,
    required this.prix_unitaire_achat,
    required this.montant_vendu,
  });

  factory products.fromFirestore(DocumentSnapshot document) {
    return products(
        montant_vendu: (document.data() as Map)['montant_vendu'],
        benefice: (document.data() as Map)['benefice'],
        prix_unitaire_achat: (document.data() as Map)['prix_unitaire_achat'],
        prix_unitaire: (document.data() as Map)['prix_unitaire'],
        quantite_initial: (document.data() as Map)['quantite_initial'],
        quantite_physique: (document.data() as Map)['quantite_physique'],
        seuil_approvisionnement:
            (document.data() as Map)['seuil_approvisionnement'],
        nom: (document.data() as Map<String, dynamic>)['nom'],
        uid: (document.id));
  }

  products copyWith({
    int? prix_unitaire,
    int? quantite_initial,
    int? quantite_physique,
    int? seuil_approvisionnement,
    String? nom,
    String? uid,
    int? benefice,
    int? prix_unitaire_achat,
    int? montant_vendu,
  }) {
    return products(
      prix_unitaire: prix_unitaire ?? this.prix_unitaire,
      quantite_initial: quantite_initial ?? this.quantite_initial,
      quantite_physique: quantite_physique ?? this.quantite_physique,
      seuil_approvisionnement:
          seuil_approvisionnement ?? this.seuil_approvisionnement,
      nom: nom ?? this.nom,
      uid: uid ?? this.uid,
      benefice: benefice ?? this.benefice,
      prix_unitaire_achat: prix_unitaire_achat ?? this.prix_unitaire_achat,
      montant_vendu: montant_vendu ?? this.montant_vendu,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'prix_unitaire': prix_unitaire});
    result.addAll({'quantite_initial': quantite_initial});
    result.addAll({'quantite_physique': quantite_physique});
    result.addAll({'seuil_approvisionnement': seuil_approvisionnement});
    result.addAll({'nom': nom});
    result.addAll({'uid': uid});
    result.addAll({'benefice': benefice});
    result.addAll({'prix_unitaire_achat': prix_unitaire_achat});
    result.addAll({'montant_vendu': montant_vendu});

    return result;
  }

  factory products.fromMap(Map<String, dynamic> map) {
    return products(
      prix_unitaire: map['prix_unitaire']?.toInt() ?? 0,
      quantite_initial: map['quantite_initial']?.toInt() ?? 0,
      quantite_physique: map['quantite_physique']?.toInt() ?? 0,
      seuil_approvisionnement: map['seuil_approvisionnement']?.toInt() ?? 0,
      nom: map['nom'] ?? '',
      uid: map['uid'] ?? '',
      benefice: map['benefice']?.toInt() ?? 0,
      prix_unitaire_achat: map['prix_unitaire_achat']?.toInt() ?? 0,
      montant_vendu: map['montant_vendu']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory products.fromJson(String source) =>
      products.fromMap(json.decode(source));

  @override
  String toString() {
    return 'products(prix_unitaire: $prix_unitaire, quantite_initial: $quantite_initial, quantite_physique: $quantite_physique, seuil_approvisionnement: $seuil_approvisionnement, nom: $nom, uid: $uid, benefice: $benefice, prix_unitaire_achat: $prix_unitaire_achat, montant_vendu: $montant_vendu)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is products &&
        other.prix_unitaire == prix_unitaire &&
        other.quantite_initial == quantite_initial &&
        other.quantite_physique == quantite_physique &&
        other.seuil_approvisionnement == seuil_approvisionnement &&
        other.nom == nom &&
        other.uid == uid &&
        other.benefice == benefice &&
        other.prix_unitaire_achat == prix_unitaire_achat &&
        other.montant_vendu == montant_vendu;
  }

  @override
  int get hashCode {
    return prix_unitaire.hashCode ^
        quantite_initial.hashCode ^
        quantite_physique.hashCode ^
        seuil_approvisionnement.hashCode ^
        nom.hashCode ^
        uid.hashCode ^
        benefice.hashCode ^
        prix_unitaire_achat.hashCode ^
        montant_vendu.hashCode;
  }
}
