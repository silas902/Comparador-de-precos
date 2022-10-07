//Todo add produto
import 'package:comparador_de_precos/models/produto.dart';

class Mercado {
  final List<Produto> produtos;
  final String id;
  final String nome; 

  Mercado ({
    required this.produtos,
    required this.id,
    required this.nome,
  });
}