import 'dart:convert';
import 'package:comparador_de_precos/constants/constants.dart';
import 'package:http/http.dart' as http;


abstract class IMarketProductService {
  Future<Map<String, dynamic>?> loadProducts({required String marketplaceId});
  Future<String> addProduct({required String productName, required double productValue, required String marketplaceId});  
  Future<String> deleteProduct({required String productId, required String marketplaceId});  
  Future<String> editProduct({required String productId, required String productName, required double productValue, required String marketplaceId});  

}

class MarketProductServiceHttp extends IMarketProductService {
  final String userId;
  final String token;

  MarketProductServiceHttp({required this.userId, required this.token});

  @override
  Future<Map<String, dynamic>?> loadProducts({required String marketplaceId}) async {
    try{
      final response = await http.get(Uri.parse('${Constantes.Url}/$userId/markets/$marketplaceId/products.json?auth=$token'));
      Map<String, dynamic> dados = jsonDecode(response.body);
      return dados;
    } catch (e) {
      return null;
    }
  } 
 

  @override
  Future<String> addProduct({required String productName, required double productValue, required String marketplaceId}) async {
    try{
      var url = Uri.parse('${Constantes.Url}/$userId/markets/${marketplaceId}/products.json?auth=$token');
      String dados = json.encode({"product": productName, "valor": productValue});       
      final response = await http.post(url, body: dados);
      final id = json.decode(response.body)['name'];
      return id;
    } catch(e) {
      return '';
    }        
  }
  
  @override
  Future<String> deleteProduct({required String productId, required String marketplaceId}) async {
    try{
      var url = Uri.parse('${Constantes.Url}/$userId/markets/$marketplaceId/products/$productId.json?auth=$token');
      await http.delete(url);
      return '';
    } catch(e) {
      return 'Erro! ' + e.toString();
    }
  }
  
  @override
  Future<String> editProduct({required String productId, required String productName, required double productValue, required String marketplaceId}) async {
    try{
      var url = Uri.parse('${Constantes.Url}/$userId/markets/$marketplaceId/products/$productId.json?auth=$token');
      String dados = json.encode({"product": productName, "valor": productValue});       
      await http.post(url, body: dados);
      return '';
    } catch(e) {
      return 'Erro! ' + e.toString();
    }
  }


}
