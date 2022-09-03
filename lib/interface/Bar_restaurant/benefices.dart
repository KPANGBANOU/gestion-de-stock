// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


class BeneficeBar extends StatelessWidget {
  const BeneficeBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

       appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text("Bénéfice réalisée"),
       ),

       body: Center(
        child: Text("Bénéfices"),
       ),

    );
  }
}
