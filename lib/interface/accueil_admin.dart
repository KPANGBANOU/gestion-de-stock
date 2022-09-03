// ignore_for_file: must_be_immutable, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';

class AccueilAdmin extends StatelessWidget {
  AccueilAdmin({Key? key, required this.prenom}) : super(key: key);
  String prenom;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8, top: 50),
        child: Text(
          "${prenom},\n nous vous souhaitons le bienvenue sur DGraciasApp"
              .toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white.withOpacity(1), fontSize: 22),
        ),
      ),
    );
  }
}
