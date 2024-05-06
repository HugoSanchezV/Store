import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/screens/user_change_data.dart';

class UserChangeData extends StatefulWidget {
  final String nombre;
  final String telefono;
  final String direccion;
  final String segundaDireccion;
  final String tipoPago;

  const UserChangeData({
    Key? key,
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

  @override
  void initState() {
    super.initState();
    _getUserEmail();
  }

  void _getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final userEmail = prefs.getString('userEmail') ?? '';
    print('Correo electrónico del usuario: $userEmail');
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
                        decoration: InputDecoration(
                          labelText: "Ingresar nombre",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        initialValue: widget.nombre,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu nombre';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Ingresar tu numero de telefono",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        initialValue: widget.telefono,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu numero de telefono';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Ingresar dirección",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        initialValue: widget.direccion,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu dirección';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Ingresar segunda dirección",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        initialValue: widget.segundaDireccion,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu segunda dirección';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Ingresar tipo de pago",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        initialValue: widget.tipoPago,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu tipo de pago';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            // Realizar acciones con los datos
                          }
                        },
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