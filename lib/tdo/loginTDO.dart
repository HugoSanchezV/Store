class loginTDO {
  final String correo;
  final String contrasena;


  loginTDO({required this.correo,required this.contrasena});


  Map<String, dynamic> toMap() {
    return {
      'correo': correo,
      'contrasena':contrasena
    };
  }
}