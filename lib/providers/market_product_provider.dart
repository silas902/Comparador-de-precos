import 'package:comparador_de_precos/models/markets.dart';
import 'package:comparador_de_precos/models/product.dart';
import 'package:flutter/material.dart';

import '../services/market_product_service.dart';

class MarketProductProvider extends ChangeNotifier {
  final List<Product> _items = [];
  List<Product> get items => _items;
  IMarketProductService service;
  MarketProductProvider(this.service);

  Future<String> loadProducts(String marketplaceId) async {
    _items.clear();
    Map<String, dynamic>? dados = await service.loadProducts(marketplaceId: marketplaceId);
    if (dados == null) return _response('Verifique sua conexão');
    dados.forEach(
      (productId, productData) {
        _items.add(Product(id: productId, productName: productData["product"], productValue: productData["valor"]));
      },
    );
    return _response("");
  }

  Future<String> addProduct(String productName, double productValue, String marketplaceId) async {
    String id = await service.addProduct(productName: productName, productValue: productValue, marketplaceId: marketplaceId);
    if (id.isEmpty) _response('Verifique sua conexão');
    _items.add(Product(id: id, productName: productName, productValue: productValue));
    return _response("");
  }

  Future<String> editProduct(Product oldProduct, Marketplace marketplace, String productName, double productValue) async {
    int index = _items.indexWhere((p) => p.id == oldProduct.id);
    final newProduct = Product(id: oldProduct.id, productName: productName, productValue: productValue);
    if (index >= 0) {
      String erro = await service.editProduct(productId: newProduct.id, productName: newProduct.productName, productValue: newProduct.productValue, marketplaceId: marketplace.id);
      if (erro.isNotEmpty) return _response(erro);
      _items[index] = newProduct;
      return _response("");
    }
    else {
      return _response('Produto nao existe na lista: ' + oldProduct.productName);
    }    
  }

  Future<String> deleteProduct(Product product, Marketplace marketplace) async {
    int index = _items.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      String erro = await service.deleteProduct(productId: product.id, marketplaceId: marketplace.id);
      if (erro.isNotEmpty) return _response(erro);
      _items.removeAt(index);
      return _response("");
    }
    else {
      return _response('Produto nao existe na lista: ' + product.productName);
    }    
  }

  String _response(String message) {
    notifyListeners(); 
    return message;  
  }
}
