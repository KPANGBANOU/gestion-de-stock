// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: file_names

class BudgetBar {
  final int solde_total;
  final int depense;
  final String uid;
  BudgetBar({
    required this.solde_total,
    required this.depense,
    required this.uid,
  });

  factory BudgetBar.fromFirestore(DocumentSnapshot document) {
    return BudgetBar(
      solde_total: (document.data() as Map<String, dynamic>)['solde_total'],
      depense: (document.data() as Map<String, dynamic>)['depense'],
      uid: document.id,
    );
  }

  BudgetBar copyWith({
    int? solde_total,
    int? depense,
    String? uid,
  }) {
    return BudgetBar(
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

  factory BudgetBar.fromMap(Map<String, dynamic> map) {
    return BudgetBar(
      solde_total: map['solde_total']?.toInt() ?? 0,
      depense: map['depense']?.toInt() ?? 0,
      uid: map['uid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BudgetBar.fromJson(String source) =>
      BudgetBar.fromMap(json.decode(source));

  @override
  String toString() =>
      'BudgetBar(solde_total: $solde_total, depense: $depense, uid: $uid)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BudgetBar &&
        other.solde_total == solde_total &&
        other.depense == depense &&
        other.uid == uid;
  }

  @override
  int get hashCode => solde_total.hashCode ^ depense.hashCode ^ uid.hashCode;
}
