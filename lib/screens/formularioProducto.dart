import 'package:aplicacion_ventas/screens/product_list_screen.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'orders_list_screen.dart';

class AgregarProducto extends StatefulWidget {
  @override
  _AgregarProductoState createState() => _AgregarProductoState();
}

class _AgregarProductoState extends State<AgregarProducto> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _descripcionController = TextEditingController();
  TextEditingController _colorController = TextEditingController();
  TextEditingController _tallaController = TextEditingController();
  TextEditingController _marcaController = TextEditingController();
  TextEditingController _cantidadController = TextEditingController();
  TextEditingController _precioController = TextEditingController();
  TextEditingController _descuentoController = TextEditingController();
  String _imageUrl = '';

  void _agregarProducto() {
    if (_formKey.currentState!.validate()) {
      // Puedes manejar los datos del producto aquí
      String nombre = _nombreController.text;
      String descripcion = _descripcionController.text;
      String color = _colorController.text;
      String talla = _tallaController.text;
      String marca = _marcaController.text;
      int cantidad = int.parse(_cantidadController.text);
      double precio = double.parse(_precioController.text);
      double descuento = double.parse(_descuentoController.text);
      // También puedes manejar la imagen (_imageUrl) como necesites
      // Por ejemplo, subirla a un servidor o guardar la URL en la base de datos

      // Luego de manejar los datos, puedes reiniciar el formulario
      _formKey.currentState!.reset();
      setState(() {
        _imageUrl = ''; // Reinicia la imagen después de agregar el producto
      });

      // Muestra un mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Producto agregado: $nombre')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'images/icono1.png',
              fit: BoxFit.fill, // Ruta de tu logo
              height: 80.0,
              width: 80.0,
            ),
            SizedBox(width: 8.0),
            Text('Agregar Producto'),
          ],
        ),
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  icon: Icon(Icons.shopping_bag),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descripcionController,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  icon: Icon(Icons.description),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la descripción';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _colorController,
                decoration: InputDecoration(
                  labelText: 'Color',
                  icon: Icon(Icons.color_lens),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el color';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _tallaController,
                decoration: InputDecoration(
                  labelText: 'Talla',
                  icon: Icon(Icons.format_size),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la talla';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _marcaController,
                decoration: InputDecoration(
                  labelText: 'Marca',
                  icon: Icon(Icons.branding_watermark),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la marca';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cantidadController,
                decoration: InputDecoration(
                  labelText: 'Cantidad',
                  icon: Icon(Icons.add_shopping_cart),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la cantidad';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _precioController,
                decoration: InputDecoration(
                  labelText: 'Precio',
                  icon: Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el precio';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descuentoController,
                decoration: InputDecoration(
                  labelText: 'Descuento',
                  icon: Icon(Icons.money_off),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el descuento';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _agregarProducto,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink, // Cambia el color del botón a rosado
                ),
                child: Text('Agregar Producto',
                style: TextStyle(
                  color: Colors.black
                ),),
              ),
              SizedBox(height: 16.0),
              _imageUrl.isEmpty
                  ? Text('No se ha seleccionado una imagen.')
                  : Image.network(
                _imageUrl,
                height: 200,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Aquí puedes implementar la lógica para seleccionar y cargar la imagen
                  // Puedes usar plugins como image_picker para esto
                  // En este ejemplo, simplemente mostramos un mensaje de ejemplo
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selecciona una imagen')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink, // Cambia el color del botón a rosado
                ),
                child: Text('Seleccionar Imagen',
                style: TextStyle(
                  color: Colors.black,
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}