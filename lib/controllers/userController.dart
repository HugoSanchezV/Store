import 'package:store/apis/api_crud.dart';
import 'package:store/dao/user_dao.dart';
import 'package:store/tdo/userTDO.dart';

class UserController {
  final ApiCrud<UserTDO> userCrud = UserDao();

  /// Regresa todos los elementos de la tabla usuarios
  Future<List> getAll() async {
    List users = [];
    try {
      users = await userCrud.getAll();

      return users;
    } catch (e){
      throw Exception("Ocurrio un error inesperado");
    }

  }

  /// crea usuario, en caso de algun problema se lanza un error
  Future<void> create(UserTDO user) async {
    // Comprobación de campos obligatorios
    if (user.getName().isEmpty ||
        user.getEmail().isEmpty ||
        user.getPassword().isEmpty ||
        user.getPhone().isEmpty) {
      throw Exception("Todos los campos obligatorios deben ser completados");
    }

    // Comprobación de email único
    List existingUsers = await userCrud.belongTo("email", user.getEmail());
    if (existingUsers.isNotEmpty) {
      throw Exception("El correo electrónico ya está registrado");
    }

    // Crear usuario
    try {
      await userCrud.create(user);
    } catch (e){
      throw Exception("Ocurrio un error inesperado");
    }
  }

  // Método para actualizar un usuario
  Future<void> update(String id, UserTDO user) async {
    // Comprobar si el usuario existe
    var existingUser = await userCrud.getById(id);
    if (existingUser == null) {
      throw Exception("El usuario con el ID proporcionado no existe");
    }

    // Actualizar usuario
    try {
    await userCrud.update(id, user);
    } catch (e){
      throw Exception("Ocurrio un error inesperado");
    }
  }

  // Método para eliminar un usuario
  Future<void> delete(String id) async {
    // Comprobar si el usuario existe
    var existingUser = await userCrud.getById(id);
    if (existingUser == null) {
      throw Exception("El usuario con el ID proporcionado no existe");
    }

    // Eliminar usuario
    try {
    await userCrud.delete(id);
    } catch (e){
    throw Exception("Ocurrio un error inesperado");
    }
  }

  Future<List> getById(id) async {
    List<dynamic> user = [];
    try {
      user = await userCrud.getById(id);
      return user;
    } catch (e){
      throw Exception("Ocurrio un error inesperado");
    }
  }

  Future<List> belongTo(attributeElement, elementToSearch) async {
    List users = [];
    try {
      users = await userCrud.belongTo(attributeElement, elementToSearch);
      return users;
    } catch (e){
      throw Exception("Ocurrio un error inesperado");
    }
  }
}