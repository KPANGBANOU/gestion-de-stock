// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, unnecessary_this, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:projet/base_donne/servicebasededonnees.dart';
import 'package:projet/modele/donnesservants.dart';
import 'package:projet/modele/vente_grand_modele.dart';
import 'package:projet/modele/vente_petit_modele.dart';

import 'package:provider/provider.dart';

import 'statistique_servant_bar.dart';

class StreamServantBar extends StatelessWidget {
  StreamServantBar({super.key, required this.uid});
  final String uid;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<serviceBD>(create: (_) => serviceBD()),
        StreamProvider(
            create: ((context) => context.read<serviceBD>().servant_data(uid)),
            initialData: donnesServants(
                uid: this.uid,
                domaine: "",
                photo_url: "",
                nom: "",
                prenom: "",
                email: "",
                telephone: "",
                sexe: "",
                role: "",
                admin: false,
                is_active: true,
                date_naissance: "")),
        StreamProvider(
            create: ((context) => context
                .read<serviceBD>()
                .list_vente_servant_bar_petit_modele(this.uid)),
            initialData: <ventePetitModele>[]),
        StreamProvider(
            create: ((context) => context
                .read<serviceBD>()
                .list_vente_servant_bar_grand_modele(this.uid)),
            initialData: <venteGrandModele>[]),
      ],
      child: StatistiqueServantBar(),
    );
  }
}
