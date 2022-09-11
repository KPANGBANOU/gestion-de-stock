import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: camel_case_types, non_constant_identifier_names

class vente {
  final String uid;
  final int quantite;
  final int montant;
  final String nom_bierre;
  final String category;
  vente({
    required this.uid,
    required this.quantite,
    required this.montant,
    required this.nom_bierre,
    required this.category,
  });

  factory vente.fromFirestore(DocumentSnapshot document) {
    return vente(
        nom_bierre: (document.data() as Map)['nom_bierre'],
        category: (document.data() as Map)['category'],
        quantite: (document.data() as Map)['quantite'],
        montant: (document.data() as Map)['montant'],
        uid: document.id);
  }

  vente copyWith({
    String? uid,
    int? quantite,
    int? montant,
    String? nom_bierre,
    String? category,
  }) {
    return vente(
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

  factory vente.fromMap(Map<String, dynamic> map) {
    return vente(
      uid: map['uid'] ?? '',
      quantite: map['quantite']?.toInt() ?? 0,
      montant: map['montant']?.toInt() ?? 0,
      nom_bierre: map['nom_bierre'] ?? '',
      category: map['category'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory vente.fromJson(String source) => vente.fromMap(json.decode(source));

  @override
  String toString() {
    return 'vente(uid: $uid, quantite: $quantite, montant: $montant, nom_bierre: $nom_bierre, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is vente &&
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
