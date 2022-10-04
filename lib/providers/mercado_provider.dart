import 'package:comparador_de_precos/models/mercado.dart';
import 'package:flutter/material.dart';

class MercadoProvider extends ChangeNotifier {
  List<Mercado> _items = [
    Mercado(id: 'p1', nome: 'BomPreço'),
    Mercado(id: 'p2', nome: 'Atacadão'),
    Mercado(id: 'p3', nome: 'Redmix'),
  ];

  List<Mercado> get items => [..._items];

  void addMercado(Mercado mercado){
    _items.add(mercado);
    notifyListeners();
  }

  void excluirMercado(Mercado mercado){
    int index = _items.indexWhere((p) => p.id == mercado.id);

    if (index >= 0) {
      final Mercado = _items[index];
      _items.remove(mercado);
    }
    notifyListeners(); 
  }
}