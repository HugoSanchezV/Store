import 'package:store/Presentation/Screens/shopping_list_screen.dart';
import 'package:store/screens/cart_screen.dart';
import 'package:store/screens/user_data.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:typed_data';

import 'main_screen.dart';



class pantallaInicial extends StatelessWidget {

  String nombreCategoria = "";
  pantallaInicial({required this.nombreCategoria});

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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(

          color: Colors.pink,
        ),
        /*leading: PopupMenuButton<int>(
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: Row(
                children: [
                  Icon(Icons.list_alt),
                  SizedBox(width: 8),
                  Text('Lista de pedidos'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 2,
              child: Row(
                children: [
                  Icon(Icons.notifications),
                  SizedBox(width: 8),
                  Text('Notificaciones'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 3,
              child: Row(
                children: [
                  Icon(Icons.shopping_cart),
                  SizedBox(width: 8),
                  Text('Pedidos'),
                ],
              ),
            ),
          ],
          onSelected: (value) {

            switch (value) {
              case 1:
                print('Inicio seleccionado');
                break;
              case 2:
                print('Perfil seleccionado');
                break;
              case 3:
                print('Configuración seleccionada');
                break;
            }
          },
        ),*/

        actions: [

          IconButton(
            color: Colors.pink,
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());

            },
          ),
          IconButton(
            color: Colors.pink,
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
            },
          ),

          IconButton(

            color: Colors.pink,
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserDataScreen()));
            },
          ),
        ],
      ),


      body:
      Container(


        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //SizedBox(height: 20,),

                  Column(
                    children: [
                      // Línea
                      Divider(
                        color: Colors.black,
                        thickness: 1.0, // Grosor de la línea
                      ),

                      // Texto
                      Text(
                        nombreCategoria,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20,),



                  ClipRRect(

                    //borderRadius: BorderRadius.circular(10),


                    child: GridView.builder(
                        itemCount: productos.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.6,
                          crossAxisSpacing: 2,
                        ), itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => ShoppingList()));

                          //Navigator.push(context, MaterialPageRoute(builder: (context) => principalPedidos()));
                          //código para mostrar la pantalla de producto
                          print("Prueba221312");
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
                                                topRight: Radius.circular(10),
                                                topLeft: Radius.circular(10)),
                                            child: Container(
                                              color: Color(0xFFF0F0F0),
                                              padding: EdgeInsets.all(5),
                                              child: Image.asset(
                                                  productos[index].imagenUrl),
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
                                            bottomRight: Radius.circular(10)),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              // Alinear el texto a la izquierda
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      productos[index].nombre,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight: FontWeight
                                                            .bold,
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
                                                      productos[index].precio,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                        fontWeight: FontWeight
                                                            .bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            // Este widget ocupa todo el espacio disponible
                                            Column(
                                              children: [
                                                Container(
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
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
                    }),
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


