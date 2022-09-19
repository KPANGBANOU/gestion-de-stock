// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projet/interface/centre_informatique/drawer_admin_centre.dart';

class CentreVenteListProduits extends StatelessWidget {
  const CentreVenteListProduits({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      drawer: DrawerAdminCentre(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigo,
      ),
    );
  }
}
