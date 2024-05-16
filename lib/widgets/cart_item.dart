import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/controllers/productController.dart';
import 'package:store/widgets/remove_product_cart_popup.dart';

import '../models/cart.dart';  // Asegúrate de que esta ruta sea correcta

class CartItemWidget extends StatelessWidget {
  final String id;
  final String nombre;
  final int quantity;
  final double precio;
  final String imageUrl;

  CartItemWidget({
    required this.id,
    required this.nombre,
    required this.quantity,
    required this.precio,
    required this.imageUrl,
  }){
    print('CartItemWidget creado para producto: $nombre');
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.red,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(id);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
            ),
            title: Text(nombre),
            subtitle: Text('Total: \$${(precio * quantity)}'),
            trailing: FittedBox(
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove,
                      color: Colors.red,),
                    onPressed: () {
                      // Decrement the quantity of the item
                      if (quantity > 1) {
                        Provider.of<Cart>(context, listen: false).removeSingleItem(id);
                      } else {
                        showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          isDismissible: false,
                          enableDrag: true,
                          context: context,
                          builder: (context) => RemoveProductCartPopUp(id: id),
                        );
                      }
                    },
                  ),
                  Text('$quantity x'),
                  IconButton(
                    icon: Icon(Icons.add,
                      color: Colors.green,),
                    onPressed: () async {
                      if(await ProductController().QuantityVerification(quantity)){
                        Provider.of<Cart>(context, listen: false).addItem(
                          id,
                          nombre,
                          precio,
                          imageUrl,
                        );
                      }else {

                      }

                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
