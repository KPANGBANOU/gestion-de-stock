// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, unused_field, non_constant_identifier_names, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:projet/base_donne/servicebasededonnees.dart';
import 'package:projet/interface/Bar_restaurant/statistique_liste_servants.dart';
import 'package:projet/modele/donnesservants.dart';
import 'package:provider/provider.dart';

class StatistiqueDesVentesBar extends StatelessWidget {
  StatistiqueDesVentesBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<serviceBD>(create: (_) => serviceBD()),
        StreamProvider(
            create: ((context) => context.read<serviceBD>().servantBar),
            initialData: <donnesServants>[]),
      ],
      child: StatistiqueListeServantsBar(),
    );
  }
}
