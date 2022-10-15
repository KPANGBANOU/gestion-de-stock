// ignore_for_file: camel_case_types, prefer_const_constructors_in_immutables, unnecessary_this

import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/vendre_grand_modele.dart';
import 'package:projet/modele/bierre_grand_model.dart';
import 'package:provider/provider.dart';

import 'package:projet/base_donne/servicebasededonnees.dart';

class StreamVenteGrandModele extends StatelessWidget {
  StreamVenteGrandModele({
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
                context.read<serviceBD>().bierreGrandModele(this.uid)),
            initialData: donnesBierresGrandModel(
                approvisionne: true,
                montant_vendu: 0,
                benefice: 0,
                prix_unitaire_achat: 0,
                prix_unitaire: 0,
                quantite_initial: 0,
                quantite_physique: 0,
                seuil_approvisionnement: 0,
                nom: "",
                type: "",
                uid: this.uid))
      ],
      child: VenteGrandModele(),
    );
  }
}
