// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projet/interface/bottomnavigation.dart';

class Zoom extends StatelessWidget {
  const Zoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.greenAccent,
        
        title: const Text("Réunion zoom", style: TextStyle(
          color: Colors.white, fontSize: 24,
        ),),
      ),

      body: Center(
        child: const Text("Réunion zoom"),
      ),


     bottomNavigationBar: bottomNavigation(),
    );
  }
}
