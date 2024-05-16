import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/controllers/userController.dart';
import 'package:store/tdo/userTDO.dart';

class UserChangeData extends StatefulWidget {
  final String userid;
  final String nombre;
  final String telefono;
  final String direccion;
  final String segundaDireccion;
  final String tipoPago;

  const UserChangeData({
    Key? key,
    required this.userid,
    required this.nombre,
    required this.telefono,
    required this.direccion,
    required this.segundaDireccion,
    required this.tipoPago,
  }) : super(key: key);

  @override
  State<UserChangeData> createState() => _UserChangeDataState();
}

class _UserChangeDataState extends State<UserChangeData> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _telefonoController;
  late TextEditingController _direccionController;
  late TextEditingController _segundaDireccionController;
  late TextEditingController _tipoPagoController;

  String userEmail = '';

  @override
  void initState() {
    super.initState();
    _getUserEmail();
    _nombreController = TextEditingController(text: widget.nombre);
    _telefonoController = TextEditingController(text: widget.telefono);
    _direccionController = TextEditingController(text: widget.direccion);
    _segundaDireccionController = TextEditingController(text: widget.segundaDireccion);
    _tipoPagoController = TextEditingController(text: widget.tipoPago);
  }

  void _getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    userEmail = prefs.getString('userEmail') ?? '';
    print('Correo electrónico del usuario: $userEmail');
  }

  Future<void> changeDataUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      UserController userController = UserController();
      List userCurrent = await userController.getById(widget.userid);
      var userC = userCurrent[0];
      var email = userC['email'];
      var password = userC['password'];

      UserTDO user = UserTDO({
        'id': widget.userid,
        'name': _nombreController.text,
        'phone': _telefonoController.text,
        'address': _direccionController.text,
        'email': email,
        'password': password,
          'secondAddress': _segundaDireccionController.text,
        'paymentType': _tipoPagoController.text,
      });

      try {
        await userController.update(widget.userid, user);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Datos actualizados correctamente')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al actualizar los datos: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar datos de usuario"),
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Image.asset(
                "images/icono2.png",
                fit: BoxFit.fill,
                width: 300 * .25,
                height: 200 * .25,
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nombreController,
                        decoration: InputDecoration(
                          labelText: "Ingresar nombre",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu nombre';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _telefonoController,
                        decoration: InputDecoration(
                          labelText: "Ingresar tu numero de telefono",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.phone),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu numero de telefono';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _direccionController,
                        decoration: InputDecoration(
                          labelText: "Ingresar dirección",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.home),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu dirección';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _segundaDireccionController,
                        decoration: InputDecoration(
                          labelText: "Ingresar segunda dirección",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.home),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu segunda dirección';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _tipoPagoController,
                        decoration: InputDecoration(
                          labelText: "Ingresar tipo de pago",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.payment),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu tipo de pago';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: changeDataUser,
                        child: Text(
                          "Editar datos",
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
