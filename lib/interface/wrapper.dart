// ignore_for_file: unused_local_variable, prefer_const_constructors, curly_braces_in_flow_control_structures, unnecessary_null_comparison, dead_code, prefer_typing_uninitialized_variables, unrelated_type_equality_checks, prefer_final_fields, unused_field, must_be_immutable, unused_import, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

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
import 'package:projet/services/user.dart';

import 'package:provider/provider.dart';

import '../modele/bieere_petit_model.dart';
import '../modele/bierre_grand_model.dart';
import '../modele/budgetBar.dart';
import '../modele/budget_centre.dart';
import '../modele/depense.dart';
import '../modele/produit.dart';

class Wrapper extends StatelessWidget {
  Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebase = Provider.of<Utilisateur?>(context);

    if (firebase == null) {
      return Accueil();
    } else {
      return MultiProvider(
        providers: [
          Provider<serviceBD>(create: (_) => serviceBD()),
          StreamProvider(
              create: ((context) => context
                  .read<serviceBD>()
                  .donnes(FirebaseAuth.instance.currentUser!.uid)),
              initialData: donnesUtilisateur(
                  uid: "",
                  nom: "",
                  prenom: "",
                  email: "",
                  telephone: "",
                  role: "",
                  sexe: "",
                  date_naissance: "",
                  admin: false,
                  is_active: true)),

          StreamProvider(
              create: ((context) =>
                  context.read<serviceBD>().list_produits_centre),
              initialData: <produits>[]),
          StreamProvider(
              create: ((context) => context.read<serviceBD>().budgetBardata),
              initialData: BudgetBar(solde_total: 0, depense: 0, uid: "")),
          StreamProvider(
              create: (context) => context.read<serviceBD>().budgetcentredata,
              initialData: budgetCentre(solde_total: 0, depense: 0, uid: "")),
          // list ge grand modeles de bierres
          StreamProvider(
              create: ((context) =>
                  context.read<serviceBD>().lisBiarGrandModel),
              initialData: const <donnesBierresGrandModel>[]),
          // list de petit model de bierres

          StreamProvider(
              create: ((context) =>
                  context.read<serviceBD>().listDonnesBierresPetitModele),
              initialData: const <donneesBieerePetitModele>[]),

          // list de vente

          StreamProvider(
              create: ((context) => context
                  .read<serviceBD>()
                  .mesdepense(FirebaseAuth.instance.currentUser!.uid)),
              initialData: const <donnesDepense>[]),
          // list of user

          StreamProvider(
              create: (context) =>
                  context.read<serviceBD>().listDonnesUtilisateur,
              initialData: const <donnesUtilisateur>[]),
        ],
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(firebase.uid)
                .snapshots(),
            builder: ((context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  backgroundColor: Colors.greenAccent,
                  appBar: AppBar(
                    centerTitle: true,
                    elevation: 0,
                    title: Text(
                      "Déo Gracias",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: Colors.indigo,
                  ),
                  body: Center(
                    child: Text(
                      "Une erreur intattendue s'est produite. Vérifiez votre connection internet et réssayez !"
                          .toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.redAccent.withOpacity(.7),
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  backgroundColor: Colors.greenAccent,
                  body: Center(
                    child: Text(
                      "Déo Gracias".toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          letterSpacing: 2),
                    ),
                  ),
                );
              }

              if (!snapshot.hasData) {
                return Scaffold(
                  backgroundColor: Colors.greenAccent,
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if ((snapshot.data as DocumentSnapshot)['role'] == "Servant") {
                if ((snapshot.data as DocumentSnapshot)['domaine'] ==
                    "Barrestaurant") {
                  return WelcomeServantPage();
                } else if ((snapshot.data as DocumentSnapshot)['domaine'] ==
                    "Centre informatique") {
                  return AccueilServantCentre();
                } else
                  return WelcomePage();
              }

              if ((snapshot.data as DocumentSnapshot)['is_active'] != true) {
                return Welcome();
              }

              if ((snapshot.data as DocumentSnapshot)['admin'] == true)
                return HomePage();

              return WelcomePage();
            })),
      );
    }

    return WelcomePage();
  }
}
