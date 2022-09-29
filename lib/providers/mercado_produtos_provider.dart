
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
  
  void addProduto(Produto produto, String mercadoId) {
    if(_items[mercadoId] == null ) {
      _items[mercadoId] = [];
      print('addProduto ' + produto.id);
      print(_items[mercadoId]);
      print(mercadoId);
    }
    print('notify ' + items.toString());
    //print();
    items[mercadoId]!.add(produto);
    notifyListeners();
  }

  void updateProduto (Produto produto, String mercadoId) {
    int index = _items[mercadoId]!.indexWhere((p) => p.id == produto.id);

    if(index >= 0) {
      _items[mercadoId]![index] = produto;
      notifyListeners();
    }
  }
}