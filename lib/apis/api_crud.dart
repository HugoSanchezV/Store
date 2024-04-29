import 'package:store/apis/api_delete.dart';
import 'package:store/apis/belong_to_api.dart';
import 'package:store/apis/create_api.dart';
import 'package:store/apis/get_all_api.dart';
import 'package:store/apis/get_by_id_api.dart';
import 'package:store/apis/update_api.dart';


abstract class ApiCrud<T> implements Create<T>, Delete<T>, Update<T>, GetAll<T>,
    GetById<T>, BelongTo<T>{

}