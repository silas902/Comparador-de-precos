import 'package:flutter/material.dart';

class Product with ChangeNotifier{
  
  final String id;
  final String productName; 
  final double productValue;

  Product ({
    required this.id,
    required this.productName,
    required this.productValue,
  });
}