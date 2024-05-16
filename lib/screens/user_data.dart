import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/screens/user_change_data.dart';
import 'package:store/controllers/userController.dart';

class UserDataScreen extends StatefulWidget {
  @override
  _UserDataScreenState createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  String userid = '';
  String nombre = '';
  String correo = '';
  String telefono = '';
  String direccion = '';
  String segundaDireccion = '';
  String tipoPago = '';
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    _getUserEmail();
    _getUserData();
  }

  void _getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    userEmail = prefs.getString('userEmail') ?? '';
    print('Correo electrónico del usuario: $userEmail');
  }

  void _getUserData() async {
    UserController userController = UserController();
    Map<String, dynamic> userCurrent;

    userController.getAll().then((user) {
      for (var usersData in user) {
        String id = usersData.keys.first;
        Map<String, dynamic> userDetails = usersData[id];
        userDetails.forEach((key, value) {
          if (key == "email") {
            if (value == userEmail) {
              print("Coincide");
              userCurrent = userDetails;
              setState(() {
                userid = id;
                nombre = userDetails['name'];
                direccion = userDetails['address'];
                telefono = userDetails['phone'];
                correo = userDetails['email'];
              });
            }
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        leading: BackButton(),
        elevation: 0,
        title: Text('Datos de usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Image.asset(
              "images/icono2.png",
              fit: BoxFit.fill,
              width: 300 * .25,
              height: 200 * .25,
            ),
            SizedBox(height: 15),
            Text('Nombre: $nombre'),
            SizedBox(height: 15),
            Text('Correo: $correo'),
            SizedBox(height: 15),
            Text('Número de teléfono: $telefono'),
            SizedBox(height: 15),
            Text('Dirección: $direccion'),
            SizedBox(height: 15),
            Text('Segunda dirección: $segundaDireccion'),
            SizedBox(height: 15),
            Text('Tipo pago: $tipoPago'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        UserChangeData(
                          userid: userid,
                          nombre: nombre,
                          telefono: telefono,
                          direccion: direccion,
                          segundaDireccion: segundaDireccion,
                          tipoPago: tipoPago,
                        ),
                  ),
                );
              },
              child: Text(
                'Editar usuario',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(55),
                backgroundColor: Colors.pink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
