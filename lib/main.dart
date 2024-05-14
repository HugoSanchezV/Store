import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:store/controllers/productController.dart';
import 'package:store/controllers/userController.dart';
import 'package:store/screens/orders_list_screen.dart';
import 'package:store/screens/product_list_screen.dart';
import 'package:store/tdo/productTDO.dart';
import 'package:store/screens/formularioModificarProducto.dart';
import 'package:store/Presentation/Screens/main_screen.dart';


  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    runApp(const MyApp());
  }

  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'My App',
        home:  principalCliente(),
      );
    }
  }

/*
Future<void> main() async {

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var userData = {
    'id' : '',
    'name': 'Juianote aDSKADS;LK;',
    'email': 'correo@corre2.com',
    'password': 'lasdfasd',
    'phone': '4931756734',
    'token': 'asdfadsf',
    'auth': 0,
    'admin': 0,
    'address' : 'asdfsdf'

  };


  /// TODO pruebas de CarController, 👍
 //CarController carController = new CarController();
 //carController.create(new CarTDO(idUsuario: 5, idProducto: 6, cantidad: 4));
  // carController.update('LSK52lHmEj6jYsBa2Ut1', new CarTDO(idUsuario: 3, idProducto: 3, cantidad:3));
  //carController.delete('LSK52lHmEj6jYsBa2Ut1');
  //List s =  await carController.getAll();
  //print(s);
  //List s =  await carController.getById('bYZkC2QY3sUalBhKxqo9');
  //print(s);
  //List s = await carController.belongTo('idUsuario', 4);
  //print(s);


/// TODO prubas de ReviewController, BELONGTO NO FUNCONA 🤧
  ReviewController controller =  ReviewController();
 // controller.create(new ReviewTDO(idUsuario: 5, idProducto: 4, resena: "sewrwerwe", calificacion: 4));
//controller.update('AVOJ7wexaVhK4jG3K2nI', new ReviewTDO(idUsuario: 5, idProducto: 5, resena: "owo", calificacion: 4));
//controller.delete('AVOJ7wexaVhK4jG3K2nI');
List s = await controller.getAll();
  //List  s = await controller.getById('AVOJ7wexaVhK4jG3K2nI');
  //List s =  await controller.belongTo('idProducto', 4);
  // print(s);


  /// TODO pruebas de UserController todas funcinoan
  /// TODO pruebas de RecordController, todas funcioanan


  // falta producto

}

*/
