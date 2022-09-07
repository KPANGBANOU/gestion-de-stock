import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: camel_case_types, non_constant_identifier_names

class vente {
  final String bierre_id;
  final int quantite;
  final int montant;
  final String uid;
  vente({
    required this.bierre_id,
    required this.quantite,
    required this.montant,
    required this.uid,
  });

  factory vente.fromFirestore(DocumentSnapshot document) {
    return vente(
        bierre_id: (document.data() as Map<String, dynamic>)['bierre_id'],
        quantite: (document.data() as Map)['quantite'],
        montant: (document.data() as Map)['montant'],
        uid: document.id);
  }

  vente copyWith({
    String? bierre_id,
    int? quantite,
    int? montant,
    String? uid,
  }) {
    return vente(
      bierre_id: bierre_id ?? this.bierre_id,
      quantite: quantite ?? this.quantite,
      montant: montant ?? this.montant,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bierre_id': bierre_id,
      'quantite': quantite,
      'montant': montant,
      'uid': uid,
    };
  }

  factory vente.fromMap(Map<String, dynamic> map) {
    return vente(
      bierre_id: map['bierre_id'] ?? '',
      quantite: map['quantite']?.toInt() ?? 0,
      montant: map['montant']?.toInt() ?? 0,
      uid: map['uid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory vente.fromJson(String source) => vente.fromMap(json.decode(source));

  @override
  String toString() {
    return 'vente(bierre_id: $bierre_id, quantite: $quantite, montant: $montant, uid: $uid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is vente &&
        other.bierre_id == bierre_id &&
        other.quantite == quantite &&
        other.montant == montant &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return bierre_id.hashCode ^
        quantite.hashCode ^
        montant.hashCode ^
        uid.hashCode;
  }
}
