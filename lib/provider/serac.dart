// ignore_for_file: dead_code

import 'package:flutter/material.dart';

class Search extends ChangeNotifier {
  bool afficche = false;

  bool get afficher {
    afficche = !afficche;
    return afficche;
    notifyListeners();
  }
}
