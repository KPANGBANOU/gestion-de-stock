import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: camel_case_types, non_constant_identifier_names

class probleme {
  final String uid;
  final String description;
  probleme({
    required this.uid,
    required this.description,
  });

  factory probleme.fromFirestore(DocumentSnapshot document) {
    return probleme(
      uid: document.id,
      description: (document.data() as Map<String, dynamic>)['description'],
    );
  }

  probleme copyWith({
    String? uid,
    String? description,
  }) {
    return probleme(
      uid: uid ?? this.uid,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'description': description,
    };
  }

  factory probleme.fromMap(Map<String, dynamic> map) {
    return probleme(
      uid: map['uid'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory probleme.fromJson(String source) =>
      probleme.fromMap(json.decode(source));

  @override
  String toString() => 'probleme(uid: $uid, description: $description)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is probleme &&
        other.uid == uid &&
        other.description == description;
  }

  @override
  int get hashCode => uid.hashCode ^ description.hashCode;
}
