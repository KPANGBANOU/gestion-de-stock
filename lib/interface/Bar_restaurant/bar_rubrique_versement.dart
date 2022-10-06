// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_interpolation_to_compose_strings, non_constant_identifier_names, prefer_const_constructors_in_immutables, must_be_immutable, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/drawer_admin_bar.dart';
import 'package:projet/modele/bieere_petit_model.dart';
import 'package:projet/modele/bierre_grand_model.dart';

import 'package:provider/provider.dart';

import 'rubrique_bar_grand_model.dart';
import 'rubrique_general_bar.dart';
import 'rubrique_petit_model.dart';

class BarRubriqueVersement extends StatelessWidget {
  BarRubriqueVersement({super.key});

  @override
  Widget build(BuildContext context) {
    final _listpetitmodel =
        Provider.of<List<donneesBieerePetitModele>>(context);
    final _listgrandmodel = Provider.of<List<donnesBierresGrandModel>>(context);

    if (_listpetitmodel.isEmpty && _listgrandmodel.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.greenAccent,
        drawer: DrawerAdminBar(),
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

    if (_listpetitmodel.isNotEmpty && _listgrandmodel.isEmpty) {
      return RubriquePetitModel();
    }

    if (_listpetitmodel.isEmpty && _listgrandmodel.isNotEmpty) {
      return RubriqueGrandModel();
    }

    return RubriqueGeneralBar();
  }
}
