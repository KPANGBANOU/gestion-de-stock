// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class VenteDuServantBar extends StatelessWidget {
  const VenteDuServantBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Nom du servant",
          style: TextStyle(color: Colors.white.withOpacity(.8), fontSize: 22),
        ),
      ),
      body: Center(
        child: Text("Vente du servant"),
      ),
    );
  }
}
