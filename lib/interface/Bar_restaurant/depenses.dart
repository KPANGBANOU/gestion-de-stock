// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class DepensesBar extends StatelessWidget {
  const DepensesBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text("Dépenses"),
      ),
      body: Center(
        child: Text("Dépenses"),
      ),
    );
  }
}
