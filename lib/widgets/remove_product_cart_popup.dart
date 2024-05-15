import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/screens/review_screen.dart';
import 'package:store/widgets/container_button_motel.dart';

import '../models/cart.dart';
import '../screens/product_list_screen.dart';

class RemoveProductCartPopUp extends StatelessWidget {
  final String id;

  RemoveProductCartPopUp({
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return _buildPopup(context);
  }

  Widget _buildPopup(BuildContext context) {
    return Align(
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
                _buildTitle(),
                _buildRemoveButton(context),
                Center(
                  child: Icon(CupertinoIcons.arrow_down),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Align(
      alignment: Alignment.center,
      child: Text(
        "¿Quieres remover el producto del carrito?",
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _buildRemoveButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Provider.of<Cart>(context, listen: false).removeSingleItem(id);
        Navigator.of(context).pop();
      },
      child: Text(
        "Remover",
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size.fromHeight(55)),
        backgroundColor: MaterialStateProperty.all(Colors.pink),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
