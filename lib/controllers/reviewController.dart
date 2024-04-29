import 'package:store/apis/api_crud.dart';
import 'package:store/dao/review_dao.dart';
import 'package:store/dao/user_dao.dart';
import 'package:store/tdo/reviewTDO.dart';
import 'package:store/tdo/userTDO.dart';

class ReviewController {
  final ApiCrud<ReviewTDO> reviewCrud = ReviewDao();

  /// Regresa todos los elementos de la tabla
  Future<List> getAll() async {
    List reviews = [];
    try {
     reviews = await reviewCrud.getAll();

      return reviews;
    } catch (e){
      throw Exception("Ocurrio un error inesperado");
    }
  }

  /// crea review, en caso de algun problema se lanza un error
  Future<void> create(ReviewTDO review) async {
    // Comprobación de campos obligatorios
    if (review.calificacion.isNaN ||
        review.idProducto.isNaN ||
        review.calificacion.isNaN ||
        review.idUsuario.isNaN ||
        review.resena.isEmpty) {
      throw Exception("Todos los campos obligatorios deben ser completados");
    }

    // Crear usuario
    try {
      await reviewCrud.create(review);
    } catch (e){
      throw Exception("Ocurrio un error inesperado" + e.toString());
    }
  }

  // Método para actualizar un usuario
  Future<void> update(String id, ReviewTDO review) async {
    // Comprobar si el usuario existe
    var existingReview = await reviewCrud.getById(id);
    if (existingReview == null) {
      throw Exception("La Review con el ID proporcionado no existe");
    }

    try {
      await reviewCrud.update(id, review);
    } catch (e){
      throw Exception("Ocurrio un error inesperado");
    }
  }

  // Método para eliminar un usuario
  Future<void> delete(String id) async {
    var existingReview = await reviewCrud.getById(id);
    if (existingReview == null) {
      throw Exception("La Review con el ID proporcionado no existe");
    }

    try {
      await reviewCrud.delete(id);
    } catch (e){
      throw Exception("Ocurrio un error inesperado");
    }
  }

  Future<List> getById(id) async {
    List reviews = [];
    try {
      reviews = await reviewCrud.getById(id);
      return reviews;
    } catch (e){
      throw Exception("Ocurrio un error inesperado");
    }
  }

  Future<List> belongTo(attributeElement, elementToSearch) async {
    List review = [];
    try {
      review = await reviewCrud.belongTo(attributeElement, elementToSearch);
      return review;
    } catch (e){
      throw Exception("Ocurrio un error inesperado" + e.toString());
    }
  }
}