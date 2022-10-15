// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class CreditsServants {
  final String nom_client;
  final String prenom_client;
  final String description;
  final int montant;
  final String date_vente;
  final String uid;
  final bool statut;
  CreditsServants({
    required this.nom_client,
    required this.prenom_client,
    required this.description,
    required this.montant,
    required this.date_vente,
    required this.uid,
    required this.statut,
  });

  factory CreditsServants.fromFirestore(DocumentSnapshot document) {
    return CreditsServants(
        statut: (document.data() as Map)['statut'],
        uid: document.id,
        nom_client: (document.data() as Map<String, dynamic>)['nom_client'],
        prenom_client:
            (document.data() as Map<String, dynamic>)['prenom_client'],
        description: (document.data() as Map<String, dynamic>)['description'],
        montant: (document.data() as Map)['montant'],
        date_vente: DateFormat('yyyy-MM-dd')
            .format((document.data() as Map)['date_vente']));
  }

  CreditsServants copyWith({
    String? nom_client,
    String? prenom_client,
    String? description,
    int? montant,
    String? date_vente,
    String? uid,
    bool? statut,
  }) {
    return CreditsServants(
      nom_client: nom_client ?? this.nom_client,
      prenom_client: prenom_client ?? this.prenom_client,
      description: description ?? this.description,
      montant: montant ?? this.montant,
      date_vente: date_vente ?? this.date_vente,
      uid: uid ?? this.uid,
      statut: statut ?? this.statut,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'nom_client': nom_client});
    result.addAll({'prenom_client': prenom_client});
    result.addAll({'description': description});
    result.addAll({'montant': montant});
    result.addAll({'date_vente': date_vente});
    result.addAll({'uid': uid});
    result.addAll({'statut': statut});

    return result;
  }

  factory CreditsServants.fromMap(Map<String, dynamic> map) {
    return CreditsServants(
      nom_client: map['nom_client'] ?? '',
      prenom_client: map['prenom_client'] ?? '',
      description: map['description'] ?? '',
      montant: map['montant']?.toInt() ?? 0,
      date_vente: map['date_vente'] ?? '',
      uid: map['uid'] ?? '',
      statut: map['statut'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreditsServants.fromJson(String source) =>
      CreditsServants.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CreditsServants(nom_client: $nom_client, prenom_client: $prenom_client, description: $description, montant: $montant, date_vente: $date_vente, uid: $uid, statut: $statut)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreditsServants &&
        other.nom_client == nom_client &&
        other.prenom_client == prenom_client &&
        other.description == description &&
        other.montant == montant &&
        other.date_vente == date_vente &&
        other.uid == uid &&
        other.statut == statut;
  }

  @override
  int get hashCode {
    return nom_client.hashCode ^
        prenom_client.hashCode ^
        description.hashCode ^
        montant.hashCode ^
        date_vente.hashCode ^
        uid.hashCode ^
        statut.hashCode;
  }
}
