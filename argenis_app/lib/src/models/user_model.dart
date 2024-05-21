class Usuario {
  int id;
  String name;
  String lastName;
  String password;
  String email;
  String number;
  String image;

  Usuario({
    required this.id,
    required this.name,
    required this.lastName,
    required this.password,
    required this.email,
    required this.number,
    required this.image,
  });

}

  List<Usuario> usuarios = [
    Usuario(
      id: 1,
      name: 'Manuel',
      lastName: 'Alaya',
      password: 'password',
      email: 'manuel.alayax@example.com',
      number: '1234567890',
      image: 'images/users/ayalax.jpg',
    ),
    Usuario(
      id: 2,
      name: 'Adrian',
      lastName: 'Camarena',
      password: 'password',
      email: 'adrian.camarena@example.com',
      number: '0987654321',
      image: 'images/user/camarena.jpg',
    ),
    Usuario(
      id: 3,
      name: 'Kevin',
      lastName: 'Chiquil',
      password: 'password',
      email: 'kevin.chikil@example.com',
      number: '598343432',
      image: 'images/user/chikil.jpg',
    ),
  ];

