// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, deprecated_member_use, sort_child_properties_last, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:projet/services/registration.dart';

import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  late String _email, _password;
  late bool _isSubmitting = false;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseAuth auth = FirebaseAuth.instance;
  final DateTime timestamp = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("GeeksForGeeks"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _showTitle(),
                  _showEmailInput(),
                  _showPasswordInput(),
                  _showFormActions()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showTitle() {
    return Text(
      "Login",
      style: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
    );
  }

  _showEmailInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        onSaved: (val) => _email = val!,
        validator: (val) => !val!.contains("@") ? "Invalid Email" : null,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Email",
            hintText: "Enter Valid Email",
            icon: Icon(
              Icons.mail,
            )),
      ),
    );
  }

  _showPasswordInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        onSaved: (val) => _password = val!,
        validator: (val) => val!.length < 6 ? "Password Is Too Short" : null,
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
            border: OutlineInputBorder(),
            labelText: "Password",
            hintText: "Enter Valid Password",
            icon: Icon(
              Icons.lock,
              color: Colors.grey,
            )),
      ),
    );
  }

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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.indigo,
                            textStyle:
                                TextStyle(backgroundColor: Colors.indigo)),
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        onPressed: _submit),
                  ),
                ),
        ],
      ),
    );
  }

  _submit() {
    final _form = _formKey.currentState;
    if (_form!.validate()) {
      _form.save();
      //print("Email $_email, Password $_password");
      _LoginUser();
    } else {
      print("Form is Invalid");
    }
  }

  _LoginUser() async {
    setState(() {
      _isSubmitting = true;
    });

    await context
        .read<firebaseAuth>()
        .signInWithEmailAndPassword(_email, _password);

    Navigator.of(context).pushNamed("/welcome");
  }
}
