import 'dart:convert';
import 'package:comparador_de_precos/constants/constants.dart';
import 'package:comparador_de_precos/models/markets.dart';
import 'package:comparador_de_precos/providers/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class MarketProvider extends ChangeNotifier {
  final String _token;
  final String _userId;
  List<Marketplace> _items = [];
  List<Marketplace> get items => [..._items];
  bool isLoading = true;

  MarketProvider(this._token, this._items, this._userId);

  Future<void> loadMarkets(BuildContext context,) async {
    _items.clear();
    final response = await http.get(Uri.parse('${Constantes.Url}/$_userId/markets.json?auth=$_token'));
    Map<String, dynamic> data = jsonDecode(response.body);
    
    data.forEach(
      (marketId, marketData) {
        _items.add(
          Marketplace(
            products: [],
            id: marketId,
            name: marketData['nome'].toString(),
          ),
        );
      },
    );
    isLoading = false;
    notifyListeners();
  }

  Future<void> addMarket(controllermarketName, context) async {
    
    try {
      final response = await http.post(
        Uri.parse('${Constantes.Url}/$_userId/markets.json?auth=$_token'),
        body: json.encode(
          {
            'nome': controllermarketName,
          },
        ),
      );
       isLoading = false;
      final id = json.decode(response.body)['name'];
      _items.add(
        Marketplace(
          id: id,
          name: controllermarketName,
          products: [],
        ),
      );
      notifyListeners();
      //Navigator.pop(context);
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
          actions: [],
        );
      },
    );
  }

  Future<void> editMarket(Marketplace marketplace, contralerEditMarket, context) async {
    int index = _items.indexWhere((p) => p.id == marketplace.id);

    final newMarket = Marketplace(
      id: marketplace.id,
      name: contralerEditMarket,
      products: marketplace.products,
    );

    if (index >= 0) {
      await http.patch(
        Uri.parse('${Constantes.Url}/$_userId/markets.json?auth=$_token'),
        body: jsonEncode(
          {
            'nome': contralerEditMarket,
          },
        ),
      );
      _items[index] = newMarket;
      notifyListeners();
    }
  }

  Future<void> deleteMarket(Marketplace marketplace, context) async {
    int index = _items.indexWhere((p) => p.id == marketplace.id);

    if (index >= 0) {
      final marketplace = _items[index];
      _items.remove(marketplace);
      

      final response = await http.delete(
        Uri.parse('${Constantes.Url}/$_userId/markets/${marketplace.id}.json?auth=$_token'),
      );
    }notifyListeners();
  }
}
