// ignore_for_file: unused_local_variable, prefer_const_constructors, curly_braces_in_flow_control_structures, unnecessary_null_comparison, dead_code, prefer_typing_uninitialized_variables, unrelated_type_equality_checks, prefer_final_fields, unused_field, must_be_immutable, unused_import, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet/base_donne/servicebasededonnees.dart';

import 'package:projet/interface/accueil.dart';

import 'package:projet/interface/welcome.dart';
import 'package:projet/interface/welcome_default.dart';
import 'package:projet/interface/welcome_gerant.dart';
import 'package:projet/interface/welcome_servant.dart';
import 'package:projet/services/user.dart';

import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebase = Provider.of<Utilisateur>(context);
    final _donnesUtilisateur = Provider.of<donnesUtilisateur>(context);
    if (firebase == null) {
      return Accueil();
    }

    if (firebase != null) {
      if (_donnesUtilisateur.admin == true) return Welcome();

      if (_donnesUtilisateur.role == "Servant") return WelcomeServantPage();
      if (_donnesUtilisateur.is_active == false) return WelcomePage();

      return WelcomePage();
    }

    return WelcomePage();
  }
}
