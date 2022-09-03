// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projet/interface/bottomnavigation.dart';

class InfoEmploye extends StatelessWidget {
  const InfoEmploye({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.greenAccent,
        
        title: const Text("Informations sur l'employé", style: TextStyle(
          color: Colors.white, fontSize: 24,
        ),),
      ),

      body: Center(
        child: const Text("Informations sur l'employé"),
      ),


     bottomNavigationBar: bottomNavigation(),
    );
  }
}
