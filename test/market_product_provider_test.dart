import 'dart:math';

import 'package:comparador_de_precos/providers/market_product_provider.dart';
import 'package:comparador_de_precos/services/market_product_service_http.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  test('marketProductProvider.loadProducts', () async{
    
      // arrange
      MarketProductServiceMock marketProductService = MarketProductServiceMock('123');
      MarketProductProvider marketProductProvider = MarketProductProvider(marketProductService);
      int countNotifyListener = 0;
      marketProductProvider.addListener(() { 
        countNotifyListener++;
      });

      // act
      final String response = await marketProductProvider.loadProducts('1');

      // assert
      expect(response, ''); 
      expect(marketProductProvider.items.length, 1);   
      expect(marketProductProvider.items[0].productName, 'arroz');   
      expect(marketProductProvider.items[0].productValue, 4.00);   
      expect(marketProductProvider.items[0].id, marketProductService.productId);   
      expect(countNotifyListener, 1);   

    });

  test('marketProductProvider.loadProducts - erro', () async{
    
      // arrange
      MarketProductServiceMock marketProductService = MarketProductServiceMock('123');
      MarketProductProvider marketProductProvider = MarketProductProvider(marketProductService);
      int countNotifyListener = 0;
      marketProductProvider.addListener(() { 
        countNotifyListener++;
      });

      // act
      final String response = await marketProductProvider.loadProducts('');

      // assert
      expect(response, 'Verifique sua conexão'); 
      expect(marketProductProvider.items.length, 0);   
      expect(countNotifyListener, 1);   

    });


  test('marketProductProvider.addProduct', () async{
  
    // arrange
    MarketProductServiceMock marketProductService = MarketProductServiceMock(Random().nextInt(1000).toString());
    MarketProductProvider marketProductProvider = MarketProductProvider(marketProductService);
    int countNotifyListener = 0;
    marketProductProvider.addListener(() { 
      countNotifyListener++;
    });
    // act
    final String response = await marketProductProvider.addProduct('arroz', 4.00, 'id');

    // assert
    expect(response, ''); 
    expect(marketProductProvider.items.length, 1);   
    expect(marketProductProvider.items[0].productName, 'arroz');   
    expect(marketProductProvider.items[0].productValue, 4.00);   
    expect(marketProductProvider.items[0].id, marketProductService.productId);   
    expect(countNotifyListener, 1);   

  });

  test('marketProductProvider.addProduct - erro', () async{

  
    // arrange
    MarketProductServiceMock marketProductProviderService = MarketProductServiceMock('');
    MarketProductProvider marketProductProvider = MarketProductProvider(marketProductProviderService);
    int countNotifyListener = 0;
    marketProductProvider.addListener(() { 
      countNotifyListener++;
    });
    // act
    final String response = await marketProductProvider.addProduct('arroz', 4.00, 'id');

    // assert
    expect(response, 'Verifique sua conexão'); 
    expect(marketProductProvider.items.length, 0);        
    expect(countNotifyListener, 1);   

  });

}

class MarketProductServiceMock extends IMarketProductService {
  final String productId;

  MarketProductServiceMock(this.productId);

  @override
  Future<Map<String, dynamic>?> loadProducts({required String marketplaceId}) async {
    if (marketplaceId.isEmpty) return null;

    Map<String, dynamic>? dados = {
      productId: {
        "product":"arroz",
        "valor": 4.00,
      }
    };
    return dados;
  }

  @override
  Future<String> addProduct({required String productName, required double productValue, required String marketplaceId}) async {
    return productId;
  }
  
  @override
  Future<String> deleteProduct({required String productId, required String marketplaceId}) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }
  
  @override
  Future<String> editProduct({required String productId, required String productName, required double productValue, required String marketplaceId}) {
    // TODO: implement editProduct
    // dartz -> Either<L,R> -> Either<Exception,String>
    // return Rigth("1");
    // return Left(Exception("Erro! Sem internet!"));
    /*
    Either response = await service.edit();
    response.fold(
      (Exception erro) {
        codigo a ser executado quando respondeu ERRO
      }  
      , 
      (String id) {
        codigo a ser executado quando respondeu OK
      })
      */
    throw UnimplementedError();
  }
  

} 