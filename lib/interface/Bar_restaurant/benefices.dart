// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/drawer_admin_bar.dart';

class BeneficeBar extends StatelessWidget {
  const BeneficeBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerAdminBar(),
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
