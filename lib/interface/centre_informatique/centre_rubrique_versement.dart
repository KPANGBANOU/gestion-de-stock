// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_interpolation_to_compose_strings, non_constant_identifier_names, prefer_const_constructors_in_immutables, must_be_immutable, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:projet/interface/centre_informatique/drawer_admin_centre.dart';
import 'package:projet/modele/credit.dart';
import 'package:projet/modele/produit.dart';
import 'package:projet/modele/serigraphie.dart';

import 'package:provider/provider.dart';

import 'centre_rubrique_general.dart';
import 'rubrique_credit.dart';
import 'rubrique_credit_produit.dart';
import 'rubrique_credit_tee_shirt.dart';
import 'rubrique_produit_tee_shirt.dart';
import 'rubrique_produits.dart';
import 'rubrique_tee_shirt.dart';

class CentreRubriqueVersement extends StatelessWidget {
  CentreRubriqueVersement({super.key});

  @override
  Widget build(BuildContext context) {
    final _listproduits = Provider.of<List<products>>(context);
    final _listcredits = Provider.of<List<credit>>(context);
    final _list_tee_shirts = Provider.of<List<serigraphie>>(context);

    if (_listproduits.isEmpty &&
        _listcredits.isEmpty &&
        _list_tee_shirts.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.greenAccent,
        drawer: DrawerAdminCentre(),
        appBar: AppBar(
          title: Text(
            "Rubrique de versement",
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

    if (_listproduits.isNotEmpty &&
        _listcredits.isEmpty &&
        _list_tee_shirts.isEmpty) {
      return RubriqueProduit();
    }

    if (_listproduits.isEmpty &&
        _listcredits.isNotEmpty &&
        _list_tee_shirts.isEmpty) {
      return RubriqueCredit();
    }

    if (_listproduits.isEmpty &&
        _listcredits.isEmpty &&
        _list_tee_shirts.isNotEmpty) {
      return RubriqueTeeShirt();
    }

    if (_listproduits.isEmpty &&
        _listcredits.isNotEmpty &&
        _list_tee_shirts.isNotEmpty) {
      return RubriqueCreditTeeShirt();
    }

    if (_listproduits.isNotEmpty &&
        _listcredits.isNotEmpty &&
        _list_tee_shirts.isEmpty) {
      return RubriqueCreditProduit();
    }

    if (_listproduits.isNotEmpty &&
        _listcredits.isEmpty &&
        _list_tee_shirts.isNotEmpty) {
      return RubriqueProduitTeeShirt();
    }

    return RubriqueGeneralCentre();
  }
}
