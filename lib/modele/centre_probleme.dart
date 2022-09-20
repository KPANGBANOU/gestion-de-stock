import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: camel_case_types

class centreProbleme {
  final String uid;
  final String description;
  centreProbleme({
    required this.uid,
    required this.description,
  });

  centreProbleme copyWith({
    String? uid,
    String? description,
  }) {
    return centreProbleme(
      uid: uid ?? this.uid,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'description': description});

    return result;
  }

  factory centreProbleme.fromfirestore(DocumentSnapshot doc) {
    return centreProbleme(
        uid: doc.id,
        description: (doc.data() as Map<String, dynamic>)['description']);
  }

  factory centreProbleme.fromMap(Map<String, dynamic> map) {
    return centreProbleme(
      uid: map['uid'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory centreProbleme.fromJson(String source) =>
      centreProbleme.fromMap(json.decode(source));

  @override
  String toString() => 'centreProbleme(uid: $uid, description: $description)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is centreProbleme &&
        other.uid == uid &&
        other.description == description;
  }

  @override
  int get hashCode => uid.hashCode ^ description.hashCode;
}
