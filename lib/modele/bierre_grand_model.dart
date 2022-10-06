// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: camel_case_types

class donnesBierresGrandModel {
  final int prix_unitaire;
  final int quantite_initial;
  final int quantite_physique;
  final int seuil_approvisionnement;
  final String nom;
  final String type;
  final String uid;
  final int prix_unitaire_achat;
  final int benefice;
  final int montant_vendu;
  donnesBierresGrandModel({
    required this.prix_unitaire,
    required this.quantite_initial,
    required this.quantite_physique,
    required this.seuil_approvisionnement,
    required this.nom,
    required this.type,
    required this.uid,
    required this.prix_unitaire_achat,
    required this.benefice,
    required this.montant_vendu,
  });

  factory donnesBierresGrandModel.fromFirestore(DocumentSnapshot document) {
    return donnesBierresGrandModel(
        montant_vendu: (document.data() as Map)['montant_vendu'],
        benefice: (document.data() as Map)['benefice'],
        prix_unitaire_achat: (document.data() as Map)["prix_unitaire_achat"],
        prix_unitaire: (document.data() as Map)["prix_unitaire"],
        quantite_initial: (document.data() as Map)["quantite_initial"],
        quantite_physique: (document.data() as Map)["quantite_physique"],
        seuil_approvisionnement:
            (document.data() as Map)["seuil_approvisionnement"],
        nom: (document.data() as Map<String, dynamic>)["nom"],
        type: (document.data() as Map<String, dynamic>)["type"],
        uid: (document.id));
  }

  donnesBierresGrandModel copyWith({
    int? prix_unitaire,
    int? quantite_initial,
    int? quantite_physique,
    int? seuil_approvisionnement,
    String? nom,
    String? type,
    String? uid,
    int? prix_unitaire_achat,
    int? benefice,
    int? montant_vendu,
  }) {
    return donnesBierresGrandModel(
      prix_unitaire: prix_unitaire ?? this.prix_unitaire,
      quantite_initial: quantite_initial ?? this.quantite_initial,
      quantite_physique: quantite_physique ?? this.quantite_physique,
      seuil_approvisionnement:
          seuil_approvisionnement ?? this.seuil_approvisionnement,
      nom: nom ?? this.nom,
      type: type ?? this.type,
      uid: uid ?? this.uid,
      prix_unitaire_achat: prix_unitaire_achat ?? this.prix_unitaire_achat,
      benefice: benefice ?? this.benefice,
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
    result.addAll({'type': type});
    result.addAll({'uid': uid});
    result.addAll({'prix_unitaire_achat': prix_unitaire_achat});
    result.addAll({'benefice': benefice});
    result.addAll({'montant_vendu': montant_vendu});

    return result;
  }

  factory donnesBierresGrandModel.fromMap(Map<String, dynamic> map) {
    return donnesBierresGrandModel(
      prix_unitaire: map['prix_unitaire']?.toInt() ?? 0,
      quantite_initial: map['quantite_initial']?.toInt() ?? 0,
      quantite_physique: map['quantite_physique']?.toInt() ?? 0,
      seuil_approvisionnement: map['seuil_approvisionnement']?.toInt() ?? 0,
      nom: map['nom'] ?? '',
      type: map['type'] ?? '',
      uid: map['uid'] ?? '',
      prix_unitaire_achat: map['prix_unitaire_achat']?.toInt() ?? 0,
      benefice: map['benefice']?.toInt() ?? 0,
      montant_vendu: map['montant_vendu']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory donnesBierresGrandModel.fromJson(String source) =>
      donnesBierresGrandModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'donnesBierresGrandModel(prix_unitaire: $prix_unitaire, quantite_initial: $quantite_initial, quantite_physique: $quantite_physique, seuil_approvisionnement: $seuil_approvisionnement, nom: $nom, type: $type, uid: $uid, prix_unitaire_achat: $prix_unitaire_achat, benefice: $benefice, montant_vendu: $montant_vendu)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is donnesBierresGrandModel &&
        other.prix_unitaire == prix_unitaire &&
        other.quantite_initial == quantite_initial &&
        other.quantite_physique == quantite_physique &&
        other.seuil_approvisionnement == seuil_approvisionnement &&
        other.nom == nom &&
        other.type == type &&
        other.uid == uid &&
        other.prix_unitaire_achat == prix_unitaire_achat &&
        other.benefice == benefice &&
        other.montant_vendu == montant_vendu;
  }

  @override
  int get hashCode {
    return prix_unitaire.hashCode ^
        quantite_initial.hashCode ^
        quantite_physique.hashCode ^
        seuil_approvisionnement.hashCode ^
        nom.hashCode ^
        type.hashCode ^
        uid.hashCode ^
        prix_unitaire_achat.hashCode ^
        benefice.hashCode ^
        montant_vendu.hashCode;
  }
}
