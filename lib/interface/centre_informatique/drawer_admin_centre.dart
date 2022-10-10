// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, camel_case_types, unused_local_variable, must_be_immutable, prefer_const_constructors_in_immutables, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:projet/interface/centre_informatique/centre_approvisionner_list_produits.dart';
import 'package:projet/interface/centre_informatique/centre_enregistrer_nouveau_produit.dart';
import 'package:projet/interface/centre_informatique/centre_enregistrer_nouveau_reseau_credit.dart';
import 'package:projet/interface/centre_informatique/stream_statistique_centre.dart';
import 'package:projet/interface/centre_informatique/centre_approvisionner_list_reseaux_credit.dart';
import 'package:projet/interface/centre_informatique/centre_benefices.dart';
import 'package:projet/interface/centre_informatique/centre_liquidite_list_credits.dart';
import 'package:projet/interface/centre_informatique/centre_produits.dart';
import 'package:projet/interface/centre_informatique/centre_rubrique_versement.dart';
import 'package:projet/interface/centre_informatique/centre_stock_physique.dart';
import 'package:projet/services/registration.dart';
import 'package:projet/services/user.dart';

import 'package:provider/provider.dart';

import 'approvisionnerlisteeshirt.dart';
import 'centreliquidite_serigraphie.dart';

class DrawerAdminCentre extends StatelessWidget {
  DrawerAdminCentre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firebase = Provider.of<firebaseAuth>(context);
    final _donnesUtilisateur = Provider.of<donnesUtilisateur>(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Padding(
        padding: const EdgeInsets.only(top: 96),
        child: Drawer(
          child: ListView(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SizedBox(
                height: 200,
                child: DrawerHeader(
                    child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    _donnesUtilisateur.sexe == "Masculin"
                        ? CircleAvatar(
                            radius: 56,
                            backgroundColor: Colors.indigoAccent,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: ClipOval(
                                child: Image.asset(
                                  'images/homme.png',
                                  width: 90,
                                  height: 90,
                                  scale: 2.5,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          )
                        : CircleAvatar(
                            radius: 56,
                            backgroundColor: Colors.indigoAccent,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: ClipOval(
                                child: Image.asset(
                                  'images/femme.jpg',
                                  width: 90,
                                  height: 90,
                                  scale: 2.5,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Text(
                            _donnesUtilisateur.prenom.toString() +
                                ' ' +
                                _donnesUtilisateur.nom.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ))
                  ],
                )),
              ),
              ListTile(
                title: Text(
                  "Bar restaurant".toUpperCase(),
                  style: TextStyle(color: Colors.green),
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/bar");
                },
              ),
              ListTile(
                title: Text("Bénéfices et pertes".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => CentreBenefices())));
                },
              ),
              ListTile(
                title: Text("Rubrique de versement".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => CentreRubriqueVersement())));
                },
              ),
              ListTile(
                title: Text("Statistique de vente".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => StreamStatistiqueCentre())));
                },
              ),
              ListTile(
                title: Text("Liquidité de crédit".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              CentreLiquiditeListCredits())));
                },
              ),
              ListTile(
                title: Text("Etat du stock".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              CentreStockPhysiqueListProduits())));
                },
              ),
              ListTile(
                title: Text("Rechargement de crédits".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              CentreApprovisionnerListReseauxCredit())));
                },
              ),
              ListTile(
                title: Text("Approvisionnement de produits".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              CentreApprovisionnerListProduits())));
                },
              ),
              ListTile(
                title: Text("Liquidité de crédit".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              CentreLiquiditeListCredits())));
                },
              ),
              ListTile(
                title: Text("Sérigraphie".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              CentreLiquiditeSerigraphie())));
                },
              ),
              ListTile(
                title: Text("Réchargement de tee-shirts".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              CentreRechargementListTeeShirt())));
                },
              ),
              ListTile(
                title: Text("Liste des produits du centre".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => CentreListProduits())));
                },
              ),
              ListTile(
                title: Text("Nouveau produit".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              CentreEnregistrerNouveauProduit())));
                },
              ),
              ListTile(
                title: Text("Nouveau crédit".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              CentreEnregistrerNouveauReseauCredit())));
                },
              ),
              ListTile(
                title: Text(
                  "Deconnexion".toUpperCase(),
                  style: TextStyle(color: Colors.redAccent),
                ),
                onTap: () async {
                  await _firebase.signOut();
                  Navigator.of(context).pushNamed("/login");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
