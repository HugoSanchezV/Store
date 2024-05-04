import 'package:store/Presentation/Screens/main_screen.dart';
import 'package:store/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:store/screens/cart_screen.dart';
import 'package:store/screens/login_screen.dart';
import 'package:store/screens/signup_success_screen.dart';

import '../controllers/userController.dart';
import '../tdo/userTDO.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  String _nombre = '';
  String _correo = '';
  String _telefono = '';
  String _domicilio = '';
  String _contrasena = '';
  String _confirmarContrasena = '';
  bool _obscureText = true;
  bool _obscureTextTwo = true;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu nombre';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _nombre = value!;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Ingresar correo",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu correo';
                          } else if (!RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Por favor, ingresa un correo electrónico válido';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _correo = value!;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Ingresar número de teléfono",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.phone),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu número de teléfono';
                          } else if (value.length != 10 ||
                              !RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'Por favor, ingresa un número de teléfono válido (10 dígitos)';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _telefono = value!;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Ingresar domicilio",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.home),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu domicilio';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _domicilio = value!;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          labelText: "Ingresar contraseña",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureText
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu contraseña';
                          } else if (value.length < 8) {
                            return 'La contraseña debe tener al menos 8 caracteres';
                          } else {
                            _contrasena = value;
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _contrasena = value!;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        obscureText: _obscureTextTwo,
                        decoration: InputDecoration(
                          labelText: "Confirmar contraseña",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureTextTwo
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _obscureTextTwo = !_obscureTextTwo;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu contraseña';
                          } else if (value != _contrasena) {
                            return 'Las contraseñas no coinciden';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            var userData = {
                              'name': '$_nombre',
                              'email': '$_correo',
                              'password': '$_contrasena',
                              'phone': '$_telefono',
                              'token': 'token',
                              'auth': 0,
                              'admin': 0,
                              'address': '$_domicilio'
                            };

                            print(userData);
                            UserController user = UserController();
                            user.create(UserTDO(userData));

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpSuccessScreen()),
                            );
                          }
                        },
                        child: Text(
                          "Crear cuenta",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(55),
                            backgroundColor: Colors.pink,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "¿Ya tienes una cuenta?",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
                            },
                            child: Text(
                              "Acceder",
                              style: TextStyle(
                                color: Colors.pink,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
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
