import 'package:flutter/material.dart';
import 'package:argenis_app/src/components/getDrawer_Widget.dart';
import 'package:argenis_app/src/models/pizzas_model.dart';
import 'package:argenis_app/src/models/user_model.dart';

class HomeDomicilioScreen extends StatefulWidget {
  final Usuario? user;
  const HomeDomicilioScreen({Key? key, required this.user}) : super(key: key);

  @override
  _HomeDomicilioScreenState createState() => _HomeDomicilioScreenState();
}

class _HomeDomicilioScreenState extends State<HomeDomicilioScreen> {
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
      drawer: GetDrawer.getDrawer(context, widget.user),
    );
  }

  void _calcularTotal() {
    setState(() {
      total = 0.0;
      for (int i = 0; i < pizzas.length; i++) {
        total += (pizzas[i].cantidad * pizzas[i].price);
      }
    });
  }
}
