// ignore_for_file: prefer_const_constructors_in_immutables, non_constant_identifier_names, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:flutter/material.dart';
import 'package:projet/modele/serigraphie.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

import 'package:projet/base_donne/servicebasededonnees.dart';

import 'update_tee_shirt.dart';

class StreamUpdateTeeShirt extends StatelessWidget {
  StreamUpdateTeeShirt({
    Key? key,
    required this.tee_shirt_uid,
  }) : super(key: key);

  final String tee_shirt_uid;

  @override
  Widget build(BuildContext context) {
    final _utilisateur = Provider.of<Utilisateur>(context);
    return MultiProvider(
      providers: [
        Provider<serviceBD>(create: (_) => serviceBD()),
        StreamProvider(
            create: ((context) =>
                context.read<serviceBD>().tee_shirt(tee_shirt_uid)),
            initialData: serigraphie(
                approvisionne: true,
                qualite: "",
                montant_vendu: 0,
                prix_unitaire_achat: 0,
                benefice: 0,
                uid: tee_shirt_uid,
                tee_shirt_nom: "",
                quantite_initial: 0,
                quantite_physique: 0,
                seuil_approvisionnement: 0,
                prix_unitaire_vente: 0)),
      ],
      child: UpdateTeeShirt(),
    );
  }
}
