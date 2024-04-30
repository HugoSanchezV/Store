import 'package:store/apis/api_crud.dart';
import 'package:store/tdo/productTDO.dart';
import 'package:store/tdo/reviewTDO.dart';

import '../dao/producto_dao.dart';

class ProductController {
  final ApiCrud<ProductTDO> productCrud = ProductDao();

  /// Regresa todos los elementos de la tabla
  Future<List> getAll() async {
    List reviews = [];
    try {
      reviews = await productCrud.getAll();

      return reviews;
    } catch (e){
      throw Exception("Ocurrio un error inesperado");
    }
  }

  /// crea review, en caso de algun problema se lanza un error
  Future<void> create(ProductTDO product) async {
    // Comprobación de campos obligatorios
    if (product.nombre.isEmpty ||
        product.descripcion.isEmpty ||
        product.color.isEmpty ||
        product.talla.isEmpty ||
        product.marca.isEmpty ||
        product.img.isEmpty ||
        product.cantidad.isNaN ||
    product.precio.isNaN ||
        product.descuento.isNaN ||
    product.categoria.isEmpty) {
      throw Exception("Todos los campos obligatorios deben ser completados");
    }

    // Crear usuario
    try {
      await productCrud.create(product);
    } catch (e){
      throw Exception("Ocurrio un error inesperado" + e.toString());
    }
  }

  // Método para actualizar un usuario
  Future<void> update(String id, ProductTDO product) async {
    // Comprobar si el usuario existe
    var existingReview = await productCrud.getById(id);
    if (existingReview == null) {
      throw Exception("La Review con el ID proporcionado no existe");
    }

    try {
      await productCrud.update(id, product);
    } catch (e){
      throw Exception("Ocurrio un error inesperado");
    }
  }

  // Método para eliminar un usuario
  Future<void> delete(String id) async {
    var existingReview = await productCrud.getById(id);
    if (existingReview == null) {
      throw Exception("La Review con el ID proporcionado no existe");
    }

    try {
      await productCrud.delete(id);
    } catch (e){
      throw Exception("Ocurrio un error inesperado");
    }
  }

  Future<List> getById(id) async {
    List reviews = [];
    try {
      reviews = await productCrud.getById(id);
      return reviews;
    } catch (e){
      throw Exception("Ocurrio un error inesperado");
    }
  }

  Future<List> belongTo(attributeElement, elementToSearch) async {
    List review = [];
    try {
      review = await productCrud.belongTo(attributeElement, elementToSearch);
      return review;
    } catch (e){
      throw Exception("Ocurrio un error inesperado" + e.toString());
    }
  }
}