// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


class NouveauApprovisionnement extends StatelessWidget {
  const NouveauApprovisionnement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

       appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text("Nouvel achat"),
       ),

       body: Center(
        child: Text("Nouvel achat"),
       ),

    );
  }
}
