import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store/apis/belong_to_api.dart';
import 'package:store/services/firebase_service.dart';

import '../apis/login_api.dart';
import '../tdo/loginTDO.dart';

class LoginDao implements ApiLogin<loginTDO>{

  LoginDao (){
    DatabaseService().validateCollection("user");
  }

  @override
  getEmail(email) async {
    String enviarId = '';
    final FirebaseFirestore db = DatabaseService().db;
    final CollectionReference collectionReferenceCar = db.collection("users");

    QuerySnapshot query = await collectionReferenceCar.get();

    for (var element in query.docs) {
      String id = element.id;

      if (element['email'] == email) {
        print("Se encontró el correo y con id de: "+id);
        enviarId = id;
      }
    }

    return enviarId;
  }

  @override
  getPassword(password) async {
    String enviarId = '';
    final FirebaseFirestore db = DatabaseService().db;
    final CollectionReference collectionReferenceCar = db.collection("users");

    QuerySnapshot query = await collectionReferenceCar.get();

    for (var element in query.docs) {
      String id = element.id;
      print("object");
      print(element['password']);
      if (element['password'] == password) {
        enviarId = id;
        print("Se encontró la contraseña y con id de: "+id);
      }
    }
    print("Id de la contraseña: "+enviarId);
    return enviarId;
  }
  getMatch(iden, password) async{

    String users = "";
    final FirebaseFirestore db = DatabaseService().db;
    final CollectionReference collectionReferenceUsers = db.collection("users");

    QuerySnapshot query = await collectionReferenceUsers.get();

    for (var element in query.docs) {
      String _id = element.id;

      if (_id == iden) {

        users = (element.get("password"));

      }
    }

    return users;

  }
}