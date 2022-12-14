import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: non_constant_identifier_names, camel_case_types

class donneesBieerePetitModele {
  final int prix_unitaire;
  final int quantite_initial;
  final int quantite_physique;
  final int seuil_approvisionnement;
  final String nom;
  final String type;
  final String uid;
  final int benefice;
  final int prix_unitaire_achat;
  final int montant_vendu;
  final bool approvisionne;
  donneesBieerePetitModele({
    required this.prix_unitaire,
    required this.quantite_initial,
    required this.quantite_physique,
    required this.seuil_approvisionnement,
    required this.nom,
    required this.type,
    required this.uid,
    required this.benefice,
    required this.prix_unitaire_achat,
    required this.montant_vendu,
    required this.approvisionne,
  });

  factory donneesBieerePetitModele.fromFirestore(DocumentSnapshot document) {
    return donneesBieerePetitModele(
        approvisionne: (document.data() as Map)['approvisionne'],
        montant_vendu: (document.data() as Map)['montant_vendu'],
        benefice: (document.data() as Map)['benefice'],
        prix_unitaire: (document.data() as Map)['prix_unitaire'],
        quantite_initial: (document.data() as Map)['quantite_initial'],
        quantite_physique: (document.data() as Map)['quantite_physique'],
        seuil_approvisionnement:
            (document.data() as Map)['seuil_approvisionnement'],
        nom: (document.data() as Map<String, dynamic>)['nom'],
        type: (document.data() as Map<String, dynamic>)['type'],
        uid: (document.id),
        prix_unitaire_achat: (document.data() as Map)['prix_unitaire_achat']);
  }

  donneesBieerePetitModele copyWith({
    int? prix_unitaire,
    int? quantite_initial,
    int? quantite_physique,
    int? seuil_approvisionnement,
    String? nom,
    String? type,
    String? uid,
    int? benefice,
    int? prix_unitaire_achat,
    int? montant_vendu,
    bool? approvisionne,
  }) {
    return donneesBieerePetitModele(
      prix_unitaire: prix_unitaire ?? this.prix_unitaire,
      quantite_initial: quantite_initial ?? this.quantite_initial,
      quantite_physique: quantite_physique ?? this.quantite_physique,
      seuil_approvisionnement:
          seuil_approvisionnement ?? this.seuil_approvisionnement,
      nom: nom ?? this.nom,
      type: type ?? this.type,
      uid: uid ?? this.uid,
      benefice: benefice ?? this.benefice,
      prix_unitaire_achat: prix_unitaire_achat ?? this.prix_unitaire_achat,
      montant_vendu: montant_vendu ?? this.montant_vendu,
      approvisionne: approvisionne ?? this.approvisionne,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'prix_unitaire': prix_unitaire});
    result.addAll({'quantite_initial': quantite_initial});
    result.addAll({'quantite_physique': quantite_physique});
    result.addAll({'seuil_approvisionnement': seuil_approvisionnement});
    result.addAll({'nom': nom});
    result.addAll({'type': type});
    result.addAll({'uid': uid});
    result.addAll({'benefice': benefice});
    result.addAll({'prix_unitaire_achat': prix_unitaire_achat});
    result.addAll({'montant_vendu': montant_vendu});
    result.addAll({'approvisionne': approvisionne});

    return result;
  }

  factory donneesBieerePetitModele.fromMap(Map<String, dynamic> map) {
    return donneesBieerePetitModele(
      prix_unitaire: map['prix_unitaire']?.toInt() ?? 0,
      quantite_initial: map['quantite_initial']?.toInt() ?? 0,
      quantite_physique: map['quantite_physique']?.toInt() ?? 0,
      seuil_approvisionnement: map['seuil_approvisionnement']?.toInt() ?? 0,
      nom: map['nom'] ?? '',
      type: map['type'] ?? '',
      uid: map['uid'] ?? '',
      benefice: map['benefice']?.toInt() ?? 0,
      prix_unitaire_achat: map['prix_unitaire_achat']?.toInt() ?? 0,
      montant_vendu: map['montant_vendu']?.toInt() ?? 0,
      approvisionne: map['approvisionne'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory donneesBieerePetitModele.fromJson(String source) =>
      donneesBieerePetitModele.fromMap(json.decode(source));

  @override
  String toString() {
    return 'donneesBieerePetitModele(prix_unitaire: $prix_unitaire, quantite_initial: $quantite_initial, quantite_physique: $quantite_physique, seuil_approvisionnement: $seuil_approvisionnement, nom: $nom, type: $type, uid: $uid, benefice: $benefice, prix_unitaire_achat: $prix_unitaire_achat, montant_vendu: $montant_vendu, approvisionne: $approvisionne)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is donneesBieerePetitModele &&
        other.prix_unitaire == prix_unitaire &&
        other.quantite_initial == quantite_initial &&
        other.quantite_physique == quantite_physique &&
        other.seuil_approvisionnement == seuil_approvisionnement &&
        other.nom == nom &&
        other.type == type &&
        other.uid == uid &&
        other.benefice == benefice &&
        other.prix_unitaire_achat == prix_unitaire_achat &&
        other.montant_vendu == montant_vendu &&
        other.approvisionne == approvisionne;
  }

  @override
  int get hashCode {
    return prix_unitaire.hashCode ^
        quantite_initial.hashCode ^
        quantite_physique.hashCode ^
        seuil_approvisionnement.hashCode ^
        nom.hashCode ^
        type.hashCode ^
        uid.hashCode ^
        benefice.hashCode ^
        prix_unitaire_achat.hashCode ^
        montant_vendu.hashCode ^
        approvisionne.hashCode;
  }
}
