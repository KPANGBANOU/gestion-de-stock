// ignore_for_file: prefer_const_constructors, unused_field, prefer_const_constructors_in_immutables, await_only_futures, must_be_immutable, non_constant_identifier_names, unused_local_variable, unused_import, no_leading_underscores_for_local_identifie

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/interface_bar_restaurant.dart';

import 'package:projet/interface/connexion.dart';
import 'package:projet/interface/contact_entreprise.dart';
import 'package:projet/interface/drawer.dart';
import 'package:projet/interface/interface_centre_informatique.dart';
import 'package:projet/modele/donnesservants.dart';
import 'package:projet/services/registration.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  late int nombre_utilisateur = 0;

  @override
  Widget build(BuildContext context) {
    final _donnes = Provider.of<donnesUtilisateur>(context);
    final _users = Provider.of<List<donnesServants>>(context);
    nombre_utilisateur = _users.length;
    return Scaffold(
      drawer: DrawerHome(),
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        // ignore: prefer_const_literals_to_create_immutables

        centerTitle: true,
        title: Text(
          _donnes.prenom + " " + _donnes.nom,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Entreprise Déo Gracias".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    letterSpacing: 2,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Bienvenue sur DéO Gracias".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                color: Colors.indigo,
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TextButton(
                            onPressed: (() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          CentreInterfacePage())));
                            }),
                            child: Text(
                              "Gestion du centre informatique".toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            )),
                        TextButton(
                            onPressed: (() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => Bar())));
                            }),
                            child: Text(
                              "Gestion du restaurant".toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ))
                      ],
                    ),
                    Container(
                      color: Colors.black,
                      width: double.infinity,
                      height: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TextButton(
                            onPressed: (() {}),
                            child: Text(
                              "Nombre d'utilisateurs".toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            )),
                        Text(
                          nombre_utilisateur.toString().toUpperCase(),
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 70,
              )
            ]),
      ),
    );
  }
}
