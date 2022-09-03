// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


class PertesBar extends StatelessWidget {
  const PertesBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

       appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text("Pertes"),
       ),

       body: Center(
        child: Text("Pertes"),
       ),

    );
  }
}
