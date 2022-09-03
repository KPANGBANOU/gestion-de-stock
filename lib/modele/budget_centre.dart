// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: camel_case_types

class budgetCentre {
  final int solde_total;
  final int depense;
  final String uid;
  budgetCentre({
    required this.solde_total,
    required this.depense,
    required this.uid,
  });

  factory budgetCentre.fromFirestore(DocumentSnapshot document) {
    return budgetCentre(
      solde_total: (document.data() as Map<String, dynamic>)['solde_total'],
      depense: (document.data() as Map<String, dynamic>)['depense'],
      uid: document.id,
    );
  }

  budgetCentre copyWith({
    int? solde_total,
    int? depense,
    String? uid,
  }) {
    return budgetCentre(
      solde_total: solde_total ?? this.solde_total,
      depense: depense ?? this.depense,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'solde_total': solde_total});
    result.addAll({'depense': depense});
    result.addAll({'uid': uid});

    return result;
  }

  factory budgetCentre.fromMap(Map<String, dynamic> map) {
    return budgetCentre(
      solde_total: map['solde_total']?.toInt() ?? 0,
      depense: map['depense']?.toInt() ?? 0,
      uid: map['uid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory budgetCentre.fromJson(String source) =>
      budgetCentre.fromMap(json.decode(source));

  @override
  String toString() =>
      'budgetCentre(solde_total: $solde_total, depense: $depense, uid: $uid)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is budgetCentre &&
        other.solde_total == solde_total &&
        other.depense == depense &&
        other.uid == uid;
  }

  @override
  int get hashCode => solde_total.hashCode ^ depense.hashCode ^ uid.hashCode;
}
