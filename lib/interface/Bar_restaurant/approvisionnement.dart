// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/drawer_admin_bar.dart';

class ApprovisionnementBar extends StatelessWidget {
  ApprovisionnementBar({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerAdminBar(),
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
