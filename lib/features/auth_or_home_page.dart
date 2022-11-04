import 'package:comparador_de_precos/screens/autenticacao_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/autenticacao_provider.dart';
import '../screens/markets/lista_mercados_screen.dart';


class AuthOrHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    AutenticacaoProvider auth =  Provider.of<AutenticacaoProvider>(context);

    return auth.isAuth ? ListaMercadosScreen() : AutenticacaoScreen();

    //if(auth.isLoading) {
    //  return loading();
    //} else if (auth.usuario == null) {
    //  return const AutenticacaoScreen();
    //  
    //} else {
    //  return const ListaMercadosScreen();
    //  }
  }

  //void (){
  //loading() {
  //  return const Scaffold(
  //    body: Center(
  //      child: CircularProgressIndicator(),
  //    ),
  //  );
  //}
}