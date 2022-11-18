import 'dart:convert';
import 'dart:developer';
import 'package:comparador_de_precos/constants/constants.dart';
import 'package:comparador_de_precos/models/markets.dart';
import 'package:comparador_de_precos/providers/authentication_provider.dart';
import 'package:comparador_de_precos/services/market_service_http.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class MarketProvider extends ChangeNotifier {
  IMarketService service;
  List<Marketplace> _items = [];
  MarketProvider(this.service);

  List<Marketplace> get items => [..._items];
  bool isLoading = true;

  Future<String> loadMarkets() async {
    _items.clear();
    Map<String, dynamic>? data = await service.loadMarkets();
    print(data);
    if(data == null) return _response('Verifique sua conexão ou cadastre um produto');
    data.forEach(
      (marketId, marketData) {
        _items.add(
          Marketplace(
            products: [],
            id: marketId.toString(),
            name: marketData["nome"] as String,
          ),
        );
      },
    );
    //isLoading = false;
    return _response('');
    
  }

  Future<String> addMarket({required String marketName}) async {
    String id = await service.addMarket(merketName: marketName);
    if (id.isEmpty) return _response('Verifique sua conexão');
    _items.add(Marketplace(id: id.toString(), name: marketName, products: []));
    return _response('');
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

  Future<String> editMarket({required marketId, required marketName}) async {

    int index = _items.indexWhere((p) => p.id == marketId);
    

    if (index >= 0) {
      String id = await service.editMarket(marketId: marketId, marketName: marketName);
      if(id.isEmpty) return _response('algum erro');
      final newMarket = _items[index].copyWith(name: marketName);
      _items[index] = newMarket;
      return _response('');

      //await http.patch(
      //  Uri.parse('${Constantes.Url}/$userId/markets.json?auth=$_token'),
      //  body: jsonEncode(
      //    {
      //      'nome': contralerEditMarket,
      //    },
      //  ),
      //);
      
  
    } else {
      return _response('Mercado não existe na lista: ' + marketId);
    }
  }

  Future<String> deleteMarket({required String marketId, required marketplace}) async {
    int index = _items.indexWhere((p) => p.id == marketId);

    if (index >= 0) {
      String erro = await service.deletMarket(marketId: marketId);
      if(erro.isNotEmpty) return _response(erro);
      _items.remove(marketplace);
      return _response('');
    } else {
      return _response('Produto nao existe na lista');
    }
    //   final marketplace = _items[index];
    //   _items.remove(marketplace);
//
    //   final response = await http.delete(
    //     Uri.parse(
    //         '${Constantes.Url}/$_userId/markets/${marketplace.id}.json?auth=$_token'),
    //   );
    // }
    // notifyListeners();
  }

  String _response(String message) {
    notifyListeners();
    return message;
  }
}
