// ignore_for_file: prefer_const_constructors_in_immutables, non_constant_identifier_names, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:projet/modele/donnesservants.dart';
import 'package:provider/provider.dart';

import 'package:projet/base_donne/servicebasededonnees.dart';
import 'package:projet/interface/Bar_restaurant/vendre_grand_modele.dart';
import 'package:projet/modele/vente_credit.dart';
import 'package:projet/modele/vente_petit_modele.dart';

import 'statistique_journalier_employe_bar.dart';

class StreamStatistiqueJournalierEmployeBar extends StatelessWidget {
  StreamStatistiqueJournalierEmployeBar({
    Key? key,
    required this.uid,
  }) : super(key: key);

  final String uid;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<serviceBD>(create: (_) => serviceBD()),
        StreamProvider(
            create: ((context) => context.read<serviceBD>().servant_data(uid)),
            initialData: donnesServants(
                uid: uid,
                domaine: "",
                photo_url: "",
                admin: false,
                is_active: true)),
        StreamProvider(
            create: ((context) =>
                context.read<serviceBD>().list_vente_credits(uid)),
            initialData: <venteCredit>[]),
        StreamProvider(
            create: ((context) =>
                context.read<serviceBD>().list_vente_grand_modele(uid)),
            initialData: <VenteGrandModele>[]),
        StreamProvider(
            create: ((context) =>
                context.read<serviceBD>().list_vente_petit_modele(uid)),
            initialData: <ventePetitModele>[])
      ],
      child: StatistiqueJournalierEmployeBar(),
    );
  }
}
