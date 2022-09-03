// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_final_fields, unused_field, avoid_init_to_null, avoid_unnecessary_containers, prefer_const_constructors_in_immutables, unused_local_variable, await_only_futures, non_constant_identifier_names, sized_box_for_whitespace, curly_braces_in_flow_control_structures, use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/drawer_servant.dart';
import 'package:projet/modele/bieere_petit_model.dart';

import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

class BarVenteBierrePetitModel extends StatelessWidget {
  BarVenteBierrePetitModel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final utilisateur = Provider.of<Utilisateur>(context);
    final List<donneesBieerePetitModele> _bierre_grand_odels =
        Provider.of<List<donneesBieerePetitModele>>(context);
    return Scaffold(
        drawer: servantdrawer(),
        backgroundColor: Colors.greenAccent,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            "Pétit modèle",
            style: TextStyle(color: Colors.white.withOpacity(.8)),
          ),
        ),
        body: Center(
          child: Text("Bienvenue"),
        ));
  }
}
