import 'package:comparador_de_precos/forms/authentication_form.dart';
import 'package:comparador_de_precos/providers/authentication_provider.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatelessWidget {
  final AuthenticationProvider authenticationProvider;
  const AuthenticationScreen({Key? key, required this.authenticationProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(240, 179, 178, 178),
                Color.fromARGB(212, 0, 0, 0),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AuthenticationForm(authenticationProvider: authenticationProvider,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
