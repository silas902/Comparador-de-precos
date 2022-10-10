import 'dart:convert';
import 'package:comparador_de_precos/constantes/constantes.dart';
import 'package:comparador_de_precos/models/mercado.dart';
import 'package:comparador_de_precos/models/produto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MercadoProvider extends ChangeNotifier {
  final List<Mercado> _items = [
    //Mercado(id: 'p1', nome: 'BomPreço'),
    //Mercado(id: 'p2', nome: 'Atacadão'),
    //Mercado(id: 'p3', nome: 'Redmix'),
  ];
  final List<Produto> _itemsP = [];

  List<Mercado> get items => [..._items];
  List<Produto> get itemsP => _itemsP;
  Future<void> carregarMercados() async {
    final response = await http.get(Uri.parse('${Constantes.Url}.json'));
    Map<String, dynamic> dados = jsonDecode(response.body);
    print(jsonDecode(response.body));
    dados.forEach((mercadoId, mercadoDados) {
      dados[mercadoId]['produtos'].forEach(
        (key, value) {
          itemsP.add(Produto(
            id: key,
            nomeProduto: value['produto'],
            valorProduto: value['valor'],
          ));
          _items.add(
            Mercado(
              produtos: _itemsP, //mercadoDados['produtos'],
              id: mercadoId,
              nome: mercadoDados['nome'].toString(),
            ),
          );
        },
      );notifyListeners();
    }); 
   
  }

  Future<void> addMercado(controllerMercadoNome, context) async {
    try {
      final response = await http.post(
        Uri.parse('${Constantes.Url}.json'),
        body: json.encode({
          'nome': controllerMercadoNome,
        }),
      );

      final id = json.decode(response.body)['name'];
      _items.add(Mercado(
        id: id,
        nome: controllerMercadoNome,
        produtos: [],
      ));
      notifyListeners();
    } catch (_) {
      _showDialog(context);
    }
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('Ocorreu algum erro!'),
          content: Text('Verifique sua conexão.'),
          actions: [
            //TextButton(onPressed: () {Navigator.pop(context)}, child: Text('Ok');)
          ],
        );
      },
    );
  }

  Future<void> editarMercado(Mercado mercado, contralerEditMercado) async {
    int index = _items.indexWhere((p) => p.id == mercado.id);

    final novoMercado = Mercado(
      id: mercado.id,
      nome: contralerEditMercado,
      produtos: mercado.produtos,
    );

    if (index >= 0) {
      await http.patch(Uri.parse('${Constantes.Url}/${mercado.id}.json'),
        body: jsonEncode({
         'nome': contralerEditMercado,
          }));
      _items[index] = novoMercado;
      notifyListeners();
    }
  }

  Future<void> excluirMercado(Mercado mercado) async {
    int index = _items.indexWhere((p) => p.id == mercado.id);

    if (index >= 0) {
      final mercado = _items[index];
      _items.remove(mercado);
      notifyListeners();

      final resposta = await http.delete(
        Uri.parse('${Constantes.Url}/${mercado.id}.json'),
      );
    }
  }
}
