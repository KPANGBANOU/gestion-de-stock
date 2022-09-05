// ignore_for_file: prefer_const_constructors, must_be_immutable, unused_field, dead_code, sort_child_properties_last, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BarListeBierresPage extends StatelessWidget {
  BarListeBierresPage({Key? key}) : super(key: key);
  final _bierres = FirebaseFirestore.instance.collection('bierres').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _bierres,
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> streamsnapshot) {
          if (streamsnapshot.hasError) return Container();
          if (streamsnapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              backgroundColor: Colors.greenAccent,
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.cyanAccent,
                ),
              ),
            );

            if (!streamsnapshot.hasData) {
              return Scaffold(
                backgroundColor: Colors.white.withOpacity(.5),
                appBar: AppBar(
                  centerTitle: true,
                  elevation: 0,
                  title: Text("Biàrres en stock"),
                ),
                body: Center(
                  child: Text("Aucune bierre disponible en stock"),
                ),
              );
            }
          }

          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                elevation: 0,
                title: Text("Biàrres en stock"),
              ),
              body: Center());
        });
  }
}
