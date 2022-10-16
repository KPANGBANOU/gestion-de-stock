// ignore_for_file: prefer_const_constructors_in_immutables, non_constant_identifier_names, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:projet/base_donne/servicebasededonnees.dart';
import 'package:projet/modele/depense_centre.dart';
import 'package:projet/services/user.dart';

import 'depense_servant_centre.dart';

class StreamDepenseServantCentre extends StatelessWidget {
  StreamDepenseServantCentre({
    Key? key,
    required this.depense_uid,
  }) : super(key: key);

  final String depense_uid;

  @override
  Widget build(BuildContext context) {
    final _utilisateur = Provider.of<Utilisateur>(context);
    return MultiProvider(
      providers: [
        Provider<serviceBD>(create: (_) => serviceBD()),
        StreamProvider(
            create: ((context) =>
                context.read<serviceBD>().depense_centre(depense_uid)),
            initialData: DepenseCentre(
                uid: depense_uid,
                description: "",
                montant: 0,
                date: "",
                user_nom: "",
                user_prenom: "",
                user_uid: "")),
      ],
      child: DepenseServantCentre(),
    );
  }
}
