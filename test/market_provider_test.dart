import 'dart:math';
import 'package:comparador_de_precos/models/markets.dart';
import 'package:comparador_de_precos/providers/market_provider.dart';
import 'package:comparador_de_precos/services/market_service_http.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';

void main() {
  test('marketProvider.loadMarkets', () async {
    MarketServiceMock marketServiceMock = MarketServiceMock();
    MarketProvider marketProvider = MarketProvider(marketServiceMock);

    await marketProvider.loadMarkets();


    expect(marketProvider.items[0].id, '-NHN7mqQorebmvO4-YD9'); 
    expect(marketProvider.items[0].name, 'atacadão'); 
    expect(marketProvider.items[1].id, '-NHN7wVC0ny4B7_mSunN'); 
    expect(marketProvider.items[1].name, 'Bom Preço'); 
  });

  test('marketsProvider.addMarket',() async {
    MarketServiceMock marketServiceMock = MarketServiceMock();
    marketServiceMock.marketIdResult = Random().nextInt(1000).toString();
    MarketProvider marketProvider = MarketProvider(marketServiceMock);
    int countNotifyListener = 0; 
    marketProvider.addListener(() {
      countNotifyListener++;
    },);

    final String response = await marketProvider.addMarket(marketName: 'Atacadão');

    expect(response, '');
    expect(marketProvider.items.length, 1);
    expect(marketProvider.items[0].name, 'Atacadão');
    expect(countNotifyListener, 1); 

    //expect(actual, matcher)
  });

  test('marketProvider.editMarket', () async {
    
    MarketServiceMock marketServiceMock = MarketServiceMock();
    marketServiceMock.marketIdResult = '12';
    MarketProvider marketProvider = MarketProvider(marketServiceMock);
    int countNotifyListener = 0;
    marketProvider.addListener(() {
      countNotifyListener++;
    },);
    
    await marketProvider.addMarket(marketName: 'Atacadão');
    countNotifyListener = 0;
    String response = await marketProvider.editMarket(marketName: 'Bompreço', marketId: '12');

    expect(response, '');
    expect(marketProvider.items.length, 1);
    expect(marketProvider.items[0].name, 'Bompreço');
    expect(marketProvider.items[0].id, marketServiceMock.marketIdResult);
    expect(countNotifyListener, 1); 
  });

  test('marketProvider.editMarket id vazio deve retorna resposta algum erro', () async {

    // arrange 
    // prepara um estado inicial
    MarketServiceMock marketServiceMock = MarketServiceMock(); 
    MarketProvider marketProvider = MarketProvider(marketServiceMock);
    int countNotifyListener = 0;
    marketProvider.addListener(() {
      countNotifyListener++;
    },);
    marketServiceMock.marketIdResult = '12';
    await marketProvider.addMarket(marketName: 'Atacadão');
    countNotifyListener = 0;

    // act
    // efetua uma ação que eventualmente muda o estado inicial
    marketServiceMock.marketIdResult = ''; 
    String response = await marketProvider.editMarket(marketName: 'Bompreço', marketId: '12');

    // assert
    // verifica se o estado atual esta como esperado
    expect(response, 'algum erro');
    expect(marketProvider.items.length, 1);
    expect(marketProvider.items[0].name, 'Atacadão');
    expect(marketProvider.items[0].id, '12');
    expect(countNotifyListener, 1); 
  });

  test('marketProvider.editMarket ao alterar o marketque não existe, deve retornar que o mercado (não existe)', () async {

    // arrange 
    // prepara um estado inicial
    MarketServiceMock marketServiceMock = MarketServiceMock(); 
    MarketProvider marketProvider = MarketProvider(marketServiceMock);
    int countNotifyListener = 0;
    marketProvider.addListener(() {
      countNotifyListener++;
    },);
    marketServiceMock.marketIdResult = '12';
    await marketProvider.addMarket(marketName: 'Atacadão');
    countNotifyListener = 0;

    // act
    // efetua uma ação que eventualmente muda o estado inicial
    String response = await marketProvider.editMarket(marketName: 'Bompreço', marketId: '13');

    // assert
    // verifica se o estado atual esta como esperado
    expect(response, 'Mercado não existe na lista: ' + '13');
    expect(marketProvider.items.length, 1);
    expect(marketProvider.items[0].name, 'Atacadão');
    expect(marketProvider.items[0].id, '12');
    expect(countNotifyListener, 1); 
  });

  test('marketProvider.deletMarket deletar matket ecluir o martek da lista', () async {

    // arrange 
    // prepara um estado inicial
    MarketServiceMock marketServiceMock = MarketServiceMock(); 
    marketServiceMock.marketIdResult = '12';
    MarketProvider marketProvider = MarketProvider(marketServiceMock);
     int countNotifyListener = 0;
    marketProvider.addListener(() {
      countNotifyListener++;
    },);
    

    // act
    // efetua uma ação que eventualmente muda o estado inicial
    
    await marketProvider.addMarket(marketName: 'Atacadão');
    countNotifyListener = 0;
    final response = await marketProvider.deleteMarket(marketId: '12');

    
    // assert
    // verifica se o estado atual esta como esperado
    expect(response, '');
    expect(marketProvider.items.length, 0);
    
  });

  test('marketProvider.deletMarket (erro) deve retornar erro pois não foi retornado no (String erro = await service.deletMarket(marketId: marketId) uma string vazia)', () async {

    // arrange 
    // prepara um estado inicial
    MarketServiceMock marketServiceMock = MarketServiceMock(); 
    marketServiceMock.marketIdResult = '12';
    MarketProvider marketProvider = MarketProvider(marketServiceMock);
     int countNotifyListener = 0;
    marketProvider.addListener(() {
      countNotifyListener++;
    },);
    

    //// act
    //// efetua uma ação que eventualmente muda o estado inicial
    
    countNotifyListener = 0;
    final response = await marketProvider.deleteMarket(marketId: '12');

    
    // assert
    // verifica se o estado atual esta como esperado
    
    expect(response, 'Produto nao existe na lista');
    expect(marketProvider.items.length, 0);
  });
  
}




class MarketServiceMock extends IMarketService {
 String marketIdResult = '';
  String dataJson = '{"-NHN7mqQorebmvO4-YD9":{"nome":"atacadão"},"-NHN7wVC0ny4B7_mSunN":{"nome":"Bom Preço"}}';
  
  MarketServiceMock();

  @override
  Future<Map<String, dynamic>?> loadMarkets() async {
    Map<String, dynamic>? data = json.decode(dataJson);
    return data;
  }


  @override
  Future<String> addMarket({required String merketName}) async {
    return marketIdResult;
  }

  @override
  Future<String> deletMarket({required String marketId}) async {
    return '';
  }

  @override
  Future<String> editMarket({required String marketId, required String marketName}) async {
    return marketIdResult;
  }
  
  
  

}