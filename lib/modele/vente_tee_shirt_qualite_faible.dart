// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: camel_case_types

class venteteeshirtsqualitefaible {
  final String uid;
  final int quantite;
  final int montant;
  final String nom_tee_shirts;
  final String qualite;
  venteteeshirtsqualitefaible({
    required this.uid,
    required this.quantite,
    required this.montant,
    required this.nom_tee_shirts,
    required this.qualite,
  });

  factory venteteeshirtsqualitefaible.fromfirestore(DocumentSnapshot document) {
    return venteteeshirtsqualitefaible(
      uid: document.id,
      quantite: (document.data() as Map)['quantite'],
      montant: (document.data() as Map)['montant'],
      nom_tee_shirts:
          (document.data() as Map<String, dynamic>)['nom_tee_shirt'],
      qualite: (document.data() as Map<String, dynamic>)['qualite'],
    );
  }

  venteteeshirtsqualitefaible copyWith({
    String? uid,
    int? quantite,
    int? montant,
    String? nom_tee_shirts,
    String? qualite,
  }) {
    return venteteeshirtsqualitefaible(
      uid: uid ?? this.uid,
      quantite: quantite ?? this.quantite,
      montant: montant ?? this.montant,
      nom_tee_shirts: nom_tee_shirts ?? this.nom_tee_shirts,
      qualite: qualite ?? this.qualite,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'quantite': quantite});
    result.addAll({'montant': montant});
    result.addAll({'nom_tee_shirts': nom_tee_shirts});
    result.addAll({'qualite': qualite});

    return result;
  }

  factory venteteeshirtsqualitefaible.fromMap(Map<String, dynamic> map) {
    return venteteeshirtsqualitefaible(
      uid: map['uid'] ?? '',
      quantite: map['quantite']?.toInt() ?? 0,
      montant: map['montant']?.toInt() ?? 0,
      nom_tee_shirts: map['nom_tee_shirts'] ?? '',
      qualite: map['qualite'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory venteteeshirtsqualitefaible.fromJson(String source) =>
      venteteeshirtsqualitefaible.fromMap(json.decode(source));

  @override
  String toString() {
    return 'venteteeshirtsgrandequalite(uid: $uid, quantite: $quantite, montant: $montant, nom_tee_shirts: $nom_tee_shirts, qualite: $qualite)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is venteteeshirtsqualitefaible &&
        other.uid == uid &&
        other.quantite == quantite &&
        other.montant == montant &&
        other.nom_tee_shirts == nom_tee_shirts &&
        other.qualite == qualite;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        quantite.hashCode ^
        montant.hashCode ^
        nom_tee_shirts.hashCode ^
        qualite.hashCode;
  }
}
