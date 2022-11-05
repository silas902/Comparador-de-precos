import 'package:comparador_de_precos/forms/mercado_edit_screens.dart';
import 'package:comparador_de_precos/models/markets.dart';
import 'package:comparador_de_precos/screens/products/list_products_screen.dart';
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
        margin: const EdgeInsets.all(7),
        padding: const EdgeInsets.all(10),
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
        child: Card(   
          color: Colors.black38,
          margin: const EdgeInsets.all(6),
          elevation: 10,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,MaterialPageRoute(builder: (context) => ListProductsScreen(mercado)));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  title: Text(mercado.nome.toString(), style: const TextStyle(color: Colors.white,fontStyle: FontStyle.italic)),
                  subtitle: const Text('Ultimo Acesso:',style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic)),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MercadoEditSceens(mercado: mercado)));
                    },
                    icon: const Icon(Icons.edit, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
