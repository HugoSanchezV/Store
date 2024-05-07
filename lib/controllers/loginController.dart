import 'package:store/apis/login_api.dart';
import 'package:store/tdo/loginTDO.dart';
import 'package:store/dao/login_dao.dart';
import 'package:store/apis/belong_to_api.dart';

import '../apis/api_crud.dart';

class loginController {
  final ApiLogin<loginTDO> _login = LoginDao();


  Future<bool> CredentialVerification(email, password) async
  {
      String existingEmail = await _login.getEmail(email);
      String existingPassword = await _login.getPassword(password);
      print("Email enviado: "+email);
      print("Password enviado: "+password);


      if(existingEmail.isEmpty){

        print("El correo ingresado no existe");
        return false;
      }else{
          if(existingPassword != existingEmail) {
            String a = await _login.getMatch(existingEmail, password);
            if(a == password){
              print("Todo correcto");
              return true;
            }else{
              print("El correo o contraseña es incorrecto.aaaa");
              return false;
            }


          }else if(existingPassword.isEmpty){
            print("El correo o contraseña es incorrecto.dddd");
            return false;
          }else{
            print("Todo correcto");
            return true
                ;
          }
      }


  }
}
