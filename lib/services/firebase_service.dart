import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._();

  factory DatabaseService() => _instance;

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  DatabaseService._();

  FirebaseFirestore get db => _db;

  Future<void> validateCollection(String collection) async {
    try {
      QuerySnapshot snapshot =
      await _db.collection(collection).limit(1).get();

      if (snapshot.docs.isEmpty) {
        // La colección no existe, así que créala
        await _db.collection(collection).doc("documentoInicial").set({
          // Puedes agregar datos iniciales si lo deseas
          //'ejemplo': 'datos iniciales',
        });
      }
    } catch (error) {

    }
  }

}