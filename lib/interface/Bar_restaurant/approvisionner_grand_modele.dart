// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_final_fields, unused_field, dead_code, unused_local_variable, no_leading_underscores_for_local_identifiers, sort_child_properties_last, deprecated_member_use, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, avoid_unnecessary_containers, avoid_init_to_null, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/drawer_admin_bar.dart';
import 'package:projet/interface/Bar_restaurant/my_filter.dart';
import 'package:projet/modele/bieere_petit_model.dart';
import 'package:provider/provider.dart';

import '../../services/user.dart';

class BarEnregistrerNouvelStockFormPage extends StatefulWidget {
  BarEnregistrerNouvelStockFormPage({Key? key}) : super(key: key);

  @override
  State<BarEnregistrerNouvelStockFormPage> createState() =>
      _BarEnregistrerNouvelStockFormPageState();
}

class _BarEnregistrerNouvelStockFormPageState
    extends State<BarEnregistrerNouvelStockFormPage> {
  TextEditingController quantite = TextEditingController();

  var selectedCurrency;
  late DocumentSnapshot? category = null;

  String type_bierre = "Pétit modèle";
  @override
  Widget build(BuildContext context) {
    final listBierres = Provider.of<List<donneesBieerePetitModele>>(context);
    final _utilisateur = Provider.of<Utilisateur>(context);
    return Scaffold(
      drawer: DrawerAdminBar(),
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("Nouveau stock"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 70,
            ),
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
            Container(
                child: DropdownButtonHideUnderline(
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15, top: 20),
                        child: DropdownButtonFormField<DocumentSnapshot>(
                            value: category,
                            hint: Text(
                              "Selectionne la bièrre",
                            ),
                            onSaved: (newvalue) {
                              setState(() {
                                category = newvalue!;
                              });
                            },
                            items: listBierres.map((donnesBierres) {
                              return DropdownMenuItem<DocumentSnapshot>(
                                  value: null,
                                  child: Container(
                                      child: Text(
                                    (donnesBierres.nom.toString()),
                                  )));
                            }).toList(),
                            onChanged: (newvalue) {
                              setState(() {
                                category = newvalue!;
                              });
                            })))),
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
                keyboardType: TextInputType.number,
                inputFormatters: [MyFilter()],
                decoration: InputDecoration(
                  labelText: "Quantité".toUpperCase(),
                  hintText: "Saisissez la quantité",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
