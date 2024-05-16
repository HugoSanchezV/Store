import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/Presentation/Screens/main_screen.dart';
import 'package:store/controllers/productController.dart';
import 'package:flutter/material.dart';
import '../../controllers/recordController.dart';
import '../../controllers/userController.dart';
import '../../screens/login_screen.dart';
import '../../screens/order_screen.dart';
import '../../screens/user_data.dart';
import 'info_product.dart';

class OrderListClient  extends StatefulWidget {
  @override
  _OrderListClientScreenState createState() => _OrderListClientScreenState();
}

class _OrderListClientScreenState extends State<OrderListClient> {

  String _id = '';
  String nombre = '';
  String correo = '';
  String telefono = '';
  String direccion = '';

  String segundaDireccion = '';
  String tipoPago = '';
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    _getUserEmail();
    _getUserData();
  }

  void _getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    userEmail = prefs.getString('userEmail') ?? '';
    print('Correo electrónico del usuario: $userEmail');
  }

  void _getUserData() async {
    UserController userController = UserController();
    Map<String, dynamic> userCurrent;

    userController.getAll().then((user) {
      for (var usersData in user) {
        String id = usersData.keys.first;
        Map<String, dynamic> userDetails = usersData[id];
        userDetails.forEach((key, value) {
          if (key == "email") {
            if (value == userEmail) {
              print("Coincide");
              userCurrent = userDetails;
              setState(() {
                _id = id;
                print(_id);
                nombre = userDetails['name'];
                direccion = userDetails['address'];
                telefono = userDetails['phone'];
                correo = userDetails['email'];
              });
            }
          }
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis pedidos"),
        elevation: 0,
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar pedidos...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: FutureBuilder<List>(
                  future: RecordController().getAll(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // Data is ready, display the list
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          // Access and use product data from the snapshot
                          String id = snapshot.data![index].keys.first;

                          Map<String, dynamic> recordDetails = snapshot.data![index][id];

                          String imagen = 'images/image2.jpg';
                          String titulo = recordDetails['idProducto'];
                          String idProducto = recordDetails['idProducto'];
                          String idUsuario = recordDetails['idUsuario'];
                          String  estado = recordDetails['estado'];
                          int amount = recordDetails['cantidad'];
                          String  descripcion = '';


                          if (idUsuario == _id) {
                          return FutureBuilder<List>(
                              future: ProductController().getById(idProducto),
                              builder: (context, productSnapshot){

                                List<dynamic>? product = productSnapshot.data;

                                product?.forEach((element) {
                                  titulo = element['nombre'];
                                  imagen = element['img'];
                                  descripcion = "${element['descripcion']
                                      .toString()
                                      .substring(0,17)}...";
                                });


                                return InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => InfoProduct(id: idProducto)));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(vertical: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.network(
                                            imagen,
                                            height: 120,
                                            width: 120,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              titulo,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w900,
                                                fontSize: 18,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              descripcion,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "Cantidad: $amount Piezas",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              estado,
                                              style: const TextStyle(
                                                color: Colors.pink,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 1),
                                      ],
                                    ),
                                  ),
                                );
                              }
                          );}
                          else {
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
        ],
      ),
    );
  }
}