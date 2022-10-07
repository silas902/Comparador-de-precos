
import 'dart:math';

import 'package:comparador_de_precos/models/mercado.dart';
import 'package:comparador_de_precos/models/produto.dart';
import 'package:flutter/material.dart';

class MercadoProdutosProvider extends ChangeNotifier {

    
  
  final Map<String, List<Produto>> _items = {
    'p1': [Produto(id: 'p4', nomeProduto: 'café', valorProduto: 2.00), 
  Produto(id: 'p5', nomeProduto: 'leite', valorProduto: 10.00) ],
    'p2': [Produto(id: 's', nomeProduto: 'llaa', valorProduto: 34.00)],
    'p3': [Produto(id: 'dd', nomeProduto: 'sde', valorProduto: 7.00)]
  };
     
  Map<String,List<Produto>> get items => _items;
  List<Produto> produtosDoMercado (String idMercado) => _items[idMercado] ?? [];
  
  //TODO ALGUAM COISA
  
  void addProduto(Produto produto, String mercadoId) {
    if(_items[mercadoId] == null ) {
      _items[mercadoId] = [];
    }
    print('notify ' + items.toString());
    //print();
    items[mercadoId]!.add(produto);
    notifyListeners();
  }

  void updateProduto (Produto produto, String mercadoId,) {
   
    int index = _items[mercadoId]!.indexWhere((p) => p.id == produto.id);
    print(index);

    if(index >= 0) {
      _items[mercadoId]![index] = produto;
      notifyListeners();
    }

    print('Ocorreu algum erro!');
  }

  void pp (String controllerProduto, double controllerValor, String mercadoId, produtoId) {
    print(controllerProduto);
    final novoProduto = Produto(
      id: produtoId,
      nomeProduto: controllerProduto,
      valorProduto: controllerValor,
    );
    updateProduto(novoProduto, mercadoId);
  }

  void excluirProduto(Produto produto, String mercadoId){
    int index = _items[mercadoId]!.indexWhere((p) => p.id == produto.id);
    print(items[mercadoId]!.length);

    if (index >= 0) {
      //final produto = _items[index];
       _items[mercadoId]!.remove(produto);
    }
    notifyListeners();
     print(items[mercadoId]!.length);
  }
}