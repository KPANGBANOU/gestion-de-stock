// ignore_for_file: prefer_const_constructors_in_immutables, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:flutter/material.dart';
import 'package:projet/base_donne/servicebasededonnees.dart';
import 'package:projet/modele/bieere_petit_model.dart';

import 'package:projet/modele/vente.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

import 'vendre_petit_modele.dart';

class SecondStreamVentePetitModele extends StatelessWidget {
  SecondStreamVentePetitModele({super.key});

  @override
  Widget build(BuildContext context) {
    final _bierre = Provider.of<donneesBieerePetitModele>(context);
    final _user = Provider.of<Utilisateur>(context);
    return MultiProvider(
      providers: [
        Provider<serviceBD>(create: (_) => serviceBD()),
        StreamProvider(
            create: ((context) =>
                context.read<serviceBD>().ventedata(_bierre.uid, _user.uid)),
            initialData: vente(
                uid: _bierre.uid,
                quantite: 0,
                montant: 0,
                nom_bierre: _bierre.nom,
                category: _bierre.type)),
      ],
      child: VentePetitModele(),
    );
  }
}
