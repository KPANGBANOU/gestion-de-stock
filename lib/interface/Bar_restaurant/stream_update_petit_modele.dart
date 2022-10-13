// ignore_for_file: prefer_const_constructors_in_immutables, non_constant_identifier_names, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/update_petit_modele.dart';
import 'package:projet/modele/bieere_petit_model.dart';

import 'package:projet/modele/centre_vente.dart';
import 'package:projet/modele/vente_petit_modele.dart';

import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

import 'package:projet/base_donne/servicebasededonnees.dart';

class StreamUpdatePetitModele extends StatelessWidget {
  StreamUpdatePetitModele({
    Key? key,
    required this.produit_uid,
  }) : super(key: key);

  final String produit_uid;

  @override
  Widget build(BuildContext context) {
    final _utilisateur = Provider.of<Utilisateur>(context);
    return MultiProvider(
      providers: [
        Provider<serviceBD>(create: (_) => serviceBD()),
        StreamProvider(
            create: ((context) =>
                context.read<serviceBD>().bierreData(produit_uid)),
            initialData: donneesBieerePetitModele(
                montant_vendu: 0,
                benefice: 0,
                prix_unitaire_achat: 0,
                prix_unitaire: 0,
                quantite_initial: 0,
                quantite_physique: 0,
                seuil_approvisionnement: 0,
                nom: "",
                type: "",
                uid: produit_uid)),
        StreamProvider(
            create: ((context) => context
                .read<serviceBD>()
                .vente_petit_modele(_utilisateur.uid, produit_uid)),
            initialData: ventePetitModele(
                uid: produit_uid,
                quantite: 0,
                montant: 0,
                nom_bierre: "",
                category: "",
                benefice: 0,
                date_vente_day: "",
                date_vente: "",
                date_vente_month: "")),
      ],
      child: UpdatePetitModele(),
    );
  }
}
