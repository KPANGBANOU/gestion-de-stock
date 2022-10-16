// ignore_for_file: prefer_const_constructors_in_immutables, non_constant_identifier_names, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/statistique_journalier_vente_servant_bar.dart';
import 'package:projet/interface/Bar_restaurant/vendre_grand_modele.dart';
import 'package:projet/modele/vente_credit.dart';
import 'package:projet/modele/vente_petit_modele.dart';

import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

import 'package:projet/base_donne/servicebasededonnees.dart';

class StreamStatistiqueJournalierVenteServantBar extends StatelessWidget {
  StreamStatistiqueJournalierVenteServantBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _utilisateur = Provider.of<Utilisateur>(context);
    return MultiProvider(
      providers: [
        Provider<serviceBD>(create: (_) => serviceBD()),
        StreamProvider(
            create: ((context) =>
                context.read<serviceBD>().list_vente_credits(_utilisateur.uid)),
            initialData: <venteCredit>[]),
        StreamProvider(
            create: ((context) => context
                .read<serviceBD>()
                .list_vente_grand_modele(_utilisateur.uid)),
            initialData: <VenteGrandModele>[]),
        StreamProvider(
            create: ((context) => context
                .read<serviceBD>()
                .list_vente_petit_modele(_utilisateur.uid)),
            initialData: <ventePetitModele>[])
      ],
      child: StatistiqueJournalierVenteServantBar(),
    );
  }
}
