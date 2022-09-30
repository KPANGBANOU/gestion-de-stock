// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: camel_case_types

class venteCredit {
  final String uid;
  final String nom;
  final int montant;
  venteCredit({
    required this.uid,
    required this.nom,
    required this.montant,
  });

  factory venteCredit.fromFirestore(DocumentSnapshot snap) {
    return venteCredit(
      uid: snap.id,
      nom: (snap.data() as Map<String, dynamic>)['nom'],
      montant: (snap.data() as Map)['montant'],
    );
  }

  venteCredit copyWith({
    String? uid,
    String? nom,
    int? montant,
  }) {
    return venteCredit(
      uid: uid ?? this.uid,
      nom: nom ?? this.nom,
      montant: montant ?? this.montant,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'nom': nom});
    result.addAll({'montant': montant});

    return result;
  }

  factory venteCredit.fromMap(Map<String, dynamic> map) {
    return venteCredit(
      uid: map['uid'] ?? '',
      nom: map['nom'] ?? '',
      montant: map['montant']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory venteCredit.fromJson(String source) =>
      venteCredit.fromMap(json.decode(source));

  @override
  String toString() => 'venteCredit(uid: $uid, nom: $nom, montant: $montant)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is venteCredit &&
        other.uid == uid &&
        other.nom == nom &&
        other.montant == montant;
  }

  @override
  int get hashCode => uid.hashCode ^ nom.hashCode ^ montant.hashCode;
}
