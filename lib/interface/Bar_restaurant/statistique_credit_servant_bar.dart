// ignore_for_file: must_be_immutable, no_leading_underscores_for_local_identifiers, avoid_function_literals_in_foreach_calls, non_constant_identifier_names, prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projet/interface/Bar_restaurant/drawer_admin_bar.dart';
import 'package:projet/modele/credit.dart';

import 'package:provider/provider.dart';

import '../../modele/donnesservants.dart';
import '../../modele/vente_credit.dart';

class StatistiqueCreditServantBar extends StatelessWidget {
  StatistiqueCreditServantBar({super.key});
  late int credit_lenght = 0;
  late double credit_sizebox = 0;
  late int total_credit = 0;
  late int nombre_vente_credit = 0;
  late int montant_credit = 0;

  @override
  Widget build(BuildContext context) {
    final _donnesUtilisateur = Provider.of<donnesServants>(context);
    final _listVenteCredit = Provider.of<List<venteCredit>>(context);
    final _list_credit = Provider.of<List<credit>>(context);
    credit_lenght = _list_credit.length;

    _listVenteCredit.forEach((element) {
      total_credit = total_credit + element.montant;
    });

    if (credit_lenght <= 5) {
      credit_sizebox = 180;
    } else if (credit_lenght <= 20) {
      credit_sizebox = 350;
    } else if (credit_lenght <= 30) {
      credit_sizebox = 500;
    } else if (credit_lenght <= 50) {
      credit_sizebox = 600;
    } else {
      credit_sizebox = MediaQuery.of(context).size.height;
    }

    if (_listVenteCredit.isEmpty || _list_credit.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.greenAccent,
        drawer: DrawerAdminBar(),
        appBar: AppBar(
          title: Text(
            _donnesUtilisateur.prenom.toString() +
                " " +
                _donnesUtilisateur.nom.toString(),
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.indigo,
        ),
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    }

    return Scaffold(
        backgroundColor: Colors.greenAccent,
        drawer: DrawerAdminBar(),
        appBar: AppBar(
          title: Text(
            _donnesUtilisateur.prenom.toString() +
                " " +
                _donnesUtilisateur.nom.toString(),
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.indigo,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Statistique g??n??rale de vente de ".toUpperCase() +
                      _donnesUtilisateur.prenom.toString().toUpperCase() +
                      "  " +
                      _donnesUtilisateur.nom.toString().toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                color: Colors.redAccent.withOpacity(.7),
                width: double.infinity,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Vente de cr??dits".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 0,
              ),
              Container(
                color: Colors.indigo,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        "Cr??dit",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Montant vendu",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: credit_sizebox,
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: ((context, index) {
                      credit _credit = _list_credit[index];

                      nombre_vente_credit = 0;
                      montant_credit = 0;

                      _listVenteCredit.forEach((element) {
                        if (element.nom == _credit.nom) {
                          nombre_vente_credit++;
                          montant_credit += element.montant;
                        }
                      });

                      return nombre_vente_credit > 0
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Text(
                                    _credit.nom,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    montant_credit.toString() + " F",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )
                          : Container();
                    }),
                    separatorBuilder: ((context, index) => Divider()),
                    itemCount: _list_credit.length),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.indigo,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        "Total vente cr??dit",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        total_credit.toString() + " F",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 72,
              ),
            ],
          ),
        ));
  }
}
