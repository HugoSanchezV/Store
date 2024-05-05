import 'package:store/controllers/productController.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../services/select_image.dart';
import '../services/upload_image.dart';
import '../tdo/productTDO.dart';

class ModificarProducto extends StatefulWidget {
  final String id;
  ModificarProducto({required this.id});

  @override
  _ModificarProductoState createState() => _ModificarProductoState(id: this.id);
}

class _ModificarProductoState extends State<ModificarProducto> {
  final String id;
  File? imagen_to_upload;
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

  _ModificarProductoState({required this.id});

  @override
  void initState() {
    super.initState();
    ProductController productController = ProductController();
    productController.getById(id).then((product) {
      // Update UI with product data
      _nombreController.text = product[0]['nombre'];
      _descripcionController.text = product[0]['descripcion'];
      _colorController.text = product[0]['color'];
      _tallaController.text = product[0]['talla'];
      _marcaController.text = product[0]['marca'];
      _cantidadController.text = product[0]['cantidad'].toString();
      _precioController.text = product[0]['precio'].toString();
      _descuentoController.text = product[0]['descuento'].toString();
      _categoriaController.text = product[0]['categoria'].toString();
      _imageUrl = product[0]['img'];
      // ... update other controllers similarly
      setState(() {}); // Trigger UI rebuild
    });
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

  void _ModificarProducto() async {
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

      // se carga la imagen en firebase storage y se obtiene el link
      //if(!(imagen_to_upload == null))
      //{
     //   Upload up = Upload();
     //   final uploaded = await up.uploadImage(imagen_to_upload!);

      //  _imageUrl = up.getUrl();
     // }

      List erros = checkData();
      if(erros.isNotEmpty) {
        for (var error in erros) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$error')),
          );
        }
          return;
      }
      ProductController productController = ProductController();
      productController.update(this.id, ProductTDO(nombre: nombre,
          descripcion: descripcion,
          color: color,
          talla: talla,
          marca: marca,
          img: _imageUrl,
          cantidad: cantidad,
          precio: precio,
          descuento: descuento,
          categoria: categoria));
      // También puedes manejar la imagen (_imageUrl) como necesites
      // Por ejemplo, subirla a un servidor o guardar la URL en la base de datos

      // Luego de manejar los datos, puedes reiniciar el formulario
      //_formKey.currentState!.reset();
      setState(() {
        _imageUrl = _imageUrl; // Reinicia la imagen después de agregar el producto
      });

      // Muestra un mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Se han guardado los cambios')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Icono de regreso
          onPressed: () {
            Navigator.pop(context); // Navega de regreso a la pantalla anterior
          },
        ),
        title: Row(
          children: [
            Image.asset(
              'images/icono1.png',
              fit: BoxFit.fill, // Ruta de tu logo
              height: 80.0,
              width: 80.0,
            ),
            const SizedBox(width: 8.0),
            const Text('Modificar Producto'),
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
                decoration: const InputDecoration(
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
                decoration: const InputDecoration(
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
                decoration: const InputDecoration(
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
                decoration: const InputDecoration(
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
                decoration: const InputDecoration(
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
                decoration: const InputDecoration(
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
                decoration: const InputDecoration(
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
                decoration: const InputDecoration(
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
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _ModificarProducto,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink, // Cambia el color del botón a rosado
                ),
                child: const Text('Guardar Cambios',
                style: TextStyle(
                  color: Colors.black
                ),),
              ),
              const SizedBox(height: 16.0),
              _imageUrl.isEmpty
                  ? const Text('No se ha seleccionado una imagen.')
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


                  //ScaffoldMessenger.of(context).showSnackBar(
                    //SnackBar(content: Text('Selecciona una imagen')),
                  //);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink, // Cambia el color del botón a rosado
                ),
                child: const Text('Seleccionar Imagen',
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