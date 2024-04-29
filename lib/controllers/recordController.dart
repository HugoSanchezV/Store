import 'package:store/apis/api_crud.dart';
import '../dao/record_dao.dart';
import '../tdo/recordTDO.dart';

class RecordController {
  final ApiCrud<RecordTDO> recordCrud = RecordDao();

  /// Regresa todos los elementos de la tabla usuarios
  Future<List> getAll() async {
    List records = [];
    try {
      records = await recordCrud.getAll();

      return records;
    } catch (e){
      throw Exception("Ocurrio un error inesperado");
    }

  }

  /// crea usuario, en caso de algun problema se lanza un error
  Future<void> create(RecordTDO record) async {
    // Comprobación de campos obligatorios
    if (record.idUsuario.isNaN||
        record.idProducto.isNaN ||
        record.cantidad.isNaN ||
        record.fecha.isEmpty) {
      throw Exception("Todos los campos obligatorios deben ser completados");
    }

    try {
      await recordCrud.create(record);
    } catch (e){
      throw Exception("Ocurrio un error inesperado" + e.toString());
    }
  }

  // Método para actualizar un usuario
  Future<void> update(String id, RecordTDO record) async {
    // Comprobar si el usuario existe
    var existingRecord = await recordCrud.getById(id);
    if (existingRecord == null) {
      throw Exception("El record con el ID proporcionado no existe");
    }

    // Actualizar usuario
    try {
      await recordCrud.update(id, record);
    } catch (e){
      throw Exception("Ocurrio un error inesperado" + e.toString());
    }
  }

  // Método para eliminar un usuario
  Future<void> delete(String id) async {
    // Comprobar si el usuario existe
    var existingRecord = await recordCrud.getById(id);
    if (existingRecord == null) {
      throw Exception("El usuario con el ID proporcionado no existe");
    }

    // Eliminar usuario
    try {
      await recordCrud.delete(id);
    } catch (e){
      throw Exception("Ocurrio un error inesperado");
    }
  }

  getById(id) async {
    List record = [];
    try {
      record = await recordCrud.getById(id);
      return record;
    } catch (e){
      throw Exception("Ocurrio un error inesperado");
    }
  }

  Future<List> belongTo(attributeElement, elementToSearch) async {
    List records = [];
    try {
      records = await recordCrud.belongTo(attributeElement, elementToSearch);
      return records;
    } catch (e){
      throw Exception("Ocurrio un error inesperado");
    }
  }
}