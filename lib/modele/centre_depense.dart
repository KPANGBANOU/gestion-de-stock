import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: camel_case_types

class centreDepense {
  final String uid;
  final String description;
  final int montant;
  centreDepense({
    required this.uid,
    required this.description,
    required this.montant,
  });

  centreDepense copyWith({
    String? uid,
    String? description,
    int? montant,
  }) {
    return centreDepense(
      uid: uid ?? this.uid,
      description: description ?? this.description,
      montant: montant ?? this.montant,
    );
  }

  factory centreDepense.fromfirestore(DocumentSnapshot doc) {
    return centreDepense(
        uid: doc.id,
        description: (doc.data() as Map<String, dynamic>)['description'],
        montant: (doc.data() as Map<String, dynamic>)['montant']);
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'description': description});
    result.addAll({'montant': montant});

    return result;
  }

  factory centreDepense.fromMap(Map<String, dynamic> map) {
    return centreDepense(
      uid: map['uid'] ?? '',
      description: map['description'] ?? '',
      montant: map['montant']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory centreDepense.fromJson(String source) =>
      centreDepense.fromMap(json.decode(source));

  @override
  String toString() =>
      'centreDepense(uid: $uid, description: $description, montant: $montant)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is centreDepense &&
        other.uid == uid &&
        other.description == description &&
        other.montant == montant;
  }

  @override
  int get hashCode => uid.hashCode ^ description.hashCode ^ montant.hashCode;
}
