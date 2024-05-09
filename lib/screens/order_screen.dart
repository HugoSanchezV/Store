import 'package:flutter/material.dart';

class PedidosPage extends StatelessWidget {
  String id;
  PedidosPage({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedidos'),
      ),
      body: ListView(
        children: <Widget>[
          PedidoItem(
            nombre: 'Producto 1',
            imagenUrl: 'images/producto.png',
            precio: 50,
            cantidad: 2,
          ),
          SizedBox(height: 20),
          EstadoEnvioWidget(),
          SizedBox(height: 20),
          TotalWidget(
            subtotal: 100,
            costoEnvio: 10,
          ),
          SizedBox(height: 20),
          ConfirmarEstadoButton(),
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

class EstadoEnvioWidget extends StatefulWidget {
  @override
  _EstadoEnvioWidgetState createState() => _EstadoEnvioWidgetState();
}

class _EstadoEnvioWidgetState extends State<EstadoEnvioWidget> {
  String selectedState = 'En camino'; // Estado de envío inicial

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.pink[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Estado del Envío:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          DropdownButton<String>(
            value: selectedState,
            onChanged: (String? newValue) {
              setState(() {
                selectedState = newValue!;
              });
            },
            items: <String>[
              'En camino',
              'Entregado',
              'Retrasado',
              'En espera',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
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

class ConfirmarEstadoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Estado del envío confirmado'),
              ),
            );
          },
          child: Text(
            "Guardar cambios",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(55),
            backgroundColor: Colors.pink,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }

}