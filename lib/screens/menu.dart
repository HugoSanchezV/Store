import 'package:aplicacion_ventas/screens/formularioProducto.dart';
import 'package:aplicacion_ventas/screens/login_screen.dart';
import 'package:aplicacion_ventas/screens/orders_list_screen.dart';
import 'package:aplicacion_ventas/screens/product_list_screen.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin App'),
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: AssetImage("images/imagen1.png"),
              fit: BoxFit.cover,
              opacity: 0.5,
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart,
              size: 225,
              color: Colors.pink,
            ),
            Text(
              "MASTER FITNESS",
              style: TextStyle(
                color: Colors.pink,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            )
          ],
        ),
      ),
    );
  }
}
