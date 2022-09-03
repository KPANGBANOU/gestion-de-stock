// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projet/interface/bottomnavigation.dart';

class ListeUtilisateurs extends StatelessWidget {
  const ListeUtilisateurs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.greenAccent,
        
        title: const Text("Liste des employés", style: TextStyle(
          color: Colors.white, fontSize: 24,
        ),),
      ),

      body: Center(
        child: const Text("Liste des employés"),
      ),


     bottomNavigationBar: bottomNavigation(),
    );
  }
}
