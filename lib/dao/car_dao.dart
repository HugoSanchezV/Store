import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store/services/firebase_service.dart';

import '../apis/api_crud.dart';
import '../tdo/carTDO.dart';

class CarDao implements ApiCrud<CarTDO>{

  CarDao (){
    DatabaseService().validateCollection("car");
  }

  @override
  Future<List> getAll() async {
    List cars = [];

    DatabaseService().validateCollection("cars");

    final FirebaseFirestore db = DatabaseService().db;
    final CollectionReference collectionReferenceCar = db.collection("cars");

    QuerySnapshot query = await collectionReferenceCar.get();

    for (var element in query.docs) {
      String id = element.id;

      var carData = {};
      carData[id] = element.data();
      cars.add(carData);
    }

    return cars;
  }

  @override
  create (CarTDO car) async {
    final FirebaseFirestore db = DatabaseService().db;
    final CollectionReference collectionReferenceCar = db.collection("cars");

    var carField = car.toMap();

    collectionReferenceCar.doc().set(carField);
  }

  @override
  update (id, CarTDO car) {
    final FirebaseFirestore db = DatabaseService().db;
    final CollectionReference collectionReferenceCar = db.collection("cars");

    var carField = car.toMap();

    collectionReferenceCar.doc(id).update(carField as Map<Object, Object?>);
  }

  @override
  delete(id) {
    final FirebaseFirestore db = DatabaseService().db;
    final CollectionReference collectionReferenceCar = db.collection("cars");
    collectionReferenceCar.doc(id).delete();
  }

  @override
  getById(id) async {
    List cars = [];
    final FirebaseFirestore db = DatabaseService().db;
    final CollectionReference collectionReferenceCar = db.collection("cars");

    QuerySnapshot query = await collectionReferenceCar.get();

    for (var element in query.docs) {
      String _id = element.id;

      if (_id == id) {

        cars.add(element.data());

        return cars;
      }
    }
    return cars;
  }

  @override
  Future<List> belongTo(attributeElement, elementToSearch) async {
    List cars = [];

    final FirebaseFirestore db = DatabaseService().db;
    final CollectionReference collectionReferenceCar = db.collection("cars");

    QuerySnapshot query = await collectionReferenceCar.get();

    for (var element in query.docs) {
      String id = element.id;

      var carData = {};
      if (element[attributeElement] == elementToSearch) {
        carData[id] = element.data();
        cars.add(carData);
      }
    }
    return cars;
  }
}