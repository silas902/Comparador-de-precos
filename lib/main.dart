import 'package:comparador_de_precos/screens/autenticacao_screen.dart';
import 'package:comparador_de_precos/providers/autenticacao_provider.dart';
import 'package:comparador_de_precos/providers/mercado_produtos_provider.dart';
import 'package:comparador_de_precos/providers/mercado_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async { 
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AutenticacaoProvider()),
        ChangeNotifierProvider(create: (context) => MercadoProvider()),
        ChangeNotifierProvider(create: (context) => MercadoProdutosProvider())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AutenticacaoScreen(),
        //ListaMercadosScreen(), ,
      ),
    );
  }
}
