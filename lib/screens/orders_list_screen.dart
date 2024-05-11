import 'package:store/controllers/productController.dart';
import 'package:store/screens/product_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/screens/product_list_zero_screen.dart';
import '../controllers/recordController.dart';
import 'formularioProducto.dart';
import 'login_screen.dart';
import 'order_screen.dart';

class OrderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de pedidos"),
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
              onTap: () {},
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
              leading: const Icon(CupertinoIcons.delete),
              title: const Text('Sin Stock'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProductListZeroAM()));
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
                hintText: 'Buscar pedidos...',
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
                child: FutureBuilder<List>(
                  future: RecordController().getAll(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // Data is ready, display the list
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          // Access and use product data from the snapshot
                          String id = snapshot.data![index].keys.first;

                          Map<String, dynamic> recordDetails = snapshot.data![index][id];

                          String imagen = 'images/image2.jpg';
                          String titulo = recordDetails['idProducto'];
                          String idProducto = recordDetails['idProducto'];
                          String  estado = recordDetails['estado'];
                          String  descripcion = '';

                         return FutureBuilder<List>(
                             future: ProductController().getById(idProducto),
                             builder: (context, productSnapshot){

                               List<dynamic>? product = productSnapshot.data;

                               product?.forEach((element) {
                                 titulo = element['nombre'];
                                 imagen = element['img'];
                                 descripcion = "${element['descripcion']
                                     .toString()
                                     .substring(0,17)}...";
                               });


                               return InkWell(
                                 onTap: () {
                                   Navigator.push(context,
                                       MaterialPageRoute(builder: (context) => PedidosPage(id: id)));
                                 },
                                 child: Container(
                                   margin: EdgeInsets.symmetric(vertical: 15),
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     children: [
                                       ClipRRect(
                                         borderRadius: BorderRadius.circular(10),
                                         child: Image.network(
                                           imagen,
                                           height: 90,
                                           width: 90,
                                           fit: BoxFit.cover,
                                         ),
                                       ),
                                       SizedBox(width: 20),
                                       Column(
                                         mainAxisAlignment: MainAxisAlignment.end,
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Text(
                                             titulo,
                                             style: TextStyle(
                                               color: Colors.black,
                                               fontWeight: FontWeight.w900,
                                               fontSize: 18,
                                             ),
                                           ),
                                           SizedBox(height: 10),
                                           Text(
                                             descripcion,
                                             style: TextStyle(
                                               color: Colors.black,
                                               fontSize: 16,
                                             ),
                                           ),
                                           SizedBox(height: 10),
                                           Text(
                                             estado,
                                             style: TextStyle(
                                               color: Colors.pink,
                                               fontSize: 18,
                                               fontWeight: FontWeight.w900,
                                             ),
                                           ),
                                         ],
                                       ),
                                       SizedBox(width: 1),
                                     ],
                                   ),
                                 ),
                               );
                             }
                         );
                        },
                      );
                    } else if (snapshot.hasError) {
                      // Handle error
                      return Center(child: Text(snapshot.error.toString()));
                    } else {
                      // Show loading indicator while data is being fetched
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
