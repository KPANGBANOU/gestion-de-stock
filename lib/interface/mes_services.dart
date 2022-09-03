// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

class MesServices extends StatelessWidget {
  const MesServices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final donnes = Provider.of<donnesUtilisateur?>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.greenAccent,
        title: const Text(
          "Mes offres de services",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      body: Center(
        child: Text("n"),
      ),
    );
  }
}
