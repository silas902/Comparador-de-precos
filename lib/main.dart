import 'package:comparador_de_precos/features/lista_mercados/lista_mercados_screen.dart';
import 'package:comparador_de_precos/providers/mercado_produtos_provider.dart';
import 'package:comparador_de_precos/providers/mercado_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MercadoProvider()),
        ChangeNotifierProvider(create: (context) => MercadoProdutosProvider())    
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ListaMercadosScreen(),
      ),
    );
  }
}