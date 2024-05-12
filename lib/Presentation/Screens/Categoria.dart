import 'package:store/Presentation/Screens/shopping_list_screen.dart';
import 'package:store/screens/cart_screen.dart';
import 'package:store/screens/user_data.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:typed_data';

import '../../controllers/productController.dart';
import '../../screens/product_screen.dart';
import 'main_screen.dart';



class pantallaInicial extends StatelessWidget {

  String nombreCategoria = "";
  int conteo2 =0;
  List<Producto> listaProductos = [];
  pantallaInicial({required this.nombreCategoria});




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(

          color: Colors.pink,
        ),
        actions: [

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

                  SizedBox(height: 10,),



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

                            if(categoria == nombreCategoria){
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
                                            nombreCategoria,
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
                                                                        height: 220,
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
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            listaProductos[index].nombre.length > 13
                                                                                ? listaProductos[index].nombre.substring(0, 10) + "..."
                                                                                : listaProductos[index].nombre,
                                                                            style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 22,
                                                                              fontWeight:
                                                                              FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(

                                                                        children: [

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


    );
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
      {required this.id ,required this.nombre,
        required this.precio,
        required this.imagenUrl,
        required this.descuento,
        required this.categoria});
}


