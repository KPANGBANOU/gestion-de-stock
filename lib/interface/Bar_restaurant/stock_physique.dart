// ignore_for_file: prefer_const_constructors, dead_code, curly_braces_in_flow_control_structures, sized_box_for_whitespace, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class StockPhysique extends StatelessWidget {
  StockPhysique({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            "Stock pétit modèle",
            style: TextStyle(color: Colors.white.withOpacity(.8), fontSize: 20),
          ),
          backgroundColor: Colors.indigo,
        ),
        body: Center(
          child: Text("Etat de stock"),
        ));
  }
}
