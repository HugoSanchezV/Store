import 'package:store/screens/cart_screen.dart';
import 'package:store/screens/product_screen.dart';
import 'package:store/screens/user_data.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../screens/formularioProducto.dart';
import '../../screens/login_screen.dart';
import '../../screens/orders_list_screen.dart';
import '../../screens/product_list_screen.dart';
import 'Categoria.dart';

class principalCliente extends StatelessWidget {
  //principalCliente({required this.productos});
  String categoriaSeleccionada = "";

  //Producto productos = Producto(nombre: "nombre", precio: "precio", imagenUrl: "imagenUrl", review: "review", descuento: "");
  List<Categoria> categorias = [
    Categoria(
      nombre: 'Camisa',
      imagenUrl: 'assets/productos/Camisa.jpg',
    ),
    Categoria(
      nombre: 'Pantalon',
      imagenUrl: 'assets/productos/Camisa.jpg',
    ),
    Categoria(
      nombre: 'Camisa',
      imagenUrl: 'assets/productos/Camisa.jpg',
    ),
    Categoria(
      nombre: 'Pantalon',
      imagenUrl: 'assets/productos/Camisa.jpg',
    ),
  ];
  List<Producto> productos = [
    Producto(
      nombre: 'Producto A',
      precio: '10.99',
      imagenUrl: 'assets/productos/Pantalon.jpg',
      review: 'Buena calidad',
      descuento: '10%',
      categoria: "Pantalon",
    ),
    Producto(
      nombre: 'Producto B',
      precio: '15.99',
      imagenUrl: 'assets/productos/Pantalon.jpg',
      review: 'Excelente servicio',
      descuento: '15%',
      categoria: "Pantalon",
    ),
    Producto(
      nombre: 'Producto C',
      precio: '20.99',
      imagenUrl: 'assets/productos/Pantalon.jpg',
      review: 'Recomendado',
      descuento: '20%',
      categoria: "Pantalon",
    ),
    Producto(
      nombre: 'Producto D',
      precio: '10.99',
      imagenUrl: 'assets/productos/Pantalon.jpg',
      review: 'Buena calidad',
      descuento: '10%',
      categoria: "Pantalon",
    ),
    Producto(
      nombre: 'Producto E',
      precio: '15.99',
      imagenUrl: 'assets/productos/Pantalon.jpg',
      review: 'Excelente servicio',
      descuento: '15%',
      categoria: "Pantalon",
    ),
    Producto(
      nombre: 'Producto F',
      precio: '20.99',
      imagenUrl: 'assets/productos/Pantalon.jpg',
      review: 'Recomendado',
      descuento: '20%',
      categoria: "Pantalon",
    ),
  ];
  List<List<Producto>> matrizOfertas = [];


