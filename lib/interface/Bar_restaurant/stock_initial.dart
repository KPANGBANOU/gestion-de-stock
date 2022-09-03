// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


class StockInitial extends StatelessWidget {
  const StockInitial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

       appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text("Stock initial"),
       ),

       body: Center(
        child: Text("Stock initial"),
       ),

    );
  }
}
