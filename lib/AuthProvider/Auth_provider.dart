import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  String _codesent = "";

  String get getcodesent => _codesent;

  void setCodesent({required String codesent}) {
    _codesent = codesent;
    setcode = codesent;
    notifyListeners();
  }

  void set setcode(code) {
    _codesent = code;
    notifyListeners();
  }
}
