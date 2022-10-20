// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable, unnecessary_this

import 'package:flutter/material.dart';
import 'package:projet/base_donne/servicebasededonnees.dart';
import 'package:projet/interface/accoder_droits_second_page.dart';
import 'package:projet/modele/donnesservants.dart';
import 'package:provider/provider.dart';

class StreamAccorderDroitsEmployes extends StatelessWidget {
  StreamAccorderDroitsEmployes({super.key, required this.uid});

  final String uid;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<serviceBD>(create: (_) => serviceBD()),
        StreamProvider(
            create: ((context) => context.read<serviceBD>().servant_data(uid)),
            initialData: donnesServants(
                uid: uid,
                domaine: "",
                photo_url: "",
                admin: false,
                is_active: true)),
      ],
      child: AccorderDroitsSecondPages(),
    );
  }
}
