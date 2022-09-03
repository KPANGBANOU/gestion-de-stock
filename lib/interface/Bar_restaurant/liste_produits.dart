// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


class ListeProduits extends StatelessWidget {
  const ListeProduits({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

       appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text("Différentes bières"),
       ),

       body: Center(
        child: Text("Liste bières"),
       ),

    );
  }
}
