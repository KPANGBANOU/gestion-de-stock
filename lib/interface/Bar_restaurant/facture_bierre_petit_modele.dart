// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/drawer_servant.dart';

class facturepetitmodele extends StatelessWidget {
  const facturepetitmodele({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      drawer: servantdrawer(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Facturation".toUpperCase(),
          style: TextStyle(
            color: Colors.white.withOpacity(.7),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Facturation de vente".toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Nom du produit :".toUpperCase(),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Coca cocla",
                  style: TextStyle(color: Colors.white.withOpacity(.7)),
                )
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Quantité :".toUpperCase(),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text(
                  "20".toUpperCase(),
                  style: TextStyle(
                      color: Colors.white.withOpacity(.7),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Text(
                "Montant total de vente".toUpperCase(),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
