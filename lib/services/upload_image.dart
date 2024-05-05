import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage storage = FirebaseStorage.instance;


class Upload {
  String url = '';
  Future<bool> uploadImage(File image) async{
    print(image.path);
    final String nameFile = image.path.split("/").last;

    final Reference ref = storage.ref().child("images").child(nameFile);
    final UploadTask uploadTask = ref.putFile(image);
    print(uploadTask);

    final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);
    print(snapshot);

    this.url = await snapshot.ref.getDownloadURL();

    return false;
  }

  String getUrl(){ return url;}
}
