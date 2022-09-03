// ignore_for_file: prefer_const_constructors, unused_field, prefer_const_constructors_in_immutables, await_only_futures, must_be_immutable, non_constant_identifier_names, unused_local_variable, unused_import, no_leading_underscores_for_local_identifiers

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet/interface/bottomnavigationhome.dart';
import 'package:projet/interface/connexion.dart';
import 'package:projet/interface/contact_entreprise.dart';
import 'package:projet/interface/drawer.dart';
import 'package:projet/services/registration.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);


  final LoginPage _loginPage = LoginPage();
  final Service _service = Service();
  final ContactsEntreprise _contactsEntreprise = ContactsEntreprise();
  final _affiche = HomePage();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Scaffold(
        backgroundColor: Colors.green.withOpacity(0.7),
        drawer: DrawerHome(),
        appBar: AppBar(
          // ignore: prefer_const_literals_to_create_immutables
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 14.0),
              child: Icon(Icons.more_vert_outlined),
            ),
          ],
          centerTitle: true,
          title: const Text(
            "DEO GRACIAS",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          backgroundColor: Colors.green,
          elevation: 0,
        ),
        body:Expanded(
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  color: Colors.black.withOpacity(.7),
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/mesServices");
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Mes Services",
                              style: TextStyle(color: Colors.grey, fontSize: 17),
                            ),
                          )),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/messagerie");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Messagrie génrale",
                            style: TextStyle(color: Colors.grey, fontSize: 17),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/messenger");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Messenger",
                            style: TextStyle(color: Colors.grey, fontSize: 17),
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/zoom");
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Réunion en ligne",
                              style: TextStyle(color: Colors.grey, fontSize: 17),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Marcellin",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      "bg",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: bottomNavigationHome(),
      ),
    );
  }
}
