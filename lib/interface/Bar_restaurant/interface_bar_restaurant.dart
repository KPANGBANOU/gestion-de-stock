// ignore_for_file: prefer_const_constructors, sort_child_properties_last, must_be_immutable, unused_field, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, prefer_const_constructors_in_immutables, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, unused_local_variable

import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/drawer_admin_bar.dart';
import 'package:projet/services/registration.dart';
import 'package:projet/services/user.dart';
import 'package:provider/provider.dart';

class Bar extends StatelessWidget {
  Bar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firebase = Provider.of<firebaseAuth>(context);

    final utilisateur = Provider.of<Utilisateur?>(context);
    final _donnesUtilisateur = Provider.of<donnesUtilisateur>(context);
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      drawer: DrawerAdminBar(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Bar restaurant ",
          style: TextStyle(
              color: Colors.white.withOpacity(.8),
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Text("Gestion"),
      ),
    );
  }
}
