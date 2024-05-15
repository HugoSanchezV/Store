import 'package:provider/provider.dart';
import 'package:store/controllers/productController.dart';
import 'package:store/screens/review_screen.dart';
import 'package:store/screens/splash_screen.dart';
import 'package:store/widgets/container_button_motel.dart';
import 'package:flutter/material.dart';

import '../models/cart.dart';
import '../tdo/productTDO.dart';

class ConfirmationPurchasePopUp extends StatelessWidget {
  final iStyle = TextStyle(
    color: Colors.black87,
    fontWeight: FontWeight.w600,
      fontSize: 20
  );

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return InkWell(
      onTap: (){
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
                      Text(
                          "Total Payment",
                          style: iStyle
                      ),
                      Text(
                          "\$${cart.totalAmount.toStringAsFixed(2)}",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      cart.items.forEach((key, value) async {
                        List productCurrent = await ProductController().getById(value.id);
                          var product = productCurrent[0];
                          var nombre = product['nombre'];
                          var descripcion = product['descripcion'];
                          var color = product['color'];
                          var talla = product['talla'];
                          var marca = product['marca'];
                          var img = product['img'];
                          var cantidad = product['cantidad'];
                          var precio = product['precio'];
                          var descuento = product['descuento'];
                          var categoria = product['categoria'];
                          ProductController().update(value.id, ProductTDO(
                              nombre: nombre,
                              descripcion: descripcion,
                              color: color,
                              talla: talla,
                              marca: marca,
                              img: img,
                              cantidad: cantidad - value.quantity,
                              precio: precio,
                              descuento: descuento,
                              categoria: categoria));
                      });
                      cart.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Se ha realizado la compra.'),
                        ),
                      );
                      Navigator.of(context).pop(); // Cierra el popup después de confirmar
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
                        )
                    ),
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
