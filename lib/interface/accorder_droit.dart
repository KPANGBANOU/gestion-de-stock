// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projet/interface/bottomnavigation.dart';

class DroitsEmployes extends StatelessWidget {
  const DroitsEmployes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.greenAccent,
        
        title: const Text("Droits d'utilisateur", style: TextStyle(
          color: Colors.white, fontSize: 24,
        ),),
      ),

      body: Center(
        child: const Text("Droits des employés"),
      ),


     bottomNavigationBar: bottomNavigation(),
    );
  }
}
