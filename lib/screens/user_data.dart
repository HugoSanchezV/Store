import 'package:flutter/material.dart';
import 'package:store/screens/user_change_data.dart';

class UserDataScreen extends StatelessWidget {
  final String nombre = 'Juan';
  final String apellidoPaterno = 'Pérez';
  final String apellidoMaterno = 'García';
  final String edad = '30';
  final String telefono = '555-123-4567';
  final String direccion = 'Calle Principal 123';
  final String segundaDireccion = '(No especificada)';
  final String tipoPago = 'Tarjeta de crédito';

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
            Text('Apellido paterno: $apellidoPaterno'),
            SizedBox(height: 15),
            Text('Apellido materno: $apellidoMaterno'),
            SizedBox(height: 15),
            Text('Edad: $edad'),
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
                    builder: (context) => UserChangeData(
                      nombre: nombre,
                      apellidoPaterno: apellidoPaterno,
                      apellidoMaterno: apellidoMaterno,
                      edad: edad,
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