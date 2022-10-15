// ignore_for_file: prefer_const_constructors_in_immutables, non_constant_identifier_names, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:projet/interface/centre_informatique/vente_tee_shirt.dart';
import 'package:projet/modele/centre_vente.dart';
import 'package:projet/modele/vente_credit.dart';

import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

import 'package:projet/base_donne/servicebasededonnees.dart';

class StreamStatistiqueJournalierVenteServantCentre extends StatelessWidget {
  StreamStatistiqueJournalierVenteServantCentre({
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
                .list_vente_tee_shirt(_utilisateur.uid)),
            initialData: <VenteTeeShirt>[]),
        StreamProvider(
            create: ((context) => context
                .read<serviceBD>()
                .centre_list_vente_produits(_utilisateur.uid)),
            initialData: <centreVente>[])
      ],
      child: StatistiqueJournalierVenteServantCentre(),
    );
  }
}
