import 'package:aplicacion_ventas/widgets/container_icon_button_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'container_button_motel.dart';

class DeleteProductPopUp extends StatelessWidget {
  final iStyle = TextStyle(
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
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Text(
                            "¿Quieres eliminar ",
                            style: iStyle,
                          ),
                          Text(
                            _product,
                            style: TextStyle(
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
                      onPressed: () {},
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
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),

            ),
            ),
        );
      },
      child: ContainerIconButtonModel(
        icon: CupertinoIcons.delete,
        iconColor: Colors.red,
        iconSize: 20,
        bgColor: Colors.transparent,
        containerWidth: 50,
      ),
    );
  }
}

