// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: camel_case_types

class venteGrandModele {
  final String uid;
  final int quantite;
  final int montant;
  final String nom_bierre;
  final String category;
  venteGrandModele({
    required this.uid,
    required this.quantite,
    required this.montant,
    required this.nom_bierre,
    required this.category,
  });

  factory venteGrandModele.fromFirestore(DocumentSnapshot document) {
    return venteGrandModele(
        nom_bierre: (document.data() as Map<String, dynamic>)['nom_bierre'],
        category: (document.data() as Map<String, dynamic>)['category'],
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
  }) {
    return venteGrandModele(
      uid: uid ?? this.uid,
      quantite: quantite ?? this.quantite,
      montant: montant ?? this.montant,
      nom_bierre: nom_bierre ?? this.nom_bierre,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'quantite': quantite});
    result.addAll({'montant': montant});
    result.addAll({'nom_bierre': nom_bierre});
    result.addAll({'category': category});

    return result;
  }

  factory venteGrandModele.fromMap(Map<String, dynamic> map) {
    return venteGrandModele(
      uid: map['uid'] ?? '',
      quantite: map['quantite']?.toInt() ?? 0,
      montant: map['montant']?.toInt() ?? 0,
      nom_bierre: map['nom_bierre'] ?? '',
      category: map['category'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory venteGrandModele.fromJson(String source) =>
      venteGrandModele.fromMap(json.decode(source));

  @override
  String toString() {
    return 'venteGrandModele(uid: $uid, quantite: $quantite, montant: $montant, nom_bierre: $nom_bierre, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is venteGrandModele &&
        other.uid == uid &&
        other.quantite == quantite &&
        other.montant == montant &&
        other.nom_bierre == nom_bierre &&
        other.category == category;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        quantite.hashCode ^
        montant.hashCode ^
        nom_bierre.hashCode ^
        category.hashCode;
  }
}