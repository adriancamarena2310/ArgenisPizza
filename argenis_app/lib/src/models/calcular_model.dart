
import 'package:argenis_app/src/models/pizzas_model.dart';

class ModelCalcular {
  double calcularTotal(List<Pizza> pizzas) {
    double total = 0.0;
    for (var pizza in pizzas) {
      total += (pizza.cantidad * pizza.price);
    }
    return total;
  }
}
