import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: non_constant_identifier_names, camel_case_types

class depense {
  final String uid;
  depense({
    required this.uid,
  });
}

class donnesDepense {
  final String id;
  final String description;
  final int montant;
  donnesDepense({
    required this.id,
    required this.description,
    required this.montant,
  });

  donnesDepense copyWith({
    String? id,
    String? description,
    int? montant,
  }) {
    return donnesDepense(
      id: id ?? this.id,
      description: description ?? this.description,
      montant: montant ?? this.montant,
    );
  }

  factory donnesDepense.fromFirestore(DocumentSnapshot document) {
    return donnesDepense(
        id: document.id,
        description: (document.data() as Map<String, dynamic>)['description'],
        montant: (document.data() as Map<String, dynamic>)['montant']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'montant': montant,
    };
  }

  factory donnesDepense.fromMap(Map<String, dynamic> map) {
    return donnesDepense(
      id: map['id'] ?? '',
      description: map['description'] ?? '',
      montant: map['montant']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory donnesDepense.fromJson(String source) =>
      donnesDepense.fromMap(json.decode(source));

  @override
  String toString() =>
      'donnesDepense(id: $id, description: $description, montant: $montant)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is donnesDepense &&
        other.id == id &&
        other.description == description &&
        other.montant == montant;
  }

  @override
  int get hashCode => id.hashCode ^ description.hashCode ^ montant.hashCode;
}
