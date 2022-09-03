// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


class ApprovisionnementBar extends StatelessWidget {
  const ApprovisionnementBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

       appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text("Approvisionnement"),
       ),

       body: Center(
        child: Text("Approvisionnement"),
       ),

    );
  }
}
