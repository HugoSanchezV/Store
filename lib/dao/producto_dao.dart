import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store/apis/api_crud.dart';

import '../services/firebase_service.dart';
import '../tdo/productTDO.dart';

class ProductDao implements ApiCrud<ProductTDO>{

  ProductDao (){
    DatabaseService().validateCollection("products");
  }

  @override
  Future<List> getAll() async {
    List products = [];

    DatabaseService().validateCollection("product");

    final FirebaseFirestore db = DatabaseService().db;
    final CollectionReference collectionReferenceProducts = db.collection("products");

    QuerySnapshot query = await collectionReferenceProducts.get();

    for (var element in query.docs) {
      String id = element.id;

      var productData = {};
      productData[id] = element.data();
      products.add(productData);
    }

    return products;
  }

  @override
  create (ProductTDO product) {
    final FirebaseFirestore db = DatabaseService().db;
    final CollectionReference collectionReferenceProducts = db.collection("products");

    var productField = product.toMap();

    collectionReferenceProducts.doc().set(productField);
  }

  @override
  update (id, ProductTDO product) {
    final FirebaseFirestore db = DatabaseService().db;
    final CollectionReference collectionReferenceProduct = db.collection("products");

    var productField = product.toMap();

    collectionReferenceProduct.doc(id).update(productField as Map<Object, Object?>);
  }

  @override
  delete(id) {
    final FirebaseFirestore db = DatabaseService().db;
    final CollectionReference collectionReferenceProducts = db.collection("products");
    collectionReferenceProducts.doc(id).delete();
  }


  @override
  getById(id) async {
    List products = [];
    final FirebaseFirestore db = DatabaseService().db;
    final CollectionReference collectionReferenceProducts = db.collection("products");

    QuerySnapshot query = await collectionReferenceProducts.get();

    for (var element in query.docs) {
      String _id = element.id;

      if (_id == id) {
        products.add(element.data());

        return products;
      }


    }
    return products;
  }

  @override
  Future<List> belongTo(attributeElement, elementToSearch) async {
    List products = [];

    final FirebaseFirestore db = DatabaseService().db;
    final CollectionReference collectionReferenceProducts = db.collection("products");

    QuerySnapshot query = await collectionReferenceProducts.get();

    for (var element in query.docs) {
      String id = element.id;

      var productData = {};
      if (element[attributeElement] == elementToSearch) {
        productData[id] = element.data();
        products.add(productData);
      }
    }
    return products;
    }
}
