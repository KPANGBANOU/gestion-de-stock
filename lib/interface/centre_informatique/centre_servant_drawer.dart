// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, camel_case_types, unused_local_variable, must_be_immutable, prefer_const_constructors_in_immutables, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:projet/interface/centre_informatique/centre_vente_list_credits.dart';
import 'package:projet/interface/centre_informatique/stream_statistique_journalier_vente_servant_centre.dart';
import 'package:projet/services/registration.dart';
import 'package:projet/services/user.dart';

import 'package:provider/provider.dart';

import 'centre_enregistrer_credit_client.dart';
import 'parametre_servant_centre.dart';
import 'stream_list_credit_client_servant_centre.dart';
import 'stream_list_depense_servant_centre.dart';
import 'stream_list_probleme_servant_centre.dart';
import 'stream_statistique_credit_servant_centre.dart';
import 'vente_list_tee_shirt.dart';

class CentreServantdrawer extends StatelessWidget {
  CentreServantdrawer({Key? key}) : super(key: key);

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
                    Image.asset(
                      'images/homme.png',
                      width: 90,
                      height: 90,
                      scale: 2.5,
                      fit: BoxFit.contain,
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
                title: Text("Vente de cr??dit".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => CentreVenteListCredits())));
                },
              ),
              ListTile(
                title: Text("Vente de tee-shirts".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => VenteListTeeShirt())));
                },
              ),
              ListTile(
                title: Text("vente de produits".toUpperCase()),
                onTap: () {
                  Navigator.pushNamed(context, "/centreventelistproduit");
                },
              ),
              ListTile(
                title: Text("Enregistrer une d??pense".toUpperCase()),
                onTap: () {
                  Navigator.pushNamed(context, "/centreenregistrerdepense");
                },
              ),
              ListTile(
                title: Text("Enregistrer le cr??dit d'un client".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              CentreEnregistrerCreditClient())));
                },
              ),
              ListTile(
                title: Text("Signaler un probl??me".toUpperCase()),
                onTap: () {
                  Navigator.pushNamed(context, "/centreenregistrerprobleme");
                },
              ),
              ListTile(
                title: Text("Param??tres".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => ParametreServantCentre())));
                },
              ),
              ListTile(
                title: Text("Cr??dits des clients".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              StreamListCreditClientServantCentre())));
                },
              ),
              ListTile(
                title: Text("Statistique journalier de vente".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              StreamStatistiqueJournalierVenteServantCentre())));
                },
              ),
              ListTile(
                title: Text("Statistique de cr??dits clients".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              StreamStatistiqueCreditsServantCentre())));
                },
              ),
              ListTile(
                title: Text("D??penses enregistr??s".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              StreamListDepenseServantCentre())));
                },
              ),
              ListTile(
                title: Text("Probl??mes enregistr??s".toUpperCase()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              StreamListProblemeServantCentre())));
                },
              ),
              ListTile(
                title: Text("Mon profil".toUpperCase()),
                onTap: () {
                  Navigator.pushNamed(context, "/profil");
                },
              ),
              ListTile(
                title: Text(
                  "D??connexion".toUpperCase(),
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
