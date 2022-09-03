// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class WelcomeGerantPage extends StatelessWidget {
  const WelcomeGerantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        title: Text("Déo Gracias"),
      ),
    );
  }
}
