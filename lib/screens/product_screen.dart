import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:store/dao/producto_dao.dart';
import 'dart:io';
import '../controllers/productController.dart';
import '../widgets/container_button_motel.dart';


class ProductScreen extends StatefulWidget {
  final String id;
  ProductScreen({required this.id});

  @override
  _ProductScreenState createState() => _ProductScreenState (id: this.id);
}

class _ProductScreenState extends State<ProductScreen> {
  final String id;
  _ProductScreenState({required this.id});

   final ProductDao prod = new ProductDao();


  String nombre = "";
  String descripcion = "";
  String color = "";
  String talla = "";
  String marca = "";
  String cantidad = "";
  String precio = "";
  String descuento = "";
  String categoria = "";
  String _url = "";



  @override
  void initState() {
    super.initState();
    ProductController productController = ProductController();
    productController.getById(id).then((product) {
      // Update UI with product data
       nombre = product[0]['nombre'];
       descripcion = product[0]['descripcion'];
       color  = product[0]['color'];
       talla = product[0]['talla'];
       marca = product[0]['marca'];
       cantidad = product[0]['cantidad'].toString();
       precio = product[0]['precio'].toString();
       descuento = product[0]['descuento'].toString();
       categoria = product[0]['categoria'].toString();
       _url = product[0]['img'];
      // ... update other controllers similarly
      setState(() {}); // Trigger UI rebuild
    });
  }

  List<String> images = [
    "images/image1.jpg",
    "images/image1.jpg",
    "images/image1.jpg",
    "images/image1.jpg"
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.pink,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 450,
                  width: MediaQuery.of(context).size.width,
                  child: FanCarouselImageSlider(
                    sliderHeight: 430,
                    autoPlay: true,
                    imagesLink: images,
                    isAssets: true,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        Text(
                           nombre,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 25
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "mas textos",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      precio,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                        fontSize: 25
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 25,
                    itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) { },
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child:  Text(
                    descripcion,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.shopping_cart,
                          color: Colors.pink,
                        ),

                      ),

                    ),
                    InkWell(
                      onTap: () {},
                      child: ContainerButtonModel(
                        itext: "Comprar ahora",
                        containerWidth: 250 ,
                        bgColor: Colors.pink,
                      ),

                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

