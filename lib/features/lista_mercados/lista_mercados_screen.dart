import 'package:comparador_de_precos/features/lista_mercados/lista_mercados_card_mercado.dart';
import 'package:comparador_de_precos/features/lista_mercados/cadastro_mercados_screen.dart';
import 'package:comparador_de_precos/providers/mercado_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaMercadosScreen extends StatelessWidget {
  const ListaMercadosScreen({ Key? key }) : super(key: key);

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
              Navigator.push(context, MaterialPageRoute(builder: (context) => CadastroMercadosScreen()));
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