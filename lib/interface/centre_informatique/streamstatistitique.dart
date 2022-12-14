// ignore_for_file: prefer_const_constructors_in_immutables, non_constant_identifier_names, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:projet/interface/centre_informatique/centre_statistique_client.dart';
import 'package:projet/modele/centre_vente.dart';
import 'package:projet/modele/donnesservants.dart';
import 'package:projet/modele/vente_credit.dart';
import 'package:projet/modele/vente_tee_shirts.dart';

import 'package:provider/provider.dart';

import 'package:projet/base_donne/servicebasededonnees.dart';

class StreamStatistiqueVente extends StatelessWidget {
  StreamStatistiqueVente({
    Key? key,
    required this.utilisateur_uid,
  }) : super(key: key);

  final String utilisateur_uid;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<serviceBD>(create: (_) => serviceBD()),
        StreamProvider(
            create: ((context) =>
                context.read<serviceBD>().servant_data(utilisateur_uid)),
            initialData: donnesServants(
                domaine: "",
                photo_url: "",
                uid: utilisateur_uid,
                nom: "",
                prenom: "",
                sexe: "",
                telephone: "",
                role: "",
                is_active: true,
                admin: false,
                date_naissance: "")),
        StreamProvider(
            create: ((context) => context
                .read<serviceBD>()
                .centre_list_vente_produits(utilisateur_uid)),
            initialData: <centreVente>[]),
        StreamProvider(
            create: ((context) =>
                context.read<serviceBD>().list_vente_credits(utilisateur_uid)),
            initialData: <venteCredit>[]),
        StreamProvider(
            create: ((context) => context
                .read<serviceBD>()
                .list_vente_tee_shirt(utilisateur_uid)),
            initialData: <venteteeshirts>[])
      ],
      child: CentreStatistiqueEmploye(),
    );
  }
}
