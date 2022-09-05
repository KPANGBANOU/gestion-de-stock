// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';

class BarSignalerProbleme extends StatelessWidget {
  BarSignalerProbleme({Key? key}) : super(key: key);

  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent.withOpacity(.8),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigoAccent,
        title: Text(
          "Séo Gracias",
          style: TextStyle(
              color: Colors.white.withOpacity(.8),
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Text(
                  " Si le problème est trés percutant, contactez le PDG ou le Gérant directement"
                      .toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.redAccent.withOpacity(.55),
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 150.0, bottom: 50),
                child: Text(
                  "Décrivez brièvement le problème que vous avez rencontré",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(.9),
                    fontSize: 22,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 25.0, right: 15, bottom: 20),
                child: TextField(
                  controller: description,
                  decoration: InputDecoration(
                      hintText: "Description",
                      labelText: "Description",
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(.8),
                      ),
                      labelStyle:
                          TextStyle(color: Colors.white.withOpacity(.8))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10, top: 40, bottom: 70),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(
                              backgroundColor: Colors.indigo,
                              fontWeight: FontWeight.bold)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Enregistrez".toUpperCase(),
                          style: TextStyle(
                            color: Colors.white.withOpacity(.8),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      )),
                ),
              ),
            ],
          )),
    );
  }
}
