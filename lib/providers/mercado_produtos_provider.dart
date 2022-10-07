import 'dart:convert';

import 'package:comparador_de_precos/constantes/constantes.dart';
import 'package:comparador_de_precos/models/mercado.dart';
import 'package:comparador_de_precos/models/produto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MercadoProdutosProvider extends ChangeNotifier {
 // final List<Produto> _items = [
 //   //'p1': [
 //   //  Produto(id: 'p4', nomeProduto: 'café', valorProduto: 2.00),
 //   //  Produto(id: 'p5', nomeProduto: 'leite', valorProduto: 10.00)
 //   //],
 //   //'p2': [Produto(id: 's', nomeProduto: 'llaa', valorProduto: 34.00)],
 //   //'p3': [Produto(id: 'dd', nomeProduto: 'sde', valorProduto: 7.00)]
 //];

//List<Produto> get items => _items;
// List<Produto> produtosDoMercado(String idMercado) => _items[idMercado] ?? [];

  Future<void> addProduto(Produto produto, Mercado mercado) async {
    try {
      final response = await http.post(
        Uri.parse('${Constantes.Url}/produtos/.json'),
        body: json.encode(
          {
            "produto": produto.nomeProduto,
            "valor": produto.valorProduto,
          },
        ),
      );

      final id = json.decode(response.body)['name'];
      mercado.produtos.add(
        Produto(
          id: id,
          nomeProduto: produto.nomeProduto,
          valorProduto: produto.valorProduto,
        ),
      );
      //print(_items.length);
      print(List<Produto>);
      notifyListeners();
    } catch (_) {
      print('algum erro!');
    }
    //if (_items[mercadoId] == null) {
    //  _items[mercadoId] = [];
    //}
   // print('notify ' + items.toString());
    ////print();
    //items[mercadoId]!.add(produto);
    
  }
  // TODO estudar como utilizar lista no dart
  void updateProduto(
    Produto produto,
    Mercado mercado) {
      int index = mercado.produtos.indexWhere((p) => p.id == produto.id);
    //int index = _items[mercadoId]!.indexWhere((p) => p.id == produto.id);
    print(index);

    if (index >= 0) {
      mercado.produtos[index] = produto;
      notifyListeners();
    }
    print('Ocorreu algum erro!');
  }

  void pp(String controllerProduto, double controllerValor, Mercado mercado, produtoId) {
    print(controllerProduto);
    final novoProduto = Produto(
      id: produtoId,
      nomeProduto: controllerProduto,
      valorProduto: controllerValor,
    );
    updateProduto(novoProduto, mercado);
  }

  void excluirProduto(Produto produto, Mercado mercado) {
    int index = mercado.produtos.indexWhere((p) => p.id == produto.id);
    //print(items[mercadoId]!.length);

    if (index >= 0) {
      //final produto = _items[index];
      mercado.produtos.remove(produto);
    }
    notifyListeners();
    //print(items[mercadoId]!.length);
  }
}
