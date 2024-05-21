import 'package:argenis_app/src/models/pizzas_model.dart';
import 'package:argenis_app/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:argenis_app/src/components/getDrawer_Widget.dart';

class HomeDomicilioScreen extends StatefulWidget {
  final Usuario? user;
  const HomeDomicilioScreen({super.key, required this.user});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeDomicilioScreen> {
  final _scaffkey = GlobalKey<ScaffoldState>();

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
      body: ListView.builder(
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
                      Image.asset(
                        pizzas[index].image,
                        height: 150,
                        fit: BoxFit.cover,
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
                          ElevatedButton(
                            onPressed: () {
                              _calcularTotal(pizzas.length - 1);
                              print(total);
                              total = 0.0;
                            },
                            child: const Text("Calcular"),
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
      drawer: GetDrawer.getDrawer(context, widget.user ), // Añadiendo el drawer
    );
  }

  void _calcularTotal(int cantidad) {
    for (int i = 0; i <= cantidad; i++) {
      total += (pizzas[i].cantidad * pizzas[i].price);
    }
  }
}
