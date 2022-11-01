import 'package:comparador_de_precos/features/forms/formulario_autenticacao.dart';
import 'package:comparador_de_precos/providers/autenticacao_provider.dart';
import 'package:comparador_de_precos/screens/markets/lista_mercados_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AutenticacaoScreen extends StatefulWidget {
  const AutenticacaoScreen();

  @override
  State<AutenticacaoScreen> createState() => _AutenticacaoScreenState();
}

class _AutenticacaoScreenState extends State<AutenticacaoScreen> {
  //
  //Stream _connectivityStream = aut .onConnectivityChanged;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
        AutenticacaoProvider auth = Provider.of<AutenticacaoProvider>(context, listen: false);
        auth.addListener(
          () {
            if (auth.usuario == null) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AutenticacaoScreen()));
            } else {
                  Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const ListaMercadosScreen(),
                  ),
                );
              
            }
          },
        );
     // },
    //);
  }
  @override
  void dispose() {
    
    super.dispose();
  }



  //final Map<String, String> _autentDados = {
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
                //Text(),
                FormularioAutenticacao(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
