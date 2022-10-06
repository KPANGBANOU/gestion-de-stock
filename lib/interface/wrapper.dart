// ignore_for_file: unused_local_variable, prefer_const_constructors, curly_braces_in_flow_control_structures, unnecessary_null_comparison, dead_code, prefer_typing_uninitialized_variables, unrelated_type_equality_checks, prefer_final_fields, unused_field, must_be_immutable, unused_import, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, avoid_print, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet/base_donne/servicebasededonnees.dart';

import 'package:projet/interface/accueil.dart';
import 'package:projet/interface/centre_informatique/accueil_servant_centre.dart';
import 'package:projet/interface/home.dart';

import 'package:projet/interface/welcome.dart';
import 'package:projet/interface/welcome_default.dart';
import 'package:projet/interface/welcome_servant.dart';
import 'package:projet/modele/bieere_petit_model.dart';
import 'package:projet/modele/bierre_grand_model.dart';
import 'package:projet/modele/credit.dart';
import 'package:projet/modele/produit.dart';
import 'package:projet/services/user.dart';

import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebase = Provider.of<Utilisateur?>(context);
    final _donnnes = Provider.of<donnesUtilisateur>(context);
    final _list_credits = Provider.of<List<credit>>(context);
    final _list_bierres_petit_modele =
        Provider.of<List<donneesBieerePetitModele>>(context);
    final _list_produits_centre = Provider.of<List<products>>(context);
    final _list_bierres_grand_modele =
        Provider.of<List<donnesBierresGrandModel>>(context);

    if (firebase == null) {
      return Accueil();
    }
    if (_donnnes.is_active != true) return Welcome();
    if (_donnnes.admin == true) return HomePage();
    if (_donnnes.role == "Servant") {
      if (_donnnes.domaine == "Bar restaurant") {
        return WelcomeServantPage();
      } else if (_donnnes.domaine == "Centre informatique") {
        return AccueilServantCentre();
      } else
        return Welcome();
    }

    return Welcome();
  }
}
