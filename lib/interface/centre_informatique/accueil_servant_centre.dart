// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable, prefer_final_fields, unused_field, prefer_const_constructors, avoid_unnecessary_containers, avoid_init_to_null, curly_braces_in_flow_control_structures, prefer_interpolation_to_compose_strings, non_constant_identifier_names, unused_local_variable, use_build_context_synchronously, dead_code, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

import 'package:projet/interface/centre_informatique/centre_servant_drawer.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

class AccueilServantCentre extends StatelessWidget {
  AccueilServantCentre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final utilisateur = Provider.of<Utilisateur>(context);
    final donnes = Provider.of<donnesUtilisateur>(context);

    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        elevation: 0,
        title: Text(
          donnes.prenom + " " + donnes.nom,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: CentreServantdrawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 4, right: 4),
              child: Text(
                "Déo Gracias".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 3,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 90,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8, top: 1, bottom: 25),
              child: Text(
                "bienvenues ".toUpperCase() +
                    donnes.prenom.toUpperCase() +
                    " " +
                    donnes.nom.toUpperCase() +
                    " sur DéoGracias , l'application de gestion de stock du centre informatique de cette entreprise"
                        .toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontSize: 22,
                    color: Colors.white.withOpacity(.9)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 4.0, right: 4, bottom: 50, top: 50),
              child: Text(
                "Comme règle d'usage de ce logiciel, en tant qu'employé decette entreprise, vous devriez bien enregistré les ventes, les dépenses en cours de service, les achats à crédits et souligner les problèmes que vous rencontriez"
                    .toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    letterSpacing: 1,
                    color: Colors.white.withOpacity(.8),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
