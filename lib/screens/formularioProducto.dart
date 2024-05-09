import 'package:flutter/cupertino.dart';
import 'package:store/controllers/productController.dart';
import 'package:store/screens/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:store/tdo/productTDO.dart';
import 'dart:io';
import '../services/select_image.dart';
import '../services/upload_image.dart';
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
  TextEditingController _categoriaController = TextEditingController();
  String _imageUrl = '';
  File? imagen_to_upload;

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
      int descuento = int.parse(_descuentoController.text);
      String categoria = _categoriaController.text;
      String img = _imageUrl;
      // También puedes manejar la imagen (_imageUrl) como necesites
      // Por ejemplo, subirla a un servidor o guardar la URL en la base de datos
      List errors = checkData();
      if(errors.isNotEmpty) {
        for (var error in errors) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$error')),
          );
        }
        return;
      }

      ProductController productController = ProductController();
      productController.create(ProductTDO(
          nombre: nombre,
          descripcion: descripcion,
          color: color,
          talla: talla,
          marca: marca,
          img: img,
          cantidad: cantidad,
          precio: precio,
          descuento: descuento,
          categoria: categoria));
      // Luego de manejar los datos, puedes reiniciar el formulario

      setState(() {
        _imageUrl = ''; // Reinicia la imagen después de agregar el producto
        _nombreController.text = '';
        _descripcionController.text = '';
        _colorController.text = '';
        _tallaController.text = '';
        _marcaController.text = '';
        _cantidadController.text = '';
        _precioController.text = '';
        _descuentoController.text = '';
        _categoriaController.text ='';
      });

      // Muestra un mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Producto agregado: $nombre')),
      );
    }
  }

  List checkData() {
    List errors = [];
    if (_nombreController.text.length <= 2) {
      errors.add('El nombre debe tener al menos 3 letras de longitud');
    }

    if (_descripcionController.text.length <= 25) {
      errors.add('La descripcion debe tener al menos 25 letras de longitud');
    }

    if (_colorController.text.isEmpty) {
      errors.add('El campo color no puede estar vacío');
    }

    if (_tallaController.text.isEmpty) {
      errors.add('El campo talla no puede estar vacío');
    }

    if (_marcaController.text.isEmpty) {
      errors.add('El campo marca no puede estar vacío');
    }

    if (int.parse(_cantidadController.text.toString()) < 0) {
      errors.add('No puedes escribir numeros negativos como cantidad');
    }
    if (double.parse(_precioController.text.toString()) < 0) {
      errors.add('No puedes escribir numeros negativos como precio');
    }

    if (int.parse(_descuentoController.text.toString()) < 0) {
      errors.add('No puedes escribir numeros negativos como descuento');
    }

    if (_categoriaController.text.isEmpty) {
      errors.add('El campo categoria no puede estar vacío');
    }


    if (_imageUrl.isEmpty) {
      errors.add('No puedes publicar un producto sin imagen');
    }

    return errors;
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
              leading: const Icon(CupertinoIcons.delete),
              title: const Text('Sin Stock'),
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
              TextFormField(
                controller: _categoriaController,
                decoration: const InputDecoration(
                  labelText: 'Categoría',
                  icon: Icon(Icons.category),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la categoría';
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
                onPressed: () async {
                  // Aquí puedes implementar la lógica para seleccionar y cargar la imagen
                  // Puedes usar plugins como image_picker para esto
                  // En este ejemplo, simplemente mostramos un mensaje de ejemplo
                  final imagen = await getImage();
                  setState(()  {
                    imagen_to_upload = File(imagen!.path);
                  });

                  Upload up = Upload();
                  await up.uploadImage(imagen_to_upload!);

                  setState(() {
                    _imageUrl = up.getUrl();
                  });

                 // ScaffoldMessenger.of(context).showSnackBar(
                   // SnackBar(content: Text('Selecciona una imagen')),
                  //);
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