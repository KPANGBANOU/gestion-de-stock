// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_interpolation_to_compose_strings, non_constant_identifier_names, prefer_const_constructors_in_immutables, must_be_immutable, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/statistique_servant_petit_mode.dart';
import 'package:projet/interface/Bar_restaurant/drawer_admin_bar.dart';
import 'package:projet/interface/Bar_restaurant/statistique_general_servant.dart';
import 'package:projet/interface/Bar_restaurant/statistique_servant_grand_modele.dart';

import 'package:projet/modele/vente_grand_modele.dart';
import 'package:projet/modele/vente_petit_modele.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

class StatistiqueServantBar extends StatelessWidget {
  StatistiqueServantBar({super.key});

  @override
  Widget build(BuildContext context) {
    final _donnesUtilisateur = Provider.of<donnesUtilisateur>(context);
    final _listVentepetitmodel = Provider.of<List<ventePetitModele>>(context);
    final _listVentegrandmodel = Provider.of<List<venteGrandModele>>(context);

    if (_listVentepetitmodel.isEmpty && _listVentegrandmodel.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.greenAccent,
        drawer: DrawerAdminBar(),
        appBar: AppBar(
          title: Text(
            _donnesUtilisateur.prenom.toString() +
                " " +
                _donnesUtilisateur.nom.toString(),
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.indigo,
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_listVentepetitmodel.isNotEmpty && _listVentegrandmodel.isEmpty) {
      return StatistiqueServantPetitModel();
    }

    if (_listVentepetitmodel.isEmpty && _listVentegrandmodel.isNotEmpty) {
      return StatistiqueServantGrandModel();
    }

    return StatistiqueGeneneralServant();
  }
}
