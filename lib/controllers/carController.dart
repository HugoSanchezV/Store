import 'package:store/apis/api_crud.dart';
import '../dao/car_dao.dart';
import '../tdo/carTDO.dart';

class CarController {
  final ApiCrud<CarTDO> carCrud = CarDao();

  /// Regresa todos los elementos de la tabla usuarios
  Future<List> getAll() async {
    List cars = [];
    try {
      cars = await carCrud.getAll();

      return cars;
    } catch (e) {
      throw Exception("Ocurrio un error inesperado");
    }
  }

  /// crea usuario, en caso de algun problema se lanza un error
  Future<void> create(CarTDO car) async {
    if (car.idProducto.isNaN || car.idUsuario.isNaN || car.cantidad.isNaN) {
      throw Exception("Todos los campos obligatorios deben ser completados");
    }

    List userProducts =
        await carCrud.belongTo('idUsuario', car.idUsuario) as List;
    try {
      if (userProducts.isEmpty) {
        await carCrud.create(car);
      } else {
        car.cantidad += 1;
       // await carCrud.update(car.id, car);
      }
    } catch (e) {
      throw Exception("Ocurrio un error inesperado");
    }

  }

  // Método para actualizar un usuario
  Future<void> update(String id, CarTDO car) async {
    // Comprobar si el usuario existe
    var existingCar = await carCrud.getById(id);
    if (existingCar == null) {
      throw Exception("El usuario con el ID proporcionado no existe");
    }

    try {
      await carCrud.update(id, car);
    } catch (e) {
      throw Exception("Ocurrio un error inesperado");
    }
  }

  // Método para eliminar un usuario
  Future<void> delete(String id) async {
    // Comprobar si el usuario existe
    var existingUser = await carCrud.getById(id);
    if (existingUser == null) {
      throw Exception("El usuario con el ID proporcionado no existe");
    }

    // Eliminar usuario
    try {
      await carCrud.delete(id);
    } catch (e) {
      throw Exception("Ocurrio un error inesperado");
    }
  }

  Future<List> getById(id) async {
    List car = [];
    try {
      car = await carCrud.getById(id);
      return car;
    } catch (e) {
      throw Exception("Ocurrio un error inesperado");
    }
  }

  Future<List> belongTo(attributeElement, elementToSearch) async {
    List cars = [];
    try {
      cars = await carCrud.belongTo(attributeElement, elementToSearch);
      return cars;
    } catch (e) {
      throw Exception("Ocurrio un error inesperado");
    }
  }
}
