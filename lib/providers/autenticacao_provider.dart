import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../exceptions/auth_exception.dart';


class AutenticacaoProvider extends ChangeNotifier{

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

  //Future<void> _authenticate( String email, String passeord) {
  //  
  //}

  //AutenticacaoProvider() {
  //  _authCheck();
  //}
//
  //_authCheck() {
  //  _auth.authStateChanges().listen((User? user) {
  //    usuario = (user == null) ? null: user;
  //    isLoading = false;
  //    notifyListeners();
  //  });
  //  
  //  
  //}
  //_getUser() {
  //  
  //  usuario = _auth.currentUser;
  //  notifyListeners();
  //}
  
  //Future<void> registrar(String email, String senha) async {
    //try {
     // await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      //_getUser();
    //} on FirebaseAuthException catch (e) {
    //  if(e.code == 'weak-password') {
    //    throw execessaoAutenticacao('A senha e muinto fraca!');
    //  } else if (e.code == 'email-already-in-use') {
    //    throw execessaoAutenticacao('Este email já esta cadastrado');
    //  }
    //}

  //}
  Future<void> _authenticate(String email, String password, String urlFragment) async {
    print(urlFragment);
    print(Constantes.webApiKey);
    final _url = 'https://identitytoolkit.googleapis.com/v1/accounts:$urlFragment?key=${Constantes.webApiKey}';

    final response = await http.post(Uri.parse(_url),
    body: jsonEncode({
      'email': email,
      'password': password,
      'returnSecureToken': true,
    }));

    final body = jsonDecode(response.body);

    if (body['error'] != null) {
      throw AuthException(body['error']['message']);
    } else {
      _token = body['idToken'];
      _email = body['email'];
      _userId = body['localId'];

      _expiryDate = DateTime.now().add(
        Duration(seconds: int.parse(body['expiresIn'])),
      );
      notifyListeners();
    }
    print(body);
  }

  Future<void> logout(context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pop(context);
    //_getUser();
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

}