import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/screens/forgot_screen.dart';
import 'package:store/screens/menu.dart';
import 'package:store/screens/product_screen.dart';
import 'package:store/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:store/controllers/loginController.dart';
import '../Presentation/Screens/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  String _correo = '';
  String _contrasena = '';
  bool _obscureTextTwo = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Material(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  Image.asset(
                    "images/icono2.png",
                    fit: BoxFit.fill,
                    width: 300,
                    height: 200,
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: "Ingresar correo",
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingresa tu correo';
                              }else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$').hasMatch(value)){
                                return 'Introduce un correo valido';
                              }

                            },
                            onChanged: (value) {
                              _correo = value;
                            },
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            obscureText: _obscureTextTwo,
                            decoration: InputDecoration(
                              labelText: "Ingresar contraseña",
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
                              }
                            },
                            onChanged: (value) {
                              _contrasena = value;
                            },
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ForgotScreen()));
                              },
                              child: Text(
                                "Olvidaste la contraseña?",
                                style: TextStyle(
                                  color: Colors.pink,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 25),
                          ElevatedButton(
                            onPressed: () async {
                              if(_formKey.currentState!.validate()){
                                loginController login = new loginController();

                                //Verifica la exitencia del correo y de la contraseña, y el match entre ellos
                                if(await login.CredentialVerification(_correo, _contrasena)){
                                  final prefs = await SharedPreferences.getInstance();
                                  await prefs.setString('userEmail', _emailController.text);
                                  if(await login.isAdmin(_correo)){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AdminHomePage(),
                                        ));
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => principalCliente(),
                                        ));
                                  }
                                }
                              }


                            },
                            child: Text(
                              "Acceder",
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
                                "No tienes una cuenta?",
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
                                        builder: (context) => SignupScreen(),
                                      ));
                                },
                                child: Text(
                                  "Registrarse",
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
        ));
  }
}
