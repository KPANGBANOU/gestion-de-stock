// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AccueilPage extends StatelessWidget {
  const AccueilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Text("Bienvenue sur DGraciasApp".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    letterSpacing: 4,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          Text(
            "Avez-vous déjà crééé de compte sur DgraciasApp !".toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.redAccent.withOpacity(.7),
                fontSize: 22,
                fontStyle: FontStyle.italic),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            color: Colors.green,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    style: TextButton.styleFrom(
                        textStyle: TextStyle(
                      fontSize: 30,
                      letterSpacing: 7,
                      color: Colors.black,
                    )),
                    onPressed: () {
                      Navigator.pushNamed(context, "/creercompte");
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "CONTINUEZ",
                        style: TextStyle(
                            color: Colors.white.withOpacity(.7),
                            fontWeight: FontWeight.bold,
                            letterSpacing: 7),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(
                    Icons.arrow_right_alt_outlined,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
              alignment: Alignment.center,
              child: Text(
                "En entrant dans cette application, vous acceptez ainssi les conditions d'utilisations de cette application",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              )),
        ],
      ),
    );
  }
}
