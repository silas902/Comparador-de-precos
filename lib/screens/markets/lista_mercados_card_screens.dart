import 'package:comparador_de_precos/features/forms/mercado_edit_screens.dart';
import 'package:comparador_de_precos/models/markets.dart';
import 'package:comparador_de_precos/features/lista_produtos_mercado/list_produtos_card_screens.dart';
import 'package:comparador_de_precos/providers/mercado_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaMercadosCardScreens extends StatelessWidget {
  final Mercado mercado;

  const ListaMercadosCardScreens({Key? key, required this.mercado}): super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MercadoProvider>(context, listen: false);
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: UniqueKey(),
      background: Container(
        
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(7),
        padding: const EdgeInsets.all(10),
        //color: Colors.grey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const <Widget> [
            Icon(Icons.delete, size: 30,),
          ],
        ),      
      ),
      confirmDismiss: (direction ) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Deseja Excluir o Mercado ${mercado.nome} ?'),
            content: const Text('Isso Resultará na Exclusão de Todos Produtos do Mercado!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Não'),
              ),
              TextButton(onPressed: () {
                provider.excluirMercado(mercado, context);
                Navigator.pop(context);
              }, child: const Text('Sim')),
            ],
          ),
        );
      },
      child: SizedBox(
        height: 100,
        child: Container(
          child: Card(
            
            margin: const EdgeInsets.all(6),
            color: Colors.grey[200],
            elevation: 10,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,MaterialPageRoute(builder: (context) => ProdutosDoMercadoScreen(mercado)));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ListTile(
                    title: Text(mercado.nome.toString()),
                    subtitle: const Text('Ultimo Acesso:'),
                    trailing: IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MercadoEditSceens(mercado: mercado),));
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
