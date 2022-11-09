import 'dart:convert';
import 'package:comparador_de_precos/constants/constants.dart';
import 'package:comparador_de_precos/models/markets.dart';
import 'package:comparador_de_precos/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class MarketProductProvider extends ChangeNotifier {
  final List<Product> _items = [];
  List<Product> get items => _items;
  String _token;
  String _userId;
  MarketProductProvider(this._token, this._userId);

  Future<void> loadProducts(Marketplace marketplace, context) async {
     try{
      //final auth =  Provider.of<AuthenticationProvider>(context, listen: false);
      _items.clear();
      final response = await http.get(Uri.parse('${Constantes.Url}/$_userId/markets/${marketplace.id}/products.json?auth=$_token'));
      Map<String, dynamic> dados = jsonDecode(response.body);
      dados.forEach(
        (productId, productData) {
          _items.add(
            Product(
              id: productId,
              productName: productData["product"],
              productValue: productData["valor"],
            ),
          );
        },
      );
      notifyListeners();

    } catch (e) {
      _showDialog(context, title: 'Algum Problema. ', content: 'Cadastre Um Produto ou Verifique sua Conexão.');
    }
    
  }

  Future<void> addProduct(controllerProduct, controllerValue, Marketplace marketplace, context) async {
    //final auth =  Provider.of<AuthenticationProvider>(context, listen: false);
    try {
      final response = await http.post(Uri.parse('${Constantes.Url}/$_userId/markets/${marketplace.id}/products.json?auth=$_token'),
        body: json.encode(
          {
            "product": controllerProduct,
            "valor": controllerValue,
          },
        ),
      );
      final id = json.decode(response.body)['name'];
      _items.add(
        Product(
          id: id,
          productName: controllerProduct,
          productValue: controllerValue,
        ),
      );
      notifyListeners();
    } catch (_) {
      _showDialog(context, title: 'Algum Problema!', content: 'Verifique sua conexão');
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

  Future<void> editProduct(Product product, Marketplace marketplace, String controllerProduct, double controllerValue) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    final newProduct = Product(
      id: product.id,
      productName: controllerProduct,
      productValue: controllerValue,
    );

    if (index >= 0) {
      await http.patch(
          Uri.parse('${Constantes.Url}/$_userId/markets/${marketplace.id}/products.json?auth=$_token'),
          body: jsonEncode({
            "product": controllerProduct,
            "valor": controllerValue,
          }));
      _items[index] = newProduct;
      notifyListeners();
    }
    print('Ocorreu algum erro!');
  }

  Future<void> deleteProduct(Product product, Marketplace marketplace) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      final product = _items[index];
      _items.remove(product);
      notifyListeners();
      final response = await http.delete(
        Uri.parse('${Constantes.Url}/$_userId/markets/${marketplace.id}/products/${product.id}.json?auth=$_token'),
      );
    }
  }
}
