import 'package:comparador_de_precos/features/auth_or_home_page.dart';
import 'package:comparador_de_precos/providers/autenticacao_provider.dart';
import 'package:comparador_de_precos/providers/mercado_produtos_provider.dart';
import 'package:comparador_de_precos/providers/mercado_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ffi';

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
        ChangeNotifierProvider(
          create: (context) => AutenticacaoProvider(),
        ),
         ChangeNotifierProxyProvider<AutenticacaoProvider, MercadoProvider>(
          create: (context) => MercadoProvider('', [], ''),
          update: (context, autenticacao, previous) {
            return MercadoProvider(
              autenticacao.token ?? '',
              previous?.items ?? [],
              autenticacao.userId ?? '',
            );
          },
        ),
        ChangeNotifierProxyProvider<AutenticacaoProvider, MercadoProdutosProvider>(
          create: (context) => MercadoProdutosProvider('', ''),
          update: (context, autenticacao, previous) {
            return MercadoProdutosProvider(
              autenticacao.token ?? '',
              autenticacao.userId ?? '',
            );   
          },
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthOrHomePage(),
        //ListaMercadosScreen(), ,
      ),
    );
  }
}
