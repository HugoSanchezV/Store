import 'package:store/screens/cart_screen.dart';
import 'package:store/screens/product_screen.dart';
import 'package:store/screens/user_data.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../controllers/productController.dart';
import '../../screens/formularioProducto.dart';
import '../../screens/login_screen.dart';
import '../../screens/orders_list_screen.dart';
import '../../screens/product_list_screen.dart';
import 'Categoria.dart';
import 'list_pedidos_cliente.dart';

class principalCliente extends StatelessWidget {
  //principalCliente({required this.productos});
  String categoriaSeleccionada = "";

  List<Categoria> listaCategorias = [];
  List<Producto> listaProductos = [];
  Set<String> nombresCategorias = Set();
  Set<String> nombresProductos = Set();
  int conteo = 0;
  int conteo2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        actions: [

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
              leading: const Icon(Icons.account_circle),
              title: Text('Cuenta'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserDataScreen()));
              },
            ),

            ListTile(
              leading: const Icon(Icons.store),
              title: const Text('Tienda'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>principalCliente()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.delivery_dining_sharp),
              title: const Text('Pedidos'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OrderListClient()));
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

                        Container(

                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black,
                              image: DecorationImage(
                                image: AssetImage("images/imagen1.png"),
                                fit: BoxFit.cover,
                                opacity: 0.5,
                              )
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart,
                                size: 200,
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

                        SizedBox(
                          height: 20,
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

                              child: FutureBuilder<List<dynamic>>(
                                future: ProductController().getAll(),
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
                                        Map<String, dynamic> productDetails =
                                        snapshot.data![index][id];
                                        String img = productDetails["img"];
                                        String title = productDetails["nombre"];
                                        String description =
                                            "${productDetails["descripcion"].toString().substring(0, 17)}...";
                                        String price = "\$${productDetails["precio"]}";
                                        int cantidad = int.parse(productDetails["cantidad"].toString());
                                        String categoria1 = productDetails['categoria'] + ' ';

                                        String categoria = categoria1.replaceAll('  ', ' ');

                                        //nombresCategorias.add(categoria);
                                        if(cantidad > 0){
                                          listaCategorias.add(Categoria(nombre: categoria, imagenUrl: img));
                                          Map<String, String> categoriasConImagenes = {};
                                          listaCategorias.forEach((categoria) {
                                            if (!categoriasConImagenes.containsKey(categoria.nombre)) {
                                              categoriasConImagenes[categoria.nombre] = categoria.imagenUrl;
                                            }
                                          });
                                          listaCategorias = categoriasConImagenes.entries.map((entry) => Categoria(nombre: entry.key, imagenUrl: entry.value)).toList();
                                        }

                                        conteo++;
                                        //print(conteo);
                                        //print(snapshot.data!.length);
                                        if(conteo == snapshot.data!.length){
                                          conteo =0 ;
                                          return Container(
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(left: 15),
                                                  child: Column(
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
                                                          fontSize: 30.0,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),


                                                Container(
                                                  width: double.infinity,
                                                  height: 150.0,
                                                  child: Swiper(
                                                    viewportFraction: 0.33,
                                                    scale: 0.9,
                                                    itemBuilder: (BuildContext context, int index) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          obtenerCategoriaSeleccionada(context, index);

                                                        },
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              height: 100,
                                                              width: 100,
                                                              child: Image.network(listaCategorias[index].imagenUrl),
                                                            ),
                                                            Text(
                                                              listaCategorias[index].nombre,
                                                              style: TextStyle(
                                                                fontSize: 17,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    control: SwiperControl(
                                                      color: Colors.pink,
                                                    ),
                                                    itemCount: listaCategorias.length,
                                                    pagination: SwiperPagination(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }else{
                                          return Container();
                                        }



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
                        SizedBox(
                          height: 10,
                        ),

                      ],
                    ),
                  ),


                  FutureBuilder<List<dynamic>>(
                    future: ProductController().getAll(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        listaProductos.clear();
                        conteo2 = 0;
                        // Data is ready, display the list
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            // Access and use product data from the snapshot
                            String id = snapshot.data![index].keys.first;
                            Map<String, dynamic> productDetails =
                            snapshot.data![index][id];

                            String img = productDetails["img"];
                            String title = productDetails["nombre"];
                            String description =
                                "${productDetails["descripcion"].toString().substring(0, 17)}...";
                            String price = "\$${productDetails["precio"]}";
                            int cantidad = int.parse(productDetails["cantidad"].toString());
                            int descuento = int.parse(productDetails['descuento'].toString());
                            String categoria = productDetails['categoria'];


                            if((descuento <= 20 )&&(cantidad > 0)){
                              listaProductos.add(Producto(id: id,nombre: title, precio: price, imagenUrl: img, descuento: descuento, categoria: categoria));
                            }
                            conteo2 ++;
                            if(conteo2 == snapshot.data!.length){
                              conteo2 = 0;
                              return Container(
                                //borderRadius: BorderRadius.circular(10),

                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Divider(
                                            color: Colors.white,
                                            thickness: 1.0,
                                          ),

                                          // Texto
                                          Text(
                                            '¡Oferta de 20% o menos!',
                                            style: TextStyle(
                                              fontSize: 30.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Container(

                                      child: GridView.builder(
                                          itemCount: listaProductos.length,
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
                                                        builder: (context) => ProductScreen(id: listaProductos[index].id)));
                                              },
                                              child: Container(
                                                margin: EdgeInsets.all(10),
                                                //margin: EdgeInsets.only(right: 10),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [

                                                    Container(

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
                                                                  child: ClipRRect(
                                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                                                    child:
                                                                    GestureDetector(
                                                                      onTap: () {
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (context) => ProductScreen(id: listaProductos[index].id)));
                                                                      },
                                                                      child: Image.network(
                                                                        listaProductos[index].imagenUrl,
                                                                        width: double.maxFinite,
                                                                        height: MediaQuery.of(context).size.height * 0.27,
                                                                        fit: BoxFit.cover,
                                                                      ),
                                                                    ),

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
                                                                            listaProductos[index].nombre,
                                                                            style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 16,
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
                                                                            listaProductos[index].precio,
                                                                            style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 15,
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
                                                                        /*child: InkWell(
                                                                    onTap: () {},
                                                                    child: Center(
                                                                      child: Icon(
                                                                        Icons
                                                                            .add_shopping_cart_sharp,
                                                                        color: Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),*/
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


                              );
                            }else{
                              return Container();
                            }

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

  /*Widget _categorias() {

    Set<Categoria> conjuntoCategorias = Set<Categoria>();

    List<Categoria> listaCategorias = [];
    return FutureBuilder<List<dynamic>>(
      future: ProductController().getAll(),
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
              Map<String, dynamic> productDetails =
              snapshot.data![index][id];
              String imageUrl = productDetails["img"];
              String title = productDetails["nombre"];
              String description =
                  "${productDetails["descripcion"].toString().substring(0, 17)}...";
              String price = "\$${productDetails["precio"]}";
              int cantidad = int.parse(productDetails["cantidad"].toString());
              int descuento = int.parse(productDetails['descuento'].toString());
              String categoria = productDetails['categoria'];

              conjuntoCategorias.add(Categoria(nombre: categoria, imagenUrl: imageUrl));


              print(conjuntoCategorias.toList());

              List<Categoria> listaCategorias = conjuntoCategorias.toList();
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
                          child: Image.network(listaCategorias[index].imagenUrl),
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
                  itemCount: listaCategorias.length,
                  pagination: SwiperPagination(),

                ),

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
    );



  }*/
  Widget _categorias() {
    List<Categoria> listaCategorias = [];

    return FutureBuilder<List<dynamic>>(
      future: ProductController().getAll(),
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
              Map<String, dynamic> productDetails =
              snapshot.data![index][id];
              String img = productDetails["img"];
              String title = productDetails["nombre"];
              String description =
                  "${productDetails["descripcion"].toString().substring(0, 17)}...";
              String price = "\$${productDetails["precio"]}";
              int cantidad = int.parse(productDetails["cantidad"].toString());
              String categoria = productDetails['categoria'];

              //listaCategorias.add(Categoria(nombre: categoria, imagenUrl: img));


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
                        child: Image.network(listaCategorias[index].imagenUrl),
                      ),
                    );
                  },
                  control: SwiperControl(
                    color: Colors.pink,
                  ),
                  itemCount: listaCategorias.length,
                  pagination: SwiperPagination(),
                ),
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

    //print(listaProductos.length);

    for(int i= 0; i < listaCategorias.length;i++){
      print(listaCategorias[i].nombre);
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                pantallaInicial(nombreCategoria: listaCategorias[i].nombre)));
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
  final String id;
  final String nombre;
  final String precio;
  final String imagenUrl;
  final int descuento;
  final String categoria;

  Producto(
      {required this.id,required this.nombre,
        required this.precio,
        required this.imagenUrl,
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
