// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable, unnecessary_this

import 'package:flutter/material.dart';
import 'package:projet/base_donne/servicebasededonnees.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

import 'accoder_droits_first_page.dart';

class StreamAccorderDroitsEmployes extends StatelessWidget {
  StreamAccorderDroitsEmployes({super.key, required this.email});

  final String email;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      Provider<serviceBD>(create: (_)=> serviceBD()),
      StreamProvider(create: ((context) => context.read<serviceBD>().infoEmploye(this.email)), initialData: const <donnesUtilisateur>[])
    ],
    child: AccorderDroitsFirstPage(),);
  }
}
