// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, deprecated_member_use, no_leading_underscores_for_local_identifiers, avoid_print, unnecessary_string_interpolations, unused_field, use_build_context_synchronously, unused_local_variable, depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet/interface/bottomnavigation.dart';
import 'package:projet/services/registration.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //To Toggle Password Text Visibility.
  bool _obscureText = true;
  late String _username,
      _email,
      _password,
      _nom,
      _prenom,
      _telephone,
      _confirmpassword;
  String sexe = "Masculin";

  TextEditingController dateNaissance = TextEditingController();
  late String dateSelectionned;

  //For the loading state.
  late bool _isSubmitting = false;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseAuth auth = FirebaseAuth.instance;
  final DateTime timestamp = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final firebase = Provider.of<firebaseAuth>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text(
          "Création de compte",
          style: TextStyle(color: Colors.white.withOpacity(.8)),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 50),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _showTitle(),
                    SizedBox(
                      height: 40,
                    ),
                    _showUserPrenomInput(),
                    _showUserNomInput(),
                    SizedBox(
                      width: double.infinity,
                      child: DropdownButton<String>(
                          value: sexe,
                          elevation: 16,
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          items: <String>['Masculin', 'Féminin']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                                value: value, child: Text(value));
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              sexe = newValue!;
                            });
                          }),
                    ),
                    TextField(
                      controller: dateNaissance,
                      decoration: InputDecoration(
                        labelText: "Votre date de naissance",
                        labelStyle: TextStyle(
                          color: Colors.white.withOpacity(.8),
                        ),
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? dateSelectionned = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2100));

                        if (dateSelectionned != null) {
                          String formatDate =
                              DateFormat('dd-MM-yyyy').format(dateSelectionned);

                          setState(() {
                            dateNaissance.text = formatDate;
                          });
                          // ignore: curly_braces_in_flow_control_structures
                        } else {
                          dateNaissance.text = "";
                        }
                      },
                    ),
                    _showEmailInput(),
                    _showUserTelephoneInput(),
                    _showPasswordInput(),
                    _showConfirmPasswordInput(),
                    _showFormActions(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigation(),
    );
  }

  //1
  _showTitle() {
    return Text(
      "Register",
      style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    );
  }

  //2

  _showUserPrenomInput() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        onSaved: (val) => _prenom = val!,
        validator: (val) => val!.length < 6 ? "Le champ prénom est vide" : null,
        decoration: InputDecoration(
            labelText: "Prénom",
            hintText: "Votre prénom",
            icon: Icon(
              Icons.person_add_alt_sharp,
            )),
      ),
    );
  }

  _showUserNomInput() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        onSaved: (val) => _nom = val!,
        validator: (val) => val!.length < 6 ? "Le champ nom est vide" : null,
        decoration: InputDecoration(
            labelText: "Nom",
            hintText: "Votre nom",
            icon: Icon(
              Icons.person_add_alt_sharp,
            )),
      ),
    );
  }

  //3
  _showEmailInput() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        onSaved: (val) => _email = val!,
        validator: (val) => !val!.contains("@") ? "Email invalide" : null,
        decoration: InputDecoration(
            labelText: "Adresse E-Mail",
            hintText: "Votre adresse e-mail",
            icon: Icon(
              Icons.email_sharp,
            )),
      ),
    );
  }

  _showUserTelephoneInput() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        onSaved: (val) => _telephone = val!,
        validator: (val) => val!.length < 6 ? "Le champ numéro est vide" : null,
        decoration: InputDecoration(
            labelText: "Numéro Téléphonique",
            hintText: "Votre numéro de téléphone",
            icon: Icon(
              Icons.phone_outlined,
            )),
      ),
    );
  }

  //4
  _showPasswordInput() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        onSaved: (val) => _password = val!,
        validator: (val) => val!.length < 6 ? "Le mot de passe vide" : null,
        obscureText: _obscureText,
        decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child:
                  Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
            ),
            labelText: "Mot de passe",
            hintText: "Votre mot de passe",
            icon: Icon(
              Icons.lock,
            )),
      ),
    );
  }

  _showConfirmPasswordInput() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        onSaved: (val) => _confirmpassword = val!,
        validator: (val) => val!.length < 6 ? "Le mot de passe vide" : null,
        obscureText: true,
        decoration: InputDecoration(
            labelText: "Confirmation ",
            hintText: "Confirmez votre mot de passe",
            icon: Icon(
              Icons.lock,
            )),
      ),
    );
  }

  //5
  _showFormActions() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          _isSubmitting == true
              ? CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                )
              : RaisedButton(
                  // ignore: sort_child_properties_last
                  child: Text(
                    "CONTINUEZ",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  color: Colors.orange,
                  onPressed: _submit),
        ],
      ),
    );
  }

  //6
  _submit() {
    final _form = _formKey.currentState;
    if (_form!.validate()) {
      _form.save();
      //print("Email $_email, Password $_password, Username $_username");
      _registerUser();
    } else {
      print("Form is Invalid");
    }
  }

  //7
  _registerUser() async {
    setState(() {
      _isSubmitting = true;
    });

    final resultat = await context
        .read<firebaseAuth>()
        .createUserWithEmailAndPassword(_email, _password);
    if (resultat != null) {
      await createUserInFirestore();
    } else {
      Navigator.of(context).pushNamed("/accueil");
    }
  }

  createUserInFirestore() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(auth.currentUser!.uid)
        .set({
      "nom": _nom,
      "prenom": _prenom,
      "sexe": sexe,
      "date_naissance": dateNaissance.text,
      "telephone": _telephone,
      "email": auth.currentUser!.email.toString(),
      "timestamp": timestamp,
      "admin": false,
      "is_active": true,
    });
    /* uid: auth.currentUser!.uid,
        */
    Navigator.of(context).pushNamed("/welcome");
  }
}
