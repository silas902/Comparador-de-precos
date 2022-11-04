import 'dart:convert';
import 'dart:ffi';

import 'package:comparador_de_precos/constants/constants.dart';
import 'package:comparador_de_precos/models/markets.dart';
import 'package:comparador_de_precos/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'autenticacao_provider.dart';

class MercadoProdutosProvider extends ChangeNotifier {
  final List<Produto> _items = [];
  List<Produto> get items => _items;
  String _token;
  String _userId;
  MercadoProdutosProvider(this._token, this._userId);

  Future<void> carregarProdutos(Mercado mercado, context) async {
    try{
      final auth =  Provider.of<AutenticacaoProvider>(context, listen: false);
      _items.clear();
      final response = await http.get(Uri.parse('${Constantes.Url}/$_userId/mercados/${mercado.id}/produtos.json?auth=$_token'));
      print(response);
      Map<String, dynamic> dados = jsonDecode(response.body);
      dados.forEach(
        (produtoId, produtoDados) {
          _items.add(
            Produto(
              id: produtoId,
              nomeProduto: produtoDados["produto"],
              valorProduto: produtoDados["valor"],
            ),
          );
        },
      );
      notifyListeners();

    } catch (e) {
      _showDialog(context, title: 'Algum Problema. ', content: 'Cadastre Um Produto ou Verifique sua Conexão.');
    }
    
  }

  Future<void> addProduto(controllerProduto, controllerValor, Mercado mercado, context) async {
    final auth =  Provider.of<AutenticacaoProvider>(context, listen: false);
    try {
      final response = await http.post(Uri.parse('${Constantes.Url}/$_userId/mercados/${mercado.id}/produtos.json?auth=$_token'),
        body: json.encode(
          {
            "produto": controllerProduto,
            "valor": controllerValor,
          },
        ),
      );
      final id = json.decode(response.body)['name'];
      _items.add(
        Produto(
          id: id,
          nomeProduto: controllerProduto,
          valorProduto: controllerValor,
        ),
      );
      notifyListeners();
    } catch (_) {
      _showDialog(context,title: 'Algum Problema!', content: 'Verifique sua conexão');
    }
  }

  void _showDialog(BuildContext context, {required String title, required String content}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  AlertDialog(
          title: Text(title),
          content: Text(content),
        );
      },
    );
  }

  // TODO estudar como utilizar lista no dart
  Future<void> editarProduto(Produto produto, Mercado mercado,
    String controllerProduto, double controllerValor) async {
    int index = _items.indexWhere((p) => p.id == produto.id);

    final novoProduto = Produto(
      id: produto.id,
      nomeProduto: controllerProduto,
      valorProduto: controllerValor,
    );

    if (index >= 0) {
      await http.patch(
          Uri.parse(
              '${Constantes.Url}/$_userId/mercados/${mercado.id}/produtos.json?auth=$_token'),
          body: jsonEncode({
            "produto": controllerProduto,
            "valor": controllerValor,
          }));
      _items[index] = novoProduto;
      notifyListeners();
    }
    print('Ocorreu algum erro!');
  }

  Future<void> excluirProduto(Produto produto, Mercado mercado) async {
    int index = _items.indexWhere((p) => p.id == produto.id);

    if (index >= 0) {
      final produto = _items[index];
      _items.remove(produto);
      notifyListeners();
      final resposta = await http.delete(
        Uri.parse('${Constantes.Url}/$_userId/mercados/${mercado.id}/produtos/${produto.id}.json?auth=$_token'),
      );
    }
  }
}
