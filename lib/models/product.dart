import 'package:flutter/material.dart';

class Product {
  final String id;
  final String nombre;
  final int cantidad;
  final double precio;
  final double descuento;
  final String imageUrl;

  Product({
    required this.id,
    required this.nombre,
    required this.cantidad,
    required this.precio,
    required this.descuento,
    required this.imageUrl,
  });
}
