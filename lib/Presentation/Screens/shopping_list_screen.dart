
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShoppingList extends StatelessWidget {

  List<String> imagenesProductos = ["assets/productos/Pantalon.jpg","assets/productos/Pantalon.jpg"
    ,"assets/productos/Pantalon.jpg"];

  List<String> catidad = ["1","2","3"];

  List<String> precios = ["\$10.00","\$2.00","\$10.00"];

  List productTitles = [
    "id Producto 1",
    "id Producto 2",
    "id Producto 3",
  ];

  List nombreProductos = ["Pantalon","Pantalon","Pantalon"];

  List detalles = ["Talla:, Color:","Talla:, Color:","Talla:, Color:",];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
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
        title: GestureDetector(
          onTap: () {
            print("dsadsa");
            List<List<int>> matriz = [
              [1, 2, 3],
              [4, 5, 6],
              [7, 8, 9]
            ];

            // Acceder a un elemento de la matriz
            int elemento = matriz[1][2]; // Segunda fila, tercer elemento
            print(elemento); // Salida: 6
          },
          child: Image.asset(
            'assets/icons/logo1.jpg',
            height: 30,
          ),
        ),
        actions: [


          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {

            },
          ),

          IconButton(

            icon: Icon(Icons.account_circle),
            onPressed: () {

            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                child: ListView.builder(
                    itemCount: imagenesProductos.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                imagenesProductos[index],
                                height: 90,
                                width: 90,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  productTitles[index],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  nombreProductos[index],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  detalles[index],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),

                            SizedBox(width: 40),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  catidad[index],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  precios[index],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),

                              ],
                            ),


                          ],
                        ),

                      );
                    }
                ),
              ),
              SizedBox(height: 30),
        Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total:",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Dirección:",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),

                ],
              ),

              SizedBox(width: 40),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\$22.00",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Desconocido",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),

                ],
              ),


            ],
          ),

        ),


            ],
          ),
        ),
      ),
    );
  }
}
