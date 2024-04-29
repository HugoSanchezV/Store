import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store/apis/api_crud.dart';
import 'package:store/services/firebase_service.dart';
import '../tdo/recordTDO.dart';

class RecordDao implements ApiCrud<RecordTDO> {

  RecordDao (){
    DatabaseService().validateCollection("record");
  }

  @override
  Future<List> getAll() async {
    List record = [];

    DatabaseService().validateCollection("record");

    final FirebaseFirestore db = DatabaseService().db;
    final CollectionReference collectionReferenceReview =
        db.collection("record");

    QuerySnapshot query = await collectionReferenceReview.get();

    for (var element in query.docs) {
      String id = element.id;

      var recordData = {};
      recordData[id] = element.data();
      record.add(recordData);
    }

    return record;
  }

  @override
  create(RecordTDO record) {
    final FirebaseFirestore db = DatabaseService().db;

    DatabaseService().validateCollection("record");

    final CollectionReference collectionReferenceReview =
        db.collection("record");

    var recordField = record.toMap();

    collectionReferenceReview.doc().set(recordField);
  }

  @override
  update(id, RecordTDO record) {
    final FirebaseFirestore db = DatabaseService().db;
    final CollectionReference collectionReferenceReview =
        db.collection("record");

    var recordField = record.toMap();

    collectionReferenceReview
        .doc(id)
        .update(recordField as Map<Object, Object?>);
  }

  @override
  delete(id) {
    final FirebaseFirestore db = DatabaseService().db;
    final CollectionReference collectionReferenceReview =
        db.collection("record");
    collectionReferenceReview.doc(id).delete();
  }

  @override
  getById(id) async {
    List record = [];
    final FirebaseFirestore db = DatabaseService().db;
    final CollectionReference collectionReferenceReview =
        db.collection("record");

    QuerySnapshot query = await collectionReferenceReview.get();

    for (var element in query.docs) {
      String _id = element.id;

      if (_id == id) {
        record.add(element.data());
        return record;
      }


    }
    return record;
  }

  @override
  Future<List> belongTo(attributeElement, elementToSearch) async {
    List record = [];

    final FirebaseFirestore db = DatabaseService().db;
    final CollectionReference collectionReferenceReview =
        db.collection("record");

    QuerySnapshot query = await collectionReferenceReview.get();

    for (var element in query.docs) {
      String id = element.id;

      var recordData = {};
      if (element[attributeElement] == elementToSearch) {
        recordData[id] = element.data();
        record.add(recordData);
      }
    }
    return record;
  }
}
