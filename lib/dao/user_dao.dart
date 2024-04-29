
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store/services/firebase_service.dart';
import '../apis/api_crud.dart';
import '../tdo/userTDO.dart';

class UserDao implements ApiCrud<UserTDO> {

  UserDao (){
    DatabaseService().validateCollection("users");
  }

  @override
  Future<List> getAll() async {
    List users = [];

    final FirebaseFirestore db = DatabaseService().db;
    final CollectionReference collectionReferenceUsers = db.collection("users");

    QuerySnapshot query = await collectionReferenceUsers.get();

    for (var element in query.docs) {
      String id = element.id;

      var userData = {};
      userData[id] = element.data();
      users.add(userData);
    }

    return users;
  }

  @override
  create(UserTDO user) async {
    final FirebaseFirestore db = DatabaseService().db;
    final CollectionReference collectionReferenceUsers = db.collection("users");

    var userField = {
      'name' : user.getName(),
      'email' : user.getEmail(),
      'password' : user.getPassword(),
      'phone' : user.getPhone(),
      'token' : user.getToken(),
      'auth' : user.getAuth(),
      'admin' : user.getAdmin(),
      'address' : user.getAddress()

    };

    collectionReferenceUsers.doc().set(userField);
  }

  @override
  update (id, UserTDO user) {
    final FirebaseFirestore db = DatabaseService().db;
    final CollectionReference collectionReferenceUsers = db.collection("users");

    var userField = {
      'name' : user.getName(),
      'email' : user.getEmail(),
      'password' : user.getPassword(),
      'phone' : user.getPhone(),
      'token' : user.getToken(),
      'auth' : user.getAuth(),
      'admin' : user.getAdmin(),
      'address' : user.getAddress()
    };

    collectionReferenceUsers.doc(id).update(userField);
  }

  @override
  delete(id) {
    final FirebaseFirestore db = DatabaseService().db;
    final CollectionReference collectionReferenceUsers = db.collection("users");
    collectionReferenceUsers.doc(id).delete();
  }


  @override
  getById(id) async {
    List users = [];
    final FirebaseFirestore db = DatabaseService().db;
    final CollectionReference collectionReferenceUsers = db.collection("users");

    QuerySnapshot query = await collectionReferenceUsers.get();

    for (var element in query.docs) {
      String _id = element.id;

      if (_id == id) {
        
        users.add(element.data());
        return users;
      }
    }
    return users;
  }

  @override
  Future<List> belongTo(attributeElement, elementToSearch) async {
    List users = [];

    final FirebaseFirestore db = DatabaseService().db;
    final CollectionReference collectionReferenceUsers = db.collection("users");

    QuerySnapshot query = await collectionReferenceUsers.get();

    for (var element in query.docs) {
      String id = element.id;

      var userData = {};
      if (element[attributeElement] == elementToSearch) {
        userData[id] = element.data();
        users.add(userData);
      }
    }
    return users;
  }
}