// ignore_for_file: avoid_unnecessary_containe, avoid_unnecessary_containers, must_be_immutable, prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:projet/interface/accueil_page.dart';
import 'package:projet/interface/bottomnavigation.dart';
import 'package:projet/interface/connexion.dart';
import 'package:projet/interface/contact_entreprise.dart';
import 'package:projet/interface/mes_services.dart';
import 'package:projet/services/change_page.dart';
import 'package:provider/provider.dart';

class Accueil extends StatelessWidget {
  Accueil({Key? key}) : super(key: key);

  var pages = [
    AccueilPage(),
    LoginPage(),
    MesServices(),
    ContactsEntreprise(),
  ];

  @override
  Widget build(BuildContext context) {
    final changeProvider = Provider.of<changingPage>(context);
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: pages[changeProvider.currentIndex],
      bottomNavigationBar: const bottomNavigation(),
    );
  }
}
