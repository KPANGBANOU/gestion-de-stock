// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: camel_case_types

class credit {
  final String uid;
  final String nom;
  final int benefice;
  final int montant_initial;
  final int montant_disponible;
  final int seuil_approvisionnement;
  credit({
    required this.uid,
    required this.nom,
    required this.benefice,
    required this.montant_initial,
    required this.montant_disponible,
    required this.seuil_approvisionnement,
  });

  factory credit.fromfirestore(DocumentSnapshot document) {
    return credit(
        benefice: (document.data() as Map)['benefice'],
        uid: document.id,
        nom: (document.data() as Map<String, dynamic>)['nom'],
        montant_initial: (document.data() as Map)['montant_initial'],
        montant_disponible: (document.data() as Map)['montant_disponible'],
        seuil_approvisionnement:
            (document.data() as Map)['seuil_approvisionnement']);
  }

  credit copyWith({
    String? uid,
    String? nom,
    int? benefice,
    int? montant_initial,
    int? montant_disponible,
    int? seuil_approvisionnement,
  }) {
    return credit(
      uid: uid ?? this.uid,
      nom: nom ?? this.nom,
      benefice: benefice ?? this.benefice,
      montant_initial: montant_initial ?? this.montant_initial,
      montant_disponible: montant_disponible ?? this.montant_disponible,
      seuil_approvisionnement:
          seuil_approvisionnement ?? this.seuil_approvisionnement,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'nom': nom});
    result.addAll({'benefice': benefice});
    result.addAll({'montant_initial': montant_initial});
    result.addAll({'montant_disponible': montant_disponible});
    result.addAll({'seuil_approvisionnement': seuil_approvisionnement});

    return result;
  }

  factory credit.fromMap(Map<String, dynamic> map) {
    return credit(
      uid: map['uid'] ?? '',
      nom: map['nom'] ?? '',
      benefice: map['benefice']?.toInt() ?? 0,
      montant_initial: map['montant_initial']?.toInt() ?? 0,
      montant_disponible: map['montant_disponible']?.toInt() ?? 0,
      seuil_approvisionnement: map['seuil_approvisionnement']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory credit.fromJson(String source) => credit.fromMap(json.decode(source));

  @override
  String toString() {
    return 'credit(uid: $uid, nom: $nom, benefice: $benefice, montant_initial: $montant_initial, montant_disponible: $montant_disponible, seuil_approvisionnement: $seuil_approvisionnement)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is credit &&
        other.uid == uid &&
        other.nom == nom &&
        other.benefice == benefice &&
        other.montant_initial == montant_initial &&
        other.montant_disponible == montant_disponible &&
        other.seuil_approvisionnement == seuil_approvisionnement;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        nom.hashCode ^
        benefice.hashCode ^
        montant_initial.hashCode ^
        montant_disponible.hashCode ^
        seuil_approvisionnement.hashCode;
  }
}
