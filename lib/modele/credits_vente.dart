// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class CreditsVente {
  final String nom_client;
  final String prenom_client;
  final String description;
  final int montant;
  final String date_vente;
  final String nom_servant;
  final String prenom_servant;
  final String servant_uid;
  final bool statut;
  CreditsVente({
    required this.nom_client,
    required this.prenom_client,
    required this.description,
    required this.montant,
    required this.date_vente,
    required this.nom_servant,
    required this.prenom_servant,
    required this.servant_uid,
    required this.statut,
  });

  factory CreditsVente.fromFirestore(DocumentSnapshot document) {
    return CreditsVente(
        statut: (document.data() as Map)['statut'],
        nom_client: (document.data() as Map<String, dynamic>)['nom_client'],
        prenom_client:
            (document.data() as Map<String, dynamic>)['prenom_client'],
        description: (document.data() as Map<String, dynamic>)['description'],
        montant: (document.data() as Map)['montant'],
        date_vente: DateFormat('yyyy-MM-dd')
            .format((document.data() as Map)['date_vente']),
        nom_servant: (document.data() as Map<String, dynamic>)['nom_servant'],
        prenom_servant:
            (document.data() as Map<String, dynamic>)['prenom_servant'],
        servant_uid: (document.data() as Map<String, dynamic>)['servant_uid']);
  }

  CreditsVente copyWith({
    String? nom_client,
    String? prenom_client,
    String? description,
    int? montant,
    String? date_vente,
    String? nom_servant,
    String? prenom_servant,
    String? servant_uid,
    bool? statut,
  }) {
    return CreditsVente(
      nom_client: nom_client ?? this.nom_client,
      prenom_client: prenom_client ?? this.prenom_client,
      description: description ?? this.description,
      montant: montant ?? this.montant,
      date_vente: date_vente ?? this.date_vente,
      nom_servant: nom_servant ?? this.nom_servant,
      prenom_servant: prenom_servant ?? this.prenom_servant,
      servant_uid: servant_uid ?? this.servant_uid,
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
    result.addAll({'nom_servant': nom_servant});
    result.addAll({'prenom_servant': prenom_servant});
    result.addAll({'servant_uid': servant_uid});
    result.addAll({'statut': statut});

    return result;
  }

  factory CreditsVente.fromMap(Map<String, dynamic> map) {
    return CreditsVente(
      nom_client: map['nom_client'] ?? '',
      prenom_client: map['prenom_client'] ?? '',
      description: map['description'] ?? '',
      montant: map['montant']?.toInt() ?? 0,
      date_vente: map['date_vente'] ?? '',
      nom_servant: map['nom_servant'] ?? '',
      prenom_servant: map['prenom_servant'] ?? '',
      servant_uid: map['servant_uid'] ?? '',
      statut: map['statut'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreditsVente.fromJson(String source) =>
      CreditsVente.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CreditsVente(nom_client: $nom_client, prenom_client: $prenom_client, description: $description, montant: $montant, date_vente: $date_vente, nom_servant: $nom_servant, prenom_servant: $prenom_servant, servant_uid: $servant_uid, statut: $statut)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreditsVente &&
        other.nom_client == nom_client &&
        other.prenom_client == prenom_client &&
        other.description == description &&
        other.montant == montant &&
        other.date_vente == date_vente &&
        other.nom_servant == nom_servant &&
        other.prenom_servant == prenom_servant &&
        other.servant_uid == servant_uid &&
        other.statut == statut;
  }

  @override
  int get hashCode {
    return nom_client.hashCode ^
        prenom_client.hashCode ^
        description.hashCode ^
        montant.hashCode ^
        date_vente.hashCode ^
        nom_servant.hashCode ^
        prenom_servant.hashCode ^
        servant_uid.hashCode ^
        statut.hashCode;
  }
}
