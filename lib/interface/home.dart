// ignore_for_file: prefer_const_constructors, unused_field, prefer_const_constructors_in_immutables, await_only_futures, must_be_immutable, non_constant_identifier_names, unused_local_variable, unused_import, no_leading_underscores_for_local_identifie

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerHome(),
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14.0),
            child: Icon(Icons.more_vert_outlined),
          ),
        ],
        centerTitle: true,
        title: Text(
          "DEO GRACIAS",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.indigo,
        elevation: 0,
      ),
      body: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [Text("bonjour")]),
      bottomNavigationBar: bottomNavigationHome(),
    );
  }
}
