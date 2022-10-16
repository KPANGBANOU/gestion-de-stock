// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:projet/base_donne/servicebasededonnees.dart';
import 'package:projet/modele/credits_vente.dart';

import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

import 'bar_list_credit_servant.dart';

class StreamListCreditClientServantBar extends StatelessWidget {
  const StreamListCreditClientServantBar({super.key});

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<Utilisateur>(context);
    return MultiProvider(
      providers: [
        Provider<serviceBD>(create: (_) => serviceBD()),
        StreamProvider(
          create: ((context) =>
              context.read<serviceBD>().credits_servant_bar(_user.uid)),
          initialData: <CreditsVente>[],
        ),
      ],
      child: BarListCreditsClientsServant(),
    );
  }
}
