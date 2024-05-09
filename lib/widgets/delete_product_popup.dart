import 'package:store/screens/product_list_screen.dart';
import 'package:store/tdo/productTDO.dart';
import 'package:store/widgets/container_icon_button_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../controllers/productController.dart';
import 'container_button_motel.dart';

class DeleteProductPopUp extends StatelessWidget {
  String id;
  String name;
  DeleteProductPopUp({required this.id, required this.name});

  final iStyle = const TextStyle(
    color: Colors.black87,
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );

  String _product = "lorem ipsum dolor";

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) => Container(
            height: MediaQuery.of(context).size.height / 5,
            width: MediaQuery.of(context).size.width * .95,
            decoration: const BoxDecoration(
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
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Text(
                            "¿Quieres eliminar ",
                            style: iStyle,
                          ),
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink,
                            ),
                          ),
                          Text(
                            "?",
                            style: iStyle,
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {

                        List product = await ProductController().getById(id);

                        String nombre = product[0]['nombre'];
                        String descripcion = product[0]['descripcion'];
                        String color = product[0]['color'];
                        String talla = product[0]['talla'];
                        String marca = product[0]['marca'];

                        // Cantidad lo volvermos 0 para qie ya no se liste
                        int cantidad = 0;

                        double precio = product[0]['precio'];
                        int descuento = product[0]['descuento'];
                        String categoria = product[0]['categoria'].toString();
                        String img = product[0]['img'];


                        ProductTDO productZero = ProductTDO(
                            nombre: nombre,
                            descripcion: descripcion,
                            color: color,
                            talla: talla,
                            marca: marca,
                            img: img,
                            cantidad: cantidad,
                            precio: precio,
                            descuento: descuento,
                            categoria: categoria);

                        ProductController().update(id, productZero).then((value) => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListAM()))
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(55),
                        backgroundColor: Colors.pink,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Confirmar",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),

            ),
            ),
        );
      },
      child: const ContainerIconButtonModel(
        icon: CupertinoIcons.delete,
        iconColor: Colors.red,
        iconSize: 20,
        bgColor: Colors.transparent,
        containerWidth: 50,
      ),
    );
  }
}

