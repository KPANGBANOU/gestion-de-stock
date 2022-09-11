// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

class DesactiverCompte extends StatelessWidget {
  const DesactiverCompte({super.key});

  @override
  Widget build(BuildContext context) {
    final _donnesUser = Provider.of<donnesUtilisateur>(context);
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          _donnesUser.prenom.toString() + " " + _donnesUser.nom.toString(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Text("Desactivation de compte"),
      ),
    );
  }
}
