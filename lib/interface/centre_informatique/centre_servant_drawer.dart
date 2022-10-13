// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, camel_case_types, unused_local_variable, must_be_immutable, prefer_const_constructors_in_immutables, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:projet/interface/centre_informatique/centre_vente_list_credits.dart';
import 'package:projet/services/registration.dart';
import 'package:projet/services/user.dart';

import 'package:provider/provider.dart';

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
                title: Text("Vente de crédit".toUpperCase()),
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
                title: Text("Enregistrer une dépense".toUpperCase()),
                onTap: () {
                  Navigator.pushNamed(context, "/centreenregistrerdepense");
                },
              ),
              ListTile(
                title: Text("Signaler un problème".toUpperCase()),
                onTap: () {
                  Navigator.pushNamed(context, "/centreenregistrerprobleme");
                },
              ),
              ListTile(
                title: Text("Désactiver mon compte".toUpperCase()),
                onTap: () {
                  Navigator.pushNamed(context, "/desactivercompte");
                },
              ),
              ListTile(
                title: Text(
                  "Supprimer mon compte".toUpperCase(),
                  style: TextStyle(color: Colors.redAccent.withOpacity(.7)),
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/supprimercompte");
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
                  "Déconnexion".toUpperCase(),
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
