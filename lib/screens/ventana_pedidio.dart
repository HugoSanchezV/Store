import 'package:flutter/material.dart';
import 'package:store/screens/menu.dart';

class PedidoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pedidos',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: PedidosPage(),
    );
  }
}

class PedidosPage extends StatefulWidget {
  @override
  _PedidosPageState createState() => _PedidosPageState();
}

class _PedidosPageState extends State<PedidosPage> {
  List<PedidoItem> pedidos = [
    PedidoItem(
      nombre: 'Producto 1',
      imagenUrl: 'images/producto.png',
      precio: 50,
      cantidad: 2,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedidos'),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: pedidos,
          ),
          SizedBox(height: 20),
          EstadoEnvioWidget(
            estadoEnvio: 'En camino',
            direccionEntrega: 'Calle Principal 123',
            fechaEstimadaEntrega: '25 de Abril de 2024',
          ),
          SizedBox(height: 20),
          TotalWidget(
            subtotal: 100,
            costoEnvio: 10,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                pedidos.add(
                  PedidoItem(
                    nombre: 'Nuevo Producto',
                    imagenUrl: 'images/nuevo_producto.png', // Ruta de la imagen del nuevo producto
                    precio: 30,
                    cantidad: 1,
                  ),
                );
              });
            },
            child: Text('Agregar otro producto'),
          ),
        ],
      ),
    );
  }
}

class PedidoItem extends StatelessWidget {
  final String nombre;
  final String imagenUrl;
  final double precio;
  final int cantidad;

  const PedidoItem({
    Key? key,
    required this.nombre,
    required this.imagenUrl,
    required this.precio,
    required this.cantidad,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        imagenUrl,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
      title: Text(nombre),
      subtitle: Text('Precio: \$${precio.toString()} - Cantidad: $cantidad'),
    );
  }
}

class EstadoEnvioWidget extends StatelessWidget {
  final String estadoEnvio;
  final String direccionEntrega;
  final String fechaEstimadaEntrega;

  const EstadoEnvioWidget({
    Key? key,
    required this.estadoEnvio,
    required this.direccionEntrega,
    required this.fechaEstimadaEntrega,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.pink[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Estado del Envío: $estadoEnvio',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Dirección de Entrega: $direccionEntrega'),
          SizedBox(height: 8),
          Text('Fecha Estimada de Entrega: $fechaEstimadaEntrega'),
        ],
      ),
    );
  }
}

class TotalWidget extends StatelessWidget {
  final double subtotal;
  final double costoEnvio;

  const TotalWidget({
    Key? key,
    required this.subtotal,
    required this.costoEnvio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double total = subtotal + costoEnvio;
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.pink[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Subtotal: \$${subtotal.toString()}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Costo de Envío: \$${costoEnvio.toString()}'),
          SizedBox(height: 8),
          Divider(),
          Text(
            'Total: \$${total.toString()}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
