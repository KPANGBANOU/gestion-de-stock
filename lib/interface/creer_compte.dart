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
      backgroundColor: Colors.greenAccent,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text(
          "Créer un compte",
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
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.man,
                            color: Colors.grey,
                            size: 40,
                          ),
                          SizedBox(
                            width: 250,
                            child: DropdownButton<String>(
                                value: sexe,
                                elevation: 16,
                                underline: Container(
                                  height: 2,
                                  color: Colors.deepPurpleAccent,
                                ),
                                items: <String>[
                                  'Masculin',
                                  'Féminin'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                      value: value, child: Text(value));
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    sexe = newValue!;
                                  });
                                }),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: TextFormField(
                        controller: dateNaissance,
                        validator: ((value) {
                          if (value == "") {
                            return "La date de naissance est vide";
                          }
                          return null;
                        }),
                        decoration: InputDecoration(
                            labelText: "Votre date de naissance",
                            labelStyle: TextStyle(
                              color: Colors.white.withOpacity(.8),
                            ),
                            icon: Icon(
                              Icons.dataset,
                              color: Colors.grey,
                              size: 40,
                            )),
                        readOnly: true,
                        onTap: () async {
                          DateTime? dateSelectionned = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: DateTime(2100));

                          if (dateSelectionned != null) {
                            String formatDate = DateFormat('dd-MM-yyyy')
                                .format(dateSelectionned);

                            setState(() {
                              dateNaissance.text = formatDate;
                            });
                            // ignore: curly_braces_in_flow_control_structures
                          } else {
                            dateNaissance.text = "";
                          }
                        },
                      ),
                    ),
                    _showEmailInput(),
                    _showUserTelephoneInput(),
                    _showPasswordInput(),
                    _showConfirmPasswordInput(),
                    _showFormActions(),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Avez-vous déjà créé un compte ?".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/login");
                        },
                        child: Text(
                          "Connectez vous alors !",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.blue, fontSize: 22),
                        )),
                    SizedBox(
                      height: 40,
                    )
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Bienvenue sur DGracias App".toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 4),
          ),
        ),
        SizedBox(
          height: 70,
        ),
        Text(
          "Veuillez renseigner bien les informations svp !".toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.redAccent.withOpacity(.7),
              fontSize: 22,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  //2

  _showUserPrenomInput() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        autofocus: true,
        onSaved: (val) => _prenom = val!,
        validator: (val) {
          if (val == "") {
            return "Le prenom est obligatoire";
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: "Prénom".toLowerCase(),
            labelStyle: TextStyle(color: Colors.white.withOpacity(.7)),
            hintStyle: TextStyle(color: Colors.white.withOpacity(.7)),
            hintText: "Votre prénom",
            icon: Icon(
              Icons.person_add_alt_sharp,
              color: Colors.grey,
              size: 40,
            )),
      ),
    );
  }

  _showUserNomInput() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        onSaved: (val) => _nom = val!,
        validator: (val) {
          if (val == "") {
            return "Le nom est obligatoire";
          }
          return null;
        },
        decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.white.withOpacity(.7)),
            hintStyle: TextStyle(color: Colors.white.withOpacity(.7)),
            labelText: "Nom".toUpperCase(),
            hintText: "Votre nom",
            icon: Icon(
              Icons.person_add_alt_sharp,
              color: Colors.grey,
              size: 40,
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
        validator: (val) {
          if (!val!.contains("@") || val == "") {
            return "L'email est vide ou invalide";
          }
          return null;
        },
        decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.white.withOpacity(.7)),
            hintStyle: TextStyle(color: Colors.white.withOpacity(.7)),
            labelText: "Adresse E-Mail".toUpperCase(),
            hintText: "Votre adresse e-mail",
            icon: Icon(
              Icons.email_sharp,
              color: Colors.grey,
              size: 40,
            )),
      ),
    );
  }

  _showUserTelephoneInput() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        onSaved: (val) => _telephone = val!,
        validator: (val) {
          if (val!.length < 6) {
            return "Le numero est vide ou invalide";
          }
          return null;
        },
        decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.white.withOpacity(.7)),
            hintStyle: TextStyle(color: Colors.white.withOpacity(.7)),
            labelText: "Numéro Téléphonique".toUpperCase(),
            hintText: "Votre numéro de téléphone",
            icon: Icon(
              Icons.phone_outlined,
              color: Colors.grey,
              size: 40,
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
        validator: (val) {
          if (val!.length <= 7) {
            return "Le mot de paase est incorrect ou vide";
          }
          return null;
        },
        obscureText: _obscureText,
        decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.white.withOpacity(.7)),
            hintStyle: TextStyle(color: Colors.white.withOpacity(.7)),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child:
                  Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
            ),
            labelText: "Mot de passe".toUpperCase(),
            hintText: "Votre mot de passe",
            icon: Icon(
              Icons.wifi,
              color: Colors.grey,
              size: 40,
            )),
      ),
    );
  }

  _showConfirmPasswordInput() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        onSaved: (val) => _confirmpassword = val!,
        validator: (val) {
          if (val!.length <= 7) {
            return "Confirmez le mot de passe !";
          }
          return null;
        },
        obscureText: true,
        decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.white.withOpacity(.7)),
            hintStyle: TextStyle(color: Colors.white.withOpacity(.7)),
            labelText: "Confirmation".toUpperCase(),
            hintText: "Confirmez votre mot de passe",
            icon: Icon(
              Icons.wifi,
              color: Colors.grey,
              size: 40,
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
              : SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.indigo,
                            textStyle:
                                TextStyle(backgroundColor: Colors.indigo)),
                        // ignore: sort_child_properties_last
                        child: Text(
                          "CONTINUEZ",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        onPressed: _submit),
                  ),
                ),
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
      "role": "",
      "date_naissance": dateNaissance.text,
      "telephone": _telephone,
      "email": _email,
      "timestamp": DateTime.now(),
      "admin": false,
      "is_active": true,
      "domaine": "",
      "photo_url": "",
    });
    /* uid: auth.currentUser!.uid,
        */
    Navigator.of(context).pushNamed("/wrapper");
  }
}