  void ingresarMatriz() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        actions: [
          /*IconButton(
            icon: Icon(Icons.search),
            color: Colors.pink,
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
          ),*/
          IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Colors.pink,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreen()));
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            color: Colors.pink,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserDataScreen()));
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.pink,
              ),
              child: Image.asset("assets/icons/logoInv.jpg"),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Cuenta'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserDataScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.list_rounded),
              title: Text('Lista de compras'),
              onTap: () {
                //Código para conectar pantalla de lista de compras
                /*Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AgregarProducto()));*/
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
        color: Colors.white,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 20),
              child: Column(
                children: [
                  //SizedBox(height: 20,),

                  Container(
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Línea
                            Divider(
                              color: Colors.white,
                              thickness: 0.0, // Grosor de la línea
                            ),

                            // Texto
                            Text(
                              'Categorias',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        /*ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Colors.white,
                            //color: Color(0xFFFFFFDE),
                            child: Container(
                              child: _categorias(),
                            ),
                          ),
                        ),*/

                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Colors.white,
                            //color: Color(0xFFFFFFDE),
                            child: Container(

                              child: _categorias(),

                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                              color: Colors.white,
                              thickness: 1.0,
                            ),

                            // Texto
                            Text(
                              'Descuentos',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  ClipRRect(
                    //borderRadius: BorderRadius.circular(10),

                    child: GridView.builder(
                        itemCount: productos.length,
                        //itemCount: nombreProductos.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.6,
                          crossAxisSpacing: 2,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductScreen(id: id)));
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              //margin: EdgeInsets.only(right: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    //height: 200,

                                    child: Column(
                                      children: [
                                        //Imagen del producto

                                        Stack(
                                          children: [
                                            InkWell(
                                              onTap: () {},
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    topLeft:
                                                        Radius.circular(10)),
                                                child: Container(
                                                  color: Color(0xFFF0F0F0),
                                                  padding: EdgeInsets.all(5),
                                                  child: Image.asset(
                                                      productos[index]
                                                          .imagenUrl),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        //Información del producto
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.pink,
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start, // Alinear el texto a la izquierda
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          productos[index]
                                                              .nombre,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        /*Icon(Icons.star, color: Colors.amber, size: 15,),
                                                        Text(
                                                          reviews[index],
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        SizedBox(width: 10,),*/
                                                        Text(
                                                          productos[index]
                                                              .precio,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Spacer(), // Este widget ocupa todo el espacio disponible
                                                Column(
                                                  children: [
                                                    Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: InkWell(
                                                        onTap: () {},
                                                        child: Center(
                                                          child: Icon(
                                                            Icons
                                                                .add_shopping_cart_sharp,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  //SizedBox(height: 10,),
                                ],
                              ),
                            ),
                          );
                          ;
                        }),
                  ),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Colors.white,
                      //color: Color(0xFFFFFFDE),

                      child: Padding(
                        padding: EdgeInsets.only(left: 15, right: 10, top: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      /* body: Container(
        color: Colors.white,
        width: double.infinity,
        child: Column(

          children: <Widget>[
            SizedBox(

              height: 20,
            ),
            Column(
              children: [
                // Línea
                Divider(
                  color: Colors.black,
                  thickness: 1.0, // Grosor de la línea
                ),

                // Texto
                Text(
                  'Categorias',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 1,
              child: Container(

                child: _categorias(),
              color: Color(0xFFFFFFDE),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            Column(
              children: [
                // Línea
                Divider(
                  color: Colors.black,
                  thickness: 1.0, // Grosor de la línea
                ),

                // Texto
                Text(
                  'Nuevo',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

          ],
        ),

      ),*/
    );
  }

  Widget _categorias() {
    return Container(

      width: double.infinity,
      height: 110.0,
      child: Swiper(


        viewportFraction: 0.33,
        scale: 0.9,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              obtenerCategoriaSeleccionada(context, index);
            },
            child: Container(
              height: 100,
              width: 100,
              child: Image.asset(categorias[index].imagenUrl),
            )
            
            /*child: ClipOval(
                child: Image.asset(imagenesCategorias[index],fit: BoxFit.cover,width: 50,height: 50,),
              )*/
          );
          //return Image.asset(imagenesCategorias[index],fit: BoxFit.cover,);

        },
        control: SwiperControl(
          color: Colors.pink, // Color para los controles laterales
        ),
        itemCount: categorias.length,
        pagination: SwiperPagination(),

      ),

    );
  }

  void obtenerCategoriaSeleccionada(BuildContext context, int i) {
    /*List<Producto> productos = [
      Producto(
        nombre: "Camisa",
        precio: "\$40.00 MXN",
        imagenUrl: "assets/productos/Camisa.jpg",
        review: "54",
      ),
      Producto(
        nombre: "Camisa",
        precio: "\$40.00 MXN",
        imagenUrl: "assets/productos/Camisa.jpg",
        review: "54",
      ),
      Producto(
        nombre: "Camisa",
        precio: "\$40.00 MXN",
        imagenUrl: "assets/productos/Camisa.jpg",
        review: "54",
      ),
      Producto(
        nombre: "Camisa",
        precio: "\$40.00 MXN",
        imagenUrl: "assets/productos/Camisa.jpg",
        review: "54",
      ),
    ];*/
    List<Producto> listaNueva = [];
    if (i == 0) {
      categoriaSeleccionada = "Pantalones";

      for (int i = 0; i < productos.length; i++) {
        int j = 0;
        if (productos[i].categoria == categoriaSeleccionada) {
          listaNueva.add(productos[i]);
        }
      }
    }
    if (i == 1) {
      categoriaSeleccionada = "Camisas";

      for (int i = 0; i < productos.length; i++) {
        int j = 0;
        if (productos[i].categoria == categoriaSeleccionada) {
          listaNueva.add(productos[i]);
        }
      }
    }
    if (i == 2) {
      categoriaSeleccionada = "Blusas";
      for (int i = 0; i < productos.length; i++) {
        int j = 0;
        if (productos[i].categoria == categoriaSeleccionada) {
          listaNueva.add(productos[i]);
        }
      }
    }
    if (i == 3) {
      categoriaSeleccionada = "Faldas";
      for (int i = 0; i < productos.length; i++) {
        int j = 0;
        if (productos[i].categoria == categoriaSeleccionada) {
          listaNueva.add(productos[i]);
        }
      }
    }

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                pantallaInicial(nombreCategoria: categoriaSeleccionada)));
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
      // Agrega el botón o icono deseado aquí
      IconButton(
        icon: Icon(Icons.arrow_forward_ios),
        onPressed: () {
          // Acción cuando se presiona el botón de agregar
          print('Se presionó el botón de agregar');
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, 'null');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

class Producto {
  final String nombre;
  final String precio;
  final String imagenUrl;
  final String review;
  final String descuento;
  final String categoria;

  Producto(
      {required this.nombre,
      required this.precio,
      required this.imagenUrl,
      required this.review,
      required this.descuento,
      required this.categoria});
}
class Categoria {
  final String nombre;
  final String imagenUrl;

  Categoria(
      {required this.nombre,
        required this.imagenUrl,});
}
