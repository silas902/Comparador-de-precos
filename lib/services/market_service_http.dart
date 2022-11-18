import 'dart:convert';

import 'package:comparador_de_precos/constants/constants.dart';
import 'package:http/http.dart' as http;

abstract class IMarketService {
  Future<Map<String, dynamic>?> loadMarkets ();
  Future<String> addMarket({required String merketName});
  Future<String> editMarket({required String marketId, required String marketName});
  Future<String> deletMarket({required String marketId});

}

class MarketServiceHttp extends IMarketService {
  final String userId;
  final String token;

  MarketServiceHttp({ required this.userId, required this.token});

  @override
  Future<Map<String, dynamic>?> loadMarkets() async {
    try{
      final response = await http.get(Uri.parse('${Constantes.Url}/$userId/markets.json?auth=$token'));
      Map<String, dynamic>? data = json.decode(response.body);
      return data;
    } catch (e) {
      return null;
    }
  }
  
  @override
  Future<String> addMarket({required String merketName}) async {
    try {
      var url = Uri.parse('${Constantes.Url}/$userId/markets.json?auth=$token');
      String data =  json.encode({'nome': merketName.toString()});
      final response = await http.post(url, body: data);
       //isLoading = false;
      final id = json.decode(response.body)['name'];
      return id;
    } catch(e) {
      return '';
    } 
  }
  
  @override
  Future<String> editMarket({required String marketId, required String marketName}) async {
    try{
      var url = Uri.parse('${Constantes.Url}/$userId/markets/$marketId.json?auth=$token');
      String data = json.encode({'nome': marketName.toString()});
      final response = await http.patch(url,body: data);
      final id = json.decode(response.body)['name'];
      return id;
    } catch(e){
      return '';
    }
  }
  
  @override
  Future<String> deletMarket({required String marketId}) async {
    try{
      var url = Uri.parse('${Constantes.Url}/$userId/markets/$marketId.json?auth=$token');
      await http.delete(url);
      return '';
    } catch (e) {
      return 'Erro! ' + e.toString();
    }
  }
  
  
}