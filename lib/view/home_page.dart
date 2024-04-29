import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store/services/select_image.dart';
import 'package:store/services/upload_image.dart';

class HomePage extends StatefulWidget{
  const HomePage({
    Key? key,

}): super (key:key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  File? imagen_to_upload;

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            height: 200,
            width: double.infinity,
            color: Colors.red,
          ),
          ElevatedButton(
              onPressed: () async {
                final imagen = await getImage();
                setState(() {
                  imagen_to_upload = File(imagen!.path);
                });
              }, child: Text("Seleccionar imagen")),
          ElevatedButton(
              onPressed: () async{
                if(imagen_to_upload == null)
                  {
                    return;
                  }
                final uploaded = await uploadImage(imagen_to_upload!);


          }, child: Text("Subir a firebase"))

    ],
      )
    );
  }
}