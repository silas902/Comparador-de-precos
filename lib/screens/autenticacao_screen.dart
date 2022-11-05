import 'package:comparador_de_precos/forms/formulario_autenticacao.dart';
import 'package:flutter/material.dart';

class AutenticacaoScreen extends StatelessWidget {
  const AutenticacaoScreen({Key? key}) : super(key: key);

  //
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
              children: const [
                FormularioAutenticacao(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
