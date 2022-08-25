import 'package:comparador_de_precos/models/mercado.dart';
import 'package:comparador_de_precos/features/lista_produtos_mercado/produtos_do_mercado_screen.dart';
import 'package:flutter/material.dart';

class ListaMercadosCardMercado extends StatelessWidget {
  final Mercado mercado;

  const ListaMercadosCardMercado({ Key? key, required this.mercado }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Card(
        margin: const EdgeInsets.all(6),
        color: Colors.grey[200],
        elevation: 10,
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProdutosDoMercadoScreen(mercado)));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListTile(
                title: Text(mercado.nome.toString()),
                subtitle: const Text('Ultimo Acesso:'),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}