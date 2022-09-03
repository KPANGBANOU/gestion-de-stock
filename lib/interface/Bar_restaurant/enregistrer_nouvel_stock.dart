// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_final_fields, unused_field, dead_code, unused_local_variable, no_leading_underscores_for_local_identifiers, sort_child_properties_last, deprecated_member_use, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, avoid_unnecessary_containers, avoid_init_to_null, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projet/interface/erreur_connection.dart';

class BarEnregistrerNouvelStockFormPage extends StatefulWidget {
  BarEnregistrerNouvelStockFormPage({Key? key}) : super(key: key);

  @override
  State<BarEnregistrerNouvelStockFormPage> createState() =>
      _BarEnregistrerNouvelStockFormPageState();
}

class _BarEnregistrerNouvelStockFormPageState
    extends State<BarEnregistrerNouvelStockFormPage> {
  TextEditingController quantite = TextEditingController();

  final _bierres = FirebaseFirestore.instance.collectionGroup('bierres');
  var selectedCurrency;
  late DocumentSnapshot? category = null;

  String type_bierre = "Pétit modèle";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.7),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("Nouveau stock"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Enregistrement de nouvel stock".toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black.withOpacity(.7),
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                  value: type_bierre,
                  elevation: 16,
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  items: <String>['Pétit modèle', 'Grand modèle']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value, child: Text(value));
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      type_bierre = newValue!;
                    });
                  }),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: _bierres
                  .where("type", isEqualTo: type_bierre)
                  .orderBy("nom", descending: false)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshots) {
                if (snapshots.hasError) {
                  return ErreurConnection();
                }
                if (snapshots.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(
                    color: Colors.greenAccent,
                  );

                  if (!snapshots.hasData) {
                    return Container();
                  }
                }

                return Container(
                    child: DropdownButtonHideUnderline(
                        child: Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15, top: 20),
                  child: DropdownButtonFormField<DocumentSnapshot>(
                      value: category,
                      hint: Text(
                        "Selectionne la bièrre",
                        style: TextStyle(color: Colors.white.withOpacity(.7)),
                      ),
                      onSaved: (newvalue) {
                        setState(() {
                          category = newvalue!;
                        });
                      },
                      items:
                          snapshots.data!.docs.map((DocumentSnapshot document) {
                        return DropdownMenuItem<DocumentSnapshot>(
                            value: document,
                            child: Container(
                              child: Text((document.data()
                                  as Map<String, dynamic>)['nom']),
                            ));
                      }).toList(),
                      onChanged: (newvalue) {
                        setState(() {
                          category = newvalue!;
                        });
                      }),
                )));
              }),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15,
            ),
            child: TextField(
              controller: quantite,
              decoration: InputDecoration(
                labelText: "Quantité".toUpperCase(),
                hintText: "Saisissez la quantité",
                labelStyle: TextStyle(
                  color: Colors.white.withOpacity(.8),
                ),
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(.7),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
