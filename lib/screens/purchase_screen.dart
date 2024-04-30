import 'package:flutter/material.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({Key? key}) : super(key: key);

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  // Variables para los valores de compra
  final String purchaseId = '123456';
  final List<int> productIds = [1, 2, 3, 4];
  final double totalPrice = 100.00;
  final String purchaseDate = 'April 26, 2024';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Text('Detalles de compra'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Icono de regreso
          onPressed: () {
            Navigator.pop(context); // Navega de regreso a la pantalla anterior
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Purchase ID: ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                Text('$purchaseId', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pink)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Product IDs:',
                  style: TextStyle(fontSize: 16),
                ),
                Text(' ${productIds.join(', ')}',style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Precio total: ',
                  style: TextStyle(fontSize: 16),
                ),
                Text('\$$totalPrice', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Date:',
                  style: TextStyle(fontSize: 16),
                ),
                Text('$purchaseDate', style: TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
