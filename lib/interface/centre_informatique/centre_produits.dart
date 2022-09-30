// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:projet/interface/centre_informatique/centre_stream_stock_produit.dart';
import 'package:projet/interface/centre_informatique/drawer_admin_centre.dart';
import 'package:projet/interface/centre_informatique/stream_update_centre_produit.dart';

import 'package:projet/modele/produit.dart';
import 'package:provider/provider.dart';

class CentreListProduits extends StatelessWidget {
  const CentreListProduits({super.key});

  @override
  Widget build(BuildContext context) {
    final _list_produits = Provider.of<List<products>>(context);

    if (_list_produits.isEmpty) {
      return Scaffold(
        drawer: DrawerAdminCentre(),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.indigo,
          title: Text(
            "Les produits du centre",
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.cyanAccent,
          ),
        ),
      );
    }

    return Scaffold(
      drawer: DrawerAdminCentre(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigo,
        title: Text(
          "Les produits du centre",
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: ((context, index) {
              products _donnes = _list_produits[index];
              return ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => StreamStockPhysiqueProduit(
                              produit_uid: _donnes.uid))));
                },
                /*leading: Image.asset(
                  "images/homme.png",
                  width: 40,
                  height: 40,
                  scale: 2.5,
                  fit: BoxFit.cover,
                ),*/
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      _donnes.nom.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                        onPressed: (() {}),
                        child: Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ))
                  ],
                ),

                /* trailing: TextButton(
                    onPressed: (() {
                      showBottomSheet(
                          context: context,
                          builder: ((context) {
                            return Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Container(
                                color: Colors.white,
                                width: double.infinity,
                                height: 80,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Etes vous vraiment sur de vouloir supprimer ce produit de la base de données ?",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color:
                                              Colors.redAccent.withOpacity(.7),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        TextButton(
                                            onPressed: (() {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          CentreListProduits())));
                                            }),
                                            child: Text(
                                              "Anuler",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22),
                                            )),
                                        TextButton(
                                            onPressed: (() async {
                                              try {
                                                await FirebaseFirestore.instance
                                                    .collection(
                                                        "produits_centre")
                                                    .doc(_donnes.uid)
                                                    .delete();

                                                final snakbar = SnackBar(
                                                  content: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "Le produit " +
                                                          _donnes.nom
                                                              .toString() +
                                                          " a été supprimé avec succès de la base de données",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  backgroundColor:
                                                      Colors.indigo,
                                                  elevation: 10,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  margin: EdgeInsets.all(5),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snakbar);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: ((context) =>
                                                            CentreListProduits())));
                                                // ignore: empty_catches
                                              } catch (e) {
                                                final snakbar = SnackBar(
                                                  content: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "Une erreur inattendue s'est produite pendant la suppression de ce produit. Vérifiez votre connection internet et réessayez ! !",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  backgroundColor: Colors
                                                      .redAccent
                                                      .withOpacity(.8),
                                                  elevation: 10,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  margin: EdgeInsets.all(5),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snakbar);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: ((context) =>
                                                            CentreListProduits())));
                                              }
                                            }),
                                            child: Text(
                                              "Confirmer",
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }));
                    }),
                    child: Icon(
                      Icons.delete,
                      color: Colors.black,
                    )),*/
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "La quantité disponible est de : " +
                          _donnes.quantite_physique.toString(),
                      style: TextStyle(color: Colors.black.withOpacity(.5)),
                    ),
                    TextButton(
                        onPressed: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      StreamUpdateCentreProduit(
                                          produit_uid: _donnes.uid))));
                        }),
                        child: Icon(
                          Icons.update_rounded,
                          color: Colors.black,
                        ))
                  ],
                ),
              );
            }),
            separatorBuilder: ((context, index) => Divider(
                  height: 0,
                )),
            itemCount: _list_produits.length),
      ),
    );
  }
}
