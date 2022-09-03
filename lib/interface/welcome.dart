// ignore_for_file: prefer_const_constructors, unused_local_variable, no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers, non_constant_identifier_names, sort_child_properties_last, use_build_context_synchronously, prefer_const_constructors_in_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/first_bottom_navigation_bar.dart';

import 'package:projet/interface/accueil_admin.dart';

import 'package:projet/interface/zoom.dart';
import 'package:projet/parametres_admin.dart';
import 'package:projet/services/change_admin_page.dart';
import 'package:projet/services/registration.dart';

import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firebase = Provider.of<firebaseAuth>(context);
    final utilisateur = Provider.of<Utilisateur?>(context);
    //final donnes=Provider.of<donnesUtilisateur?>(context);
    final _auth = FirebaseAuth.instance.currentUser;
    final changePage = Provider.of<changingAdminPage>(context);

    String prenom = "Marcellin";
    var pages = [
      AccueilAdmin(prenom: prenom),
      ParametresAdmin(),
      Zoom(),
    ];

    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 14.0),
              child: IconButton(
                  onPressed: () {}, icon: Icon(Icons.more_vert_outlined))),
        ],
        centerTitle: true,
        title: const Text(
          "DEO GRACIAS",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.indigo,
        elevation: 0,
      ),
      body: pages[changePage.currentIndex],
      bottomNavigationBar: FirtsBottomNavifgationAdminBar(),
    );
  }
}
