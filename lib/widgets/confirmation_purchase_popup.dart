import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/controllers/productController.dart';
import 'package:store/screens/review_screen.dart';
import 'package:store/screens/splash_screen.dart';
import 'package:store/widgets/container_button_motel.dart';
import 'package:flutter/material.dart';

import '../controllers/recordController.dart';
import '../controllers/userController.dart';
import '../models/cart.dart';
import '../tdo/productTDO.dart';
import '../tdo/recordTDO.dart';

class ConfirmationPurchasePopUp extends StatelessWidget {
  DateTime now = DateTime.now();

  final iStyle = TextStyle(
      color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 20);

  Future<String> _getDate() async {
    return "${now.day}/${now.month}/${now.year}";
  }

  Future<String> _getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userEmail') ?? '';
  }

  Future<String> _getUserId() async {
    UserController userController = UserController();

      List users = await userController.getAll();
      String userEmail = await _getUserEmail();

      for (var user in users) {
        String id = user.keys.first;
        Map<String, dynamic> userDetails = user[id];
        if (userDetails['email'] == userEmail) {
          print(id);
          return id;
        }
      }
      return '';
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return InkWell(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) => Container(
            height: MediaQuery.of(context).size.height / 2.5,
            width: MediaQuery.of(context).size.width * .95,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Payment", style: iStyle),
                      Text(
                        "\$${cart.totalAmount.toStringAsFixed(2)}",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      var userId;
                      var date;
                      var product;
                      String nombre;
                      String descripcion;
                      String color;
                      String talla;
                      String marca;
                      String img;
                      int cantidad;
                      double precio;
                      int descuento;
                      String categoria;
                      cart.items.forEach((key, value) async {
                        userId = await _getUserId();
                        date = await _getDate();

                        List productCurrent =
                            await ProductController().getById(value.id);
                        product = productCurrent[0];
                        var id = value.id;
                        nombre = product['nombre'];
                        descripcion = product['descripcion'];
                        color = product['color'];
                        talla = product['talla'];
                        marca = product['marca'];
                        img = product['img'];
                        cantidad = product['cantidad'];
                        precio = product['precio'];
                        descuento = product['descuento'];
                        categoria = product['categoria'];

                        await ProductController().update(
                            value.id,
                            ProductTDO(
                                nombre: nombre,
                                descripcion: descripcion,
                                color: color,
                                talla: talla,
                                marca: marca,
                                img: product['img'],
                                cantidad: cantidad - value.quantity,
                                precio: precio,
                                descuento: descuento,
                                categoria: categoria));

                        print(userId);
                        print(precio * value.quantity);
                        print(value.quantity);
                        print(id);
                        print(date);

                        await RecordController().create(RecordTDO(
                           idUsuario: userId,
                           precio: precio * value.quantity,
                           cantidad: value.quantity,
                           estado: "en espera",
                           idProducto: id,
                           fecha: date,
                         ));
                      });

                      cart.clear();
                      Navigator.of(context)
                          .pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Se ha realizado la compra.'),
                        ),
                      );

                    },
                    child: Text(
                      "Confirmar",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(55),
                        backgroundColor: Colors.pink,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: ContainerButtonModel(
        containerWidth: MediaQuery.of(context).size.width / 1.5,
        itext: "Confirmar compra",
        bgColor: Colors.pink,
      ),
    );
  }
}
