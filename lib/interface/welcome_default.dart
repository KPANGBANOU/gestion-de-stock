// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:flutter/material.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _donnesUtilisateur = Provider.of<donnesUtilisateur>(context);
    final _utilisateur = Provider.of<Utilisateur>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        title: Text("Déo Gracias"),
      ),
      body: Consumer<donnesUtilisateur>(
        builder: (context, donnes, child) {
          return Center(
            child: Text(donnes.nom.toString()),
          );
        },
      ),
    );
  }
}
