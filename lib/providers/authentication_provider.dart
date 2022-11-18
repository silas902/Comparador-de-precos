import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../exceptions/auth_exception.dart';


class AuthenticationProvider extends ChangeNotifier{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _token;
  String? _email;
  String? _userId;
  DateTime? _expiryDate;
  //User? usuario;
  bool isLoading = true;

  bool get isAuth {
    final isValid = _expiryDate?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValid;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  String? get email {
    return isAuth ? _email : null;
  }

  String? get userId {
    return isAuth ? _userId : null;
  }

  Future<void> _authenticate(String email, String password, String urlFragment) async {
    final _url = 'https://identitytoolkit.googleapis.com/v1/accounts:$urlFragment?key=${Constantes.webApiKey}';

    var url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:$urlFragment?key=${Constantes.webApiKey}');
    String data = json.encode({
      'email': email,
      'password': password,
      'returnSecureToken': true
    });
    final response = await http.post(url, body: data);

    //final response = await http.post(Uri.parse(_url),
    //body: json.encode({
    //  'email': email,
    //  'password': password,
    //  'returnSecureToken': true
    //}));
//
    final body = jsonDecode(response.body);
    //print(response.body);

    if (body['error'] != null) {
      throw AuthException(body['error']['message']);
    } else {
      _token = body['idToken'];
      _email = body['email'];
      _userId = body['localId'];

      _expiryDate = DateTime.now().add(
        Duration(seconds: int.parse(body['expiresIn'])),
      );
      print(response);
      notifyListeners();
    }
  }

  Future<void> logout(context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pop(context);
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

}