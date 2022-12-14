// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:projet/base_donne/servicebasededonnees.dart';
import 'package:projet/modele/donnesservants.dart';
import 'package:provider/provider.dart';

import 'statistique_liste_servants.dart';

class StreamStatistiqueJournalierListEmployeBar extends StatelessWidget {
  const StreamStatistiqueJournalierListEmployeBar({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<serviceBD>(create: (_) => serviceBD()),
        StreamProvider(
            create: ((context) =>
                context.read<serviceBD>().list_servants("Bar restaurant")),
            initialData: <donnesServants>[])
      ],
      child: StatistiqueJournalierListEmployeBar(),
    );
  }
}
