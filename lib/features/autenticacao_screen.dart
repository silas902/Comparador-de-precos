import 'package:comparador_de_precos/features/formularios/formulario_autenticacao.dart';
import 'package:flutter/material.dart';

class AutenticacaoScreen extends StatelessWidget {
  const AutenticacaoScreen();

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
              FormularioAutenticacao(),
              
              Padding(
                padding: const EdgeInsets.only(top: 25,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Registrar-se',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
          
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 30)),
                    
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            ),
          )
        ],
      ),
    );
  }
}

