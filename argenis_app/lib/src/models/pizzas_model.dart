class Pizza {
  String name;
  double price;
  String image;
  double cantidad = 0;

  Pizza({
    required this.name, 
    required this.price, 
    required this.image, 
    required this.cantidad
    });
}

 final List<Pizza> pizzas = [
    Pizza(
      name: "Especial Argenis", 
      price: 99.99, 
      image: "images/pizzas/argeniss.jpg", 
      cantidad: 0
      ),
    Pizza(
      name: "Pepperoni", 
      price: 9.99, 
      image: "images/pizzas/peperoni.jpg", 
      cantidad: 0
      ),
    Pizza(
      name: "Hawaiana", 
      price: 10.99, 
      image: "images/pizzas/hawa.jpg", 
      cantidad: 0
      ),
    Pizza(
      name: "Cuatro Quesos", 
      price: 11.99, 
      image:"images/pizzas/cuatro.jpg", 
      cantidad: 0
      ),
    Pizza(
      name: "Vegetariana", 
      price: 7.99, 
      image: "images/pizzas/vege.jpg", 
      cantidad: 0
      ),
  ];

  