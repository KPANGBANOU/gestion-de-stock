// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class UserInformation extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  // ignore: unused_field
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading');
        }

        if (!snapshot.hasData) {
          return Container(
            color: Colors.redAccent,
            child: Text("PAS DE DONEES", style: TextStyle(fontSize: 30, color: Colors.black),),
          );
        }

        return Scaffold(
          body: ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return ListTile(
                title: Text(data['nom']),
                subtitle: Text(data['prenom']),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
