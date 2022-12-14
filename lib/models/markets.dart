//Todo add produto
import 'package:comparador_de_precos/models/product.dart';

class Marketplace {
  final List<Product> products;
  final String id;
  final String name;

  Marketplace({
    required this.products,
    required this.id,
    required this.name,
  });

  Marketplace copyWith({String? id, String? name, List<Product>? products}) {
    return Marketplace(
      products: products ?? this.products,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
