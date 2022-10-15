// ignore_for_file: prefer_const_constructors_in_immutables, non_constant_identifier_names, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:flutter/material.dart';
import 'package:projet/modele/credits_servants.dart';

import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

import 'package:projet/base_donne/servicebasededonnees.dart';

import 'centre_credit_client.dart';

class StreamCreditClient extends StatelessWidget {
  StreamCreditClient({
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
                context.read<serviceBD>().credit_servant(credit_uid)),
            initialData: CreditsServants(
                statut: false,
                nom_client: "",
                prenom_client: "",
                description: "",
                montant: 0,
                date_vente: "",
                uid: credit_uid)),
      ],
      child: CentreCreditClient(),
    );
  }
}
