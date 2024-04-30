import 'package:aplicacion_ventas/screens/formularioModificarProducto.dart';
import 'package:aplicacion_ventas/widgets/confirmation_purchase_popup.dart';
import 'package:aplicacion_ventas/widgets/container_button_motel.dart';
import 'package:aplicacion_ventas/widgets/container_icon_button_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/delete_product_popup.dart';
import 'formularioProducto.dart';
import 'login_screen.dart';
import 'orders_list_screen.dart';

class ProductListAM extends StatelessWidget {
  List imagesList = [
    "images/image2.jpg",
    "images/image2.jpg",
    "images/image2.jpg",
  ];

  List productTitles = [
    "Producto 1",
    "Producto 2",
    "Producto 3",
  ];

  List prices = [
    "\$999",
    "\$999",
    "\$999",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de productos"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.pink,
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag),
              title: Text('Lista de Productos'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProductListAM()));
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Agregar Producto'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AgregarProducto()));
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notificaciones'),
              onTap: () {
              },
            ),
            ListTile(
              leading: Icon(Icons.assignment),
              title: Text('Pedidos'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OrderList()));
              },
            ),
            ListTile(
              leading: Icon(Icons.no_accounts),
              title: Text('Cerrar sesion'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar productos...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Container(
                      child: ListView.builder(
                        itemCount: imagesList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    imagesList[index],
                                    height: 90,
                                    width: 90,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      productTitles[index],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Lorem ipsum dolor",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      prices[index],
                                      style: TextStyle(
                                        color: Colors.pink,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(width: 10),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ModificarProducto()));
                                      },
                                      child: ContainerIconButtonModel(
                                        icon: CupertinoIcons.settings,
                                        iconColor: Colors.grey,
                                        iconSize: 20,
                                        containerWidth: 50,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    DeleteProductPopUp(),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
