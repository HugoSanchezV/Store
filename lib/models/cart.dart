import 'package:flutter/material.dart';
import 'package:store/models/product.dart';

class CartItem {
  final String id;
  final String nombre;
  final int quantity;
  final double precio;
  final String imageUrl;

  CartItem({
    required this.id,
    required this.nombre,
    required this.quantity,
    required this.precio,
    required this.imageUrl,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.precio * cartItem.quantity;
    });
    return total;
  }

  void printAllItems() {
    print('--- Productos en el carrito ---');
    _items.forEach((key, cartItem) {
      print('ID: ${cartItem.id}');
      print('Nombre: ${cartItem.nombre}');
      print('Cantidad: ${cartItem.quantity}');
      print('Precio: ${cartItem.precio}');
      print('Imagen URL: ${cartItem.imageUrl}');
      print('-----------------------------');
    });
  }

  void addItemp(Product product) {
    if (_items.containsKey(product.id)) {
      // update quantity if product already in cart
      _items.update(
        product.id,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          nombre: existingCartItem.nombre,
          precio: existingCartItem.precio,
          quantity: existingCartItem.quantity + 1,
          imageUrl: product.imageUrl,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: product.id,
          nombre: product.nombre,
          precio: product.precio,
          quantity: 1,
          imageUrl: product.imageUrl,
        ),
      );
    }
    notifyListeners();
  }

  void addItem(
      String productId, String nombre, double precio, String imageUrl) {
    if (_items.containsKey(productId)) {
      // Update quantity
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          nombre: existingCartItem.nombre,
          quantity: existingCartItem.quantity + 1,
          precio: existingCartItem.precio,
          imageUrl: existingCartItem.imageUrl,
        ),
      );
    } else {
      // Add new item
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          nombre: nombre,
          quantity: 1,
          precio: precio,
          imageUrl: imageUrl,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          nombre: existingCartItem.nombre,
          quantity: existingCartItem.quantity - 1,
          precio: existingCartItem.precio,
          imageUrl: existingCartItem.imageUrl,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
