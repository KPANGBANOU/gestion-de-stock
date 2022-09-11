// ignore_for_file: camel_case_types, prefer_const_constructors_in_immutables, unnecessary_this

import 'package:flutter/material.dart';
import 'package:projet/modele/bieere_petit_model.dart';
import 'package:provider/provider.dart';

import 'package:projet/base_donne/servicebasededonnees.dart';

import 'second_stream_vente_petit_modele.dart';

class StreamVentePetitModele extends StatelessWidget {
  StreamVentePetitModele({
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
            create: ((context) =>
                context.read<serviceBD>().bierreData(this.uid)),
            initialData: donneesBieerePetitModele(
                prix_unitaire: 0,
                quantite_initial: 0,
                quantite_physique: 0,
                seuil_approvisionnement: 0,
                nom: "",
                type: "",
                uid: this.uid))
      ],
      child: SecondStreamVentePetitModele(),
    );
  }
}
