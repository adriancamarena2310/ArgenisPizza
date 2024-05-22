import 'dart:math';

import 'package:argenis_app/src/models/calcular_model.dart';
import 'package:argenis_app/src/models/pizzas_model.dart';
import 'package:flutter/material.dart';

class HomeTiendaScreen extends StatefulWidget {
  const HomeTiendaScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeTiendaScreenState createState() => _HomeTiendaScreenState();
}

class _HomeTiendaScreenState extends State<HomeTiendaScreen> {
  final _scaffkey = GlobalKey<ScaffoldState>();
  final ModelCalcular modelCalcular = ModelCalcular(); 

  double total = 0.0;
  List<int> quantities = List<int>.filled(5, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffkey,
      appBar: AppBar(
        title: const Text("Argenis"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: pizzas.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                pizzas[index].image,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 40),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  pizzas[index].name,
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "\$${pizzas[index].price.toStringAsFixed(2)}",
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (quantities[index] > 0) {
                                            quantities[index]--;
                                            pizzas[index].cantidad--;
                                          }
                                        });
                                      },
                                      icon: const Icon(Icons.remove),
                                    ),
                                    Text(
                                      quantities[index].toString(),
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (quantities[index] < 10) {
                                            quantities[index]++;
                                            pizzas[index].cantidad++;
                                          }
                                        });
                                      },
                                      icon: const Icon(Icons.add),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            color: Colors.deepOrange[500],
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _calcularTotal,
                  child: const Text("Calcular Total"),
                ),
                Text(
                  "Total: \$${total.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _calcularTotal() {
    setState(() {
      total = modelCalcular.calcularTotal(pizzas);
      _AlertDialog(context);
    });
  }

   // ignore: non_constant_identifier_names
   void _AlertDialog(BuildContext context){
    showDialog(
      context: context, 
      builder: (BuildContext context){
        var random = generateRandomCode();
        return  AlertDialog(
          title: const Text("Recibo"),
          content: Text("Pasa a buscar tus pizzas con el codigo: $random \nNo olvides llevar tu dinero son: $total dolares"),
          actions: [
              TextButton(
              child: const Text("Entendido"),
              onPressed: (){
                Navigator.pop(context);
              }
              )
          ],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        );
      },
      barrierDismissible: false
      );
  }

String generateRandomCode() {
  const charset = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final random = Random.secure();
  const codeLength = 6;
  final codeUnits = List.generate(codeLength, (_) {
    return charset.codeUnitAt(random.nextInt(charset.length));
  });
  return String.fromCharCodes(codeUnits);
}

}
