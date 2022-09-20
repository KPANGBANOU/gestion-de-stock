// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, sort_child_properties_last, unused_local_variable, must_be_immutable, prefer_final_fields, unused_field, prefer_const_constructors_in_immutables, no_leading_underscores_for_local_identifiers, unused_import, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/accueil_servant_bar.dart';
import 'package:projet/interface/Bar_restaurant/drawer_servant.dart';
import 'package:projet/interface/Bar_restaurant/notification_servant_bar.dart';
import 'package:projet/interface/Bar_restaurant/servant_bottomn_navigation.dart';
import 'package:projet/interface/contact_entreprise.dart';

import 'package:projet/interface/mes_services.dart';
import 'package:projet/services/change_servant_page.dart';
import 'package:projet/services/registration.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

import 'centre_servant_bottom.dart';
import 'centre_servant_drawer.dart';

class WelcomeServantCentre extends StatelessWidget {
  WelcomeServantCentre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final utilisateur = Provider.of<Utilisateur?>(context);
    final _firebase = Provider.of<firebaseAuth>(context);
    final changePage = Provider.of<changingServantPage>(context);

    var pages = [
      AccueilServantBar(),
      NotificationServantBar(),
      ContactsEntreprise(),
      MesServices(),
    ];

    return Scaffold(
      backgroundColor: Colors.greenAccent,
      drawer: CentreServantdrawer(),
      appBar: AppBar(
        backgroundColor: Colors.indigo.withOpacity(.8),
        bottomOpacity: 0,
        centerTitle: true,
        elevation: 0,
        title: Text("Deo gracias".toUpperCase()),
      ),
      body: pages[changePage.currentIndex],
      bottomNavigationBar: CentreServantbottomNavigation(),
    );
  }
}
