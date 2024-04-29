import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store/apis/api_crud.dart';
import 'package:store/services/firebase_service.dart';
import '../tdo/reviewTDO.dart';

class ReviewDao implements ApiCrud<ReviewTDO>{

  ReviewDao (){
    DatabaseService().validateCollection("review");
  }

  Future<List> getAll() async {
    List review = [];

    DatabaseService().validateCollection("review");

    final FirebaseFirestore db = DatabaseService().db;
    final CollectionReference collectionReferenceReview = db.collection("review");

    QuerySnapshot query = await collectionReferenceReview.get();

    for (var element in query.docs) {
      String id = element.id;

      var reviewData = {};
      reviewData[id] = element.data();
      review.add(reviewData);
    }

    return review;
  }

  create (ReviewTDO review) {
    final FirebaseFirestore db = DatabaseService().db;
    final CollectionReference collectionReferenceReview = db.collection("review");

    var reviewField = review.toMap();

    collectionReferenceReview.doc().set(reviewField);
  }

  update (id, ReviewTDO review) {
    final FirebaseFirestore db = DatabaseService().db;
    final CollectionReference collectionReferenceReview = db.collection("review");

    var reviewField = review.toMap();

    collectionReferenceReview.doc(id).update(reviewField as Map<Object, Object?>);
  }

  delete(id) {
    final FirebaseFirestore db = DatabaseService().db;
    final CollectionReference collectionReferenceReview = db.collection("review");
    collectionReferenceReview.doc(id).delete();
  }


  getById(id) async {
    List review = [];
    final FirebaseFirestore db = DatabaseService().db;
    final CollectionReference collectionReferenceReview = db.collection("review");

    QuerySnapshot query = await collectionReferenceReview.get();

    for (var element in query.docs) {
      String _id = element.id;

      if (_id == id) {
        review.add(element.data());

        return review;
      }


    }
    return review;
  }

  Future<List> belongTo(attributeElement, elementToSearch) async {
    List review = [];

    final FirebaseFirestore db = DatabaseService().db;
    final CollectionReference collectionReferenceReview = db.collection("review");

    QuerySnapshot query = await collectionReferenceReview.get();

    for (var element in query.docs) {
      String id = element.id;

      var reviewData = {};
      if (element[attributeElement] == elementToSearch) {
        reviewData[id] = element.data();
        review.add(reviewData);
      }
    }
    return review;
  }
}