// ignore_for_file: prefer_const_constructors_in_immutables, non_constant_identifier_names, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:flutter/material.dart';
import 'package:projet/modele/centre_vente.dart';
import 'package:projet/modele/credit.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

import 'package:projet/base_donne/servicebasededonnees.dart';

import 'centre_update_credit.dart';

class StreamUpdateCredit extends StatelessWidget {
  StreamUpdateCredit({
    Key? key,
    required this.credit_uid,
  }) : super(key: key);

  final String credit_uid;

  @override
  Widget build(BuildContext context) {
    final _utilisateur = Provider.of<Utilisateur>(context);
    return MultiProvider(
      providers: [
        Provider<serviceBD>(create: (_) => serviceBD()),
        StreamProvider(
            create: ((context) =>
                context.read<serviceBD>().reseau_credit(credit_uid)),
            initialData: credit(
                uid: credit_uid,
                nom: "",
                montant_initial: 0,
                montant_disponible: 0,
                seuil_approvisionnement: 0)),
        StreamProvider(
            create: ((context) => context
                .read<serviceBD>()
                .centre_vente(_utilisateur.uid, credit_uid)),
            initialData: centreVente(
                uid: credit_uid, nom_produit: "", quantite: 0, montant: 0)),
      ],
      child: CentreUpdateCredit(),
    );
  }
}