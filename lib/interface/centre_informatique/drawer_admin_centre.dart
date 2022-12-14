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
import 'centre_list_credit.dart';
import 'centre_list_tee_shirt.dart';
import 'centreliquidite_serigraphie.dart';
import 'list_depense_employe_centre.dart';
import 'list_probleme_employe_centre.dart';
import 'list_vente_credit_employe_centre.dart';
import 'stream_statistique_journalier_list_employe_centre.dart';

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
                title: Text("B??n??fices et pertes".toUpperCase()),
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
                title: Text("Statistique journalier de vente".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              StreamStatistiqueJournalierListEmployeCentre())));
                },
              ),
              ListTile(
                title: Text("Probl??mes des employ??s".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              ListProblemeEmployesCentre())));
                },
              ),
              ListTile(
                title: Text("D??penses effectu??es".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => ListDepenseEmployeCentre())));
                },
              ),
              ListTile(
                title: Text("Ventes ?? cr??dits enregistr??es".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              ListVenteCreditsEmployeCentre())));
                },
              ),
              ListTile(
                title: Text("Liquidit?? de cr??dit".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              CentreLiquiditeListCredits())));
                },
              ),
              ListTile(
                title: Text("Etat du stock des produits".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              CentreStockPhysiqueListProduits())));
                },
              ),
              ListTile(
                title: Text("Rechargement de cr??dits".toUpperCase()),
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
                title: Text("Liquidit?? de cr??dit".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              CentreLiquiditeListCredits())));
                },
              ),
              ListTile(
                title: Text("S??rigraphie".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              CentreLiquiditeSerigraphie())));
                },
              ),
              ListTile(
                title: Text("R??chargement de tee-shirts".toUpperCase()),
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
                title: Text("Liste des cr??dits".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => CentreListCredits())));
                },
              ),
              ListTile(
                title: Text("Liste des tee shirts".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => CentreListTeeShirt())));
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
                title: Text("Nouveau cr??dit".toUpperCase()),
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
