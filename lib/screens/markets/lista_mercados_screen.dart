import 'dart:async';
import 'dart:ffi';

import 'package:comparador_de_precos/providers/autenticacao_provider.dart';
import 'package:comparador_de_precos/screens/markets/lista_mercados_card_screens.dart';
import 'package:comparador_de_precos/features/forms/mercados_cadastros_screen.dart';
import 'package:comparador_de_precos/models/markets.dart';
import 'package:comparador_de_precos/providers/mercado_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaMercadosScreen extends StatefulWidget {
  const ListaMercadosScreen({Key? key}) : super(key: key);

  @override
  State<ListaMercadosScreen> createState() => _ListaMercadosScreenState();
}

class _ListaMercadosScreenState extends State<ListaMercadosScreen> {
  bool _isLoading = true;

  //void isLoadingTemporizador(){
  //  Timer.periodic(Duration(seconds: 30), (t){
  //    setState(() {
  //      _isLoading = false;
  //    });
  //    _showDialog(context);
  //    t.cancel();
  //  });
  //}

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('Ocorreu Algum Erro!'),
          content: Text('Verifique sua Conexão.'),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<MercadoProvider>(context, listen: false)
        .carregarMercados(context)
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    }); //isLoadingTemporizador();
  }

  @override
  Widget build(BuildContext context) {
    final _isLoadingMercado = Provider.of<MercadoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(251, 231, 180, 12),
        title: Text('Comparador de Preços'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MercadoCadastrosScreen()));
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              Provider.of<AutenticacaoProvider>(context, listen: false).logout();           
              Navigator.pop(context);
            },    
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: _isLoading
      ? Center(
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(240, 179, 178, 178),
                    Color.fromARGB(212, 0, 0, 0),
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
              ),
              Center(child: CircularProgressIndicator())
            ]
          )
        )  
      : Consumer<MercadoProvider>(
          builder: (context, mercadoProvider, child) {
           return Stack(
             children: [
               Container(
                 decoration: const BoxDecoration(
                   gradient: LinearGradient(colors: [
                     Color.fromARGB(240, 179, 178, 178),
                     Color.fromARGB(212, 0, 0, 0),
                   ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                 ),
               ),

               RefreshIndicator(
                 onRefresh: () async =>
                     await Provider.of<MercadoProvider>(context, listen: false)
                         .carregarMercados(context),
                 child: ListView.builder(
                   itemCount: mercadoProvider.items.length,
                   itemBuilder: (context, index) {
                     return ListaMercadosCardScreens(
                         mercado: mercadoProvider.items[index]);
                   },
                 ),
               ) 
             ],

            );
          }
        ),  
        
    );
  }
}
