import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AutenticacaoProvider extends ChangeNotifier{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _token;
  String? _email;
  String? _uid;
  DateTime? _expiryDate;
  User? usuario;
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

  String? get uid {
    return isAuth ? _uid : null;
  }

  //Future<void> _authenticate( String email, String passeord) {
  //  
  //}

  AutenticacaoProvider() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null: user;
      isLoading = false;
      notifyListeners();
    });
    
    
  }
  _getUser() {
    
    usuario = _auth.currentUser;
    notifyListeners();
  }
  
  Future<void> registrar(String email, String senha) async {
    //try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      _getUser();
    //} on FirebaseAuthException catch (e) {
    //  if(e.code == 'weak-password') {
    //    throw execessaoAutenticacao('A senha e muinto fraca!');
    //  } else if (e.code == 'email-already-in-use') {
    //    throw execessaoAutenticacao('Este email já esta cadastrado');
    //  }
    //}

  }

  Future<void> login(String email, String senha) async {
    
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      print(usuario);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if(e.code == 'user-not-found') {
        throw execessaoAutenticacao('Email não encontrado. Cadastre-se.');
      } else if (e.code == 'wrong-password') {
        throw execessaoAutenticacao('Senha incorreta. Tente novamente');
      }
    }

  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    //_getUser();
  }


}

class execessaoAutenticacao implements Exception {
  String message;
  execessaoAutenticacao(this.message);
}