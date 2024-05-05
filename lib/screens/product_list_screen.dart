import 'package:store/controllers/productController.dart';
import 'package:store/screens/formularioModificarProducto.dart';
import 'package:store/widgets/confirmation_purchase_popup.dart';
import 'package:store/widgets/container_button_motel.dart';
import 'package:store/widgets/container_icon_button_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/delete_product_popup.dart';
import 'formularioProducto.dart';
import 'login_screen.dart';
import 'orders_list_screen.dart';

class ProductListAM extends StatefulWidget {
  @override
  _ProductListAMState createState() => _ProductListAMState();
}

class _ProductListAMState extends State<ProductListAM>  {
  List imagesList = [
  ];

  List productTitles = [
  ];

  List prices = [
  ];

  List ids = [
  ];

  List descriptions = [
  ];

  @override
  void initState() {
    super.initState();
    ProductController productController =  ProductController();

    productController.getAll().then((products) {
      for (var productData in products) {
        String id = productData.keys.first;
        Map<String, dynamic> productDetails = productData[id];
        ids.add(id);
        productDetails.forEach((key, value) {
          if (key == "img") {
            imagesList.add(value);
          }
          if (key == "nombre") {
            productTitles.add(value);
          }
          if (key == "precio") {
            prices.add("\$" + value.toString());
          }

          if (key == "descripcion") {
            descriptions.add(value.toString().substring(0, 17) + "...");
          }
        });
      }
    });
  }




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
            const DrawerHeader(
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
              title: const Text('Lista de Productos'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProductListAM()));
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: const Text('Agregar Producto'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AgregarProducto()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notificaciones'),
              onTap: () {
              },
            ),
            ListTile(
              leading: const Icon(Icons.assignment),
              title: const Text('Pedidos'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OrderList()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.no_accounts),
              title: const Text('Cerrar sesion'),
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
            padding: const EdgeInsets.all(15),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar productos...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
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
                                  child: Image.network(
                                    imagesList[index],
                                    height: 85,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      productTitles[index],
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      descriptions[index],
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      prices[index],
                                      style: const TextStyle(
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
                                                    ModificarProducto(id: ids[index])));
                                      },
                                      child: const ContainerIconButtonModel(
                                        icon: CupertinoIcons.settings,
                                        iconColor: Colors.grey,
                                        iconSize: 20,
                                        containerWidth: 50,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
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
