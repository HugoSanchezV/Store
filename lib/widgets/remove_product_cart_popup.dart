import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aplicacion_ventas/screens/review_screen.dart';
import 'package:aplicacion_ventas/widgets/container_button_motel.dart';

import '../screens/product_list_screen.dart';

class RemoveProductCartPopUp extends StatelessWidget {
  final iStyle = TextStyle(
    color: Colors.black87,
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          isDismissible: false,
          enableDrag: true,
          context: context,
          builder: (context) => Align(
            // Ajustamos el popup más arriba en la pantalla
            alignment: Alignment.topCenter,
            child: FractionalTranslation(
              translation: Offset(0.0, -0.5),
              child: Container(
                height: MediaQuery.of(context).size.height * .3,
                width: MediaQuery.of(context).size.width * .95,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child:
                        Text(
                          "¿Quieres remover el producto del carrito?",
                          style: iStyle,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {

                        },
                        child: Text(
                          "Remover",
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
                          ),
                        ),
                      ),
                      Center(
                        child: Icon(CupertinoIcons.arrow_down),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      child:
      ContainerButtonModel(
        containerWidth: MediaQuery.of(context).size.width / 1.5,
        itext: "Confirmar compra",
        bgColor: Colors.pink,
      ),
    );
  }
}
