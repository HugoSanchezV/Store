import 'package:store/apis/get_email_api.dart';
import 'package:store/apis/get_password_api.dart';
import 'package:store/apis/get_match.dart';

import '../tdo/loginTDO.dart';

abstract class ApiLogin<T> implements GetEmail<T>, GetPassword<T>, GetMatch<T>{

}