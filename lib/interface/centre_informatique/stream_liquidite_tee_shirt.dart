// ignore_for_file: non_constant_identifier_names, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:projet/modele/serigraphie.dart';
import 'package:provider/provider.dart';

import 'package:projet/base_donne/servicebasededonnees.dart';

import 'liquidite_tee_shirt.dart';

class StreamLiquiditeTeeShirt extends StatelessWidget {
  StreamLiquiditeTeeShirt({
    Key? key,
    required this.tee_shirt_uid,
  }) : super(key: key);

  final String tee_shirt_uid;

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_literals_to_create_immutables
    return MultiProvider(
      providers: [
        Provider(create: (_) => serviceBD()),
        StreamProvider(
            create: ((context) =>
                context.read<serviceBD>().tee_shirt(tee_shirt_uid)),
            initialData: serigraphie(
                approvisionne: true,
                benefice: 0,
                tee_shirt_nom: "",
                uid: tee_shirt_uid,
                qualite: "",
                prix_unitaire_vente: 0,
                prix_unitaire_achat: 0,
                montant_vendu: 0,
                quantite_initial: 0,
                quantite_physique: 0,
                seuil_approvisionnement: 0))
      ],
      child: LiquiditeTeeShirt(),
    );
  }
}
