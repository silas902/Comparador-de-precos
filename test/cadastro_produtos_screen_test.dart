 import 'dart:js';

import 'package:comparador_de_precos/forms/registration_products_screen.dart';
import 'package:comparador_de_precos/models/markets.dart';
import 'package:comparador_de_precos/providers/market_product_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('valor do controller', () {
    final products = MarketProductProvider('', '');
    const controllerProduto = 'silas';
    const controllerValor = 20.00;
      Marketplace mercado = '' as Marketplace;

    expect(products.addProduct(controllerProduto, controllerValor, mercado, context), 'silas', skip: 20.00);
    
    
  });
}