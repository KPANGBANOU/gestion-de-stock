import 'package:flutter/material.dart';
import 'package:projet/interface/user_information.dart';



class UserListe extends StatelessWidget {
  const UserListe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue,
        title: const Text("Liste des utilisateurs", style: TextStyle(color: Colors.white, fontSize: 20),),
      ),

      body: UserInformation(),
    
    );
  }
}
