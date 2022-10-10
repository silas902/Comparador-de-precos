import 'dart:ffi';

import 'package:comparador_de_precos/features/lista_mercados/lista_mercados_card_mercado.dart';
import 'package:comparador_de_precos/features/formularios/mercados_cadastros_screen.dart';
import 'package:comparador_de_precos/models/mercado.dart';
import 'package:comparador_de_precos/providers/mercado_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaMercadosScreen extends StatefulWidget {
  const ListaMercadosScreen({ Key? key }) : super(key: key);

  @override
  State<ListaMercadosScreen> createState() => _ListaMercadosScreenState();
}

class _ListaMercadosScreenState extends State<ListaMercadosScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<MercadoProvider>(context, listen: false).carregarMercados();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[300],
        title: Text('Comparador de Preços'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MercadoCadastrosScreen()));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Consumer<MercadoProvider>(
        builder: (context, mercadoProvider, child) => ListView.builder(
          itemCount: mercadoProvider.items.length,
          itemBuilder: (context, index) {
            return ListaMercadosCardMercado(mercado: mercadoProvider.items[index]);
          },
        ),
      ),
    );
  }
}