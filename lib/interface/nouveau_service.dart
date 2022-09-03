// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class NouveauService extends StatelessWidget {
  const NouveauService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Nouvel service",
          style: TextStyle(color: Colors.white.withOpacity(.8)),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Text("Mon nouveau service"),
      ),
    );
  }
}
