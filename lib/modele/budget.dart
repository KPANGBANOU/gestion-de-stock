import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: camel_case_types, non_constant_identifier_names

class budget {
  final int solde_total;
  final int depense;
  final int solde_hors_depense;
  final String uid;
  budget({
    required this.solde_total,
    required this.depense,
    required this.solde_hors_depense,
    required this.uid,
  });

  factory budget.fromFirestore(DocumentSnapshot document) {
    return budget(
        solde_total: (document.data() as Map)['solde_total'],
        depense: (document.data() as Map)['depense'],
        solde_hors_depense: (document.data() as Map)['solde_hors_depense'],
        uid: document.id);
  }

  budget copyWith({
    int? solde_total,
    int? depense,
    int? solde_hors_depense,
    String? uid,
  }) {
    return budget(
      solde_total: solde_total ?? this.solde_total,
      depense: depense ?? this.depense,
      solde_hors_depense: solde_hors_depense ?? this.solde_hors_depense,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'solde_total': solde_total,
      'depense': depense,
      'solde_hors_depense': solde_hors_depense,
      'uid': uid,
    };
  }

  factory budget.fromMap(Map<String, dynamic> map) {
    return budget(
      solde_total: map['solde_total']?.toInt() ?? 0,
      depense: map['depense']?.toInt() ?? 0,
      solde_hors_depense: map['solde_hors_depense']?.toInt() ?? 0,
      uid: map['uid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory budget.fromJson(String source) => budget.fromMap(json.decode(source));

  @override
  String toString() {
    return 'budget(solde_total: $solde_total, depense: $depense, solde_hors_depense: $solde_hors_depense, uid: $uid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is budget &&
        other.solde_total == solde_total &&
        other.depense == depense &&
        other.solde_hors_depense == solde_hors_depense &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return solde_total.hashCode ^
        depense.hashCode ^
        solde_hors_depense.hashCode ^
        uid.hashCode;
  }
}
