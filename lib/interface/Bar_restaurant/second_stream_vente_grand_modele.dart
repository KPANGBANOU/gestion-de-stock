// ignore_for_file: prefer_const_constructors_in_immutables, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:flutter/material.dart';
import 'package:projet/base_donne/servicebasededonnees.dart';
import 'package:projet/interface/Bar_restaurant/vendre_grand_modele.dart';
import 'package:projet/modele/bierre_grand_model.dart';
import 'package:projet/modele/vente_grand_modele.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

class SecondStreamVenteGrandModele extends StatelessWidget {
  SecondStreamVenteGrandModele({super.key});

  @override
  Widget build(BuildContext context) {
    final _bierre = Provider.of<donnesBierresGrandModel>(context);
    final _user = Provider.of<Utilisateur>(context);
    return MultiProvider(
      providers: [
        Provider<serviceBD>(create: (_) => serviceBD()),
        StreamProvider(
            create: ((context) => context
                .read<serviceBD>()
                .vente_grand_modele(_user.uid, _bierre.uid)),
            initialData: venteGrandModele(
                benefice: 0,
                date_vente: "",
                date_vente_day: "",
                date_vente_month: "",
                uid: _bierre.uid,
                quantite: 0,
                montant: 0,
                nom_bierre: _bierre.nom,
                category: _bierre.type)),
      ],
      child: VenteGrandModele(),
    );
  }
}
