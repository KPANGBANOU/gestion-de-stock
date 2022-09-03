// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ParametresAdmin extends StatelessWidget {
  const ParametresAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Administrateur",
          style: TextStyle(
              color: Colors.white.withOpacity(.8),
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigoAccent,
      ),
      body: Center(
        child: Text("Administrateur"),
      ),
    );
  }
}
