// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable, prefer_final_fields, unused_field, prefer_const_constructors, avoid_unnecessary_containers, avoid_init_to_null, curly_braces_in_flow_control_structures, prefer_interpolation_to_compose_strings, non_constant_identifier_names, unused_local_variable, use_build_context_synchronously, dead_code, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

class AccueilServantCentre extends StatelessWidget {
  AccueilServantCentre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final utilisateur = Provider.of<Utilisateur>(context);
    final donnes = Provider.of<donnesUtilisateur?>(context);

    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "DGraciasApp",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 90,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8,
                top: 8,
              ),
              child: Text(
                donnes!.nom.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8, top: 1, bottom: 25),
              child: Text(
                "Soyez les bienvenues sur DGraciasApp".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22, color: Colors.white.withOpacity(.9)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10, bottom: 20, top: 50),
              child: Text(
                "Pour enregistrer vous ventes de bierres , veuillez choisir le type de modèle dans le menu à gauche et renseignez bien les champs",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white.withOpacity(.8),
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
