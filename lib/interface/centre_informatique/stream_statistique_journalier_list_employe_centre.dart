// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:projet/base_donne/servicebasededonnees.dart';
import 'package:projet/modele/donnesservants.dart';
import 'package:provider/provider.dart';

import 'statistique_journalier_list_employe_centre.dart';

class StreamStatistiqueJournalierListEmployeCentre extends StatelessWidget {
  const StreamStatistiqueJournalierListEmployeCentre({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<serviceBD>(create: (_) => serviceBD()),
        StreamProvider(
            create: ((context) =>
                context.read<serviceBD>().list_servants("Centre informatique")),
            initialData: <donnesServants>[])
      ],
      child: StatistiqueJournalierListEmployeCentre(),
    );
  }
}
