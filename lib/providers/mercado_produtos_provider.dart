import 'package:comparador_de_precos/models/mercado.dart';
import 'package:comparador_de_precos/models/produto.dart';
import 'package:flutter/material.dart';

class MercadoProdutosProvider extends ChangeNotifier {
  Map<String,List<Produto>> _items = {
    'p1': [Produto(id: 'p4', nome: 'café', valorProduto: 2.00), 
    Produto(id: 'p5', nome: 'leite', valorProduto: 10.00) ],
    'p2': [Produto(id: 's', nome: 'llaa', valorProduto: 34.00)],
    'p3': [Produto(id: 'dd', nome: 'sde', valorProduto: 7.00)]
  };
    

   Map<String,List<Produto>> get items => _items;
   List<Produto> produtosDoMercado (String idMercado) => _items[idMercado] ?? [];

  void addProduto(Mercado mercado, Produto produto) {
    if(_items[mercado.id] == null ) {
      _items[mercado.id] = [];
    }
    _items[mercado.id]!.add(produto);
    notifyListeners();
  }

  //List _items = DETALHES_MERCADO;

}