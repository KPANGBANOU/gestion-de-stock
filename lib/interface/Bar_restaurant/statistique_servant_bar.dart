// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_interpolation_to_compose_strings, non_constant_identifier_names, prefer_const_constructors_in_immutables, must_be_immutable, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/statistique_servant_petit_mode.dart';
import 'package:projet/interface/Bar_restaurant/drawer_admin_bar.dart';
import 'package:projet/interface/Bar_restaurant/statistique_general_servant.dart';
import 'package:projet/interface/Bar_restaurant/statistique_servant_grand_modele.dart';
import 'package:projet/modele/vente_credit.dart';

import 'package:projet/modele/vente_grand_modele.dart';
import 'package:projet/modele/vente_petit_modele.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

import 'statiistique_grand_modelecredit.dart';
import 'statistique_credit_servant_bar.dart';
import 'statistique_grandpetitmodele.dart';
import 'statistiquepetitmodelcredit.dart';

class StatistiqueServantBar extends StatelessWidget {
  StatistiqueServantBar({super.key});

  @override
  Widget build(BuildContext context) {
    final _donnesUtilisateur = Provider.of<donnesUtilisateur>(context);
    final _listVentepetitmodel = Provider.of<List<ventePetitModele>>(context);
    final _listVentegrandmodel = Provider.of<List<venteGrandModele>>(context);
    final _list_credits = Provider.of<List<venteCredit>>(context);

    if (_listVentepetitmodel.isEmpty &&
        _listVentegrandmodel.isEmpty &&
        _list_credits.isEmpty) {
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

    if (_listVentepetitmodel.isNotEmpty &&
        _listVentegrandmodel.isEmpty &&
        _list_credits.isEmpty) {
      return StatistiqueServantPetitModel();
    }

    if (_listVentepetitmodel.isEmpty &&
        _listVentegrandmodel.isNotEmpty &&
        _list_credits.isEmpty) {
      return StatistiqueServantGrandModel();
    }

    if (_listVentegrandmodel.isEmpty &&
        _listVentepetitmodel.isEmpty &&
        _list_credits.isNotEmpty) {
      return StatistiqueCreditServantBar();
    }

    if (_listVentegrandmodel.isNotEmpty &&
        _listVentepetitmodel.isNotEmpty &&
        _list_credits.isEmpty) {
      return StatistiqueGrandPetitModele();
    }

    if (_listVentegrandmodel.isEmpty &&
        _listVentepetitmodel.isNotEmpty &&
        _list_credits.isNotEmpty) {
      return StatistiquePetitModeleCredit();
    }

    if (_listVentegrandmodel.isNotEmpty &&
        _list_credits.isNotEmpty &&
        _listVentepetitmodel.isEmpty) {
      return StatistiqueGrandModeleCredit();
    }

    return StatistiqueGeneneralServant();
  }
}
