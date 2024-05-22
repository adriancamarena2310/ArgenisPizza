class Usuario {
  int id;
  String userName;
  String password;
  String email;
  String number;
  String image;

  Usuario({
    required this.id,
    required this.userName,
    required this.password,
    required this.email,
    required this.number,
    required this.image,
  });
  
}

bool verificarUsuario(List<Usuario> usuarios, String userName, String password){
    for(var usuario in usuarios){
      if(usuario.userName == userName && usuario.password == password){
        return true;
      }
    }
    return false;
  }

Usuario? obtenerUsuarioPorUserName(List<Usuario> usuarios, String userName){
  for(var usuario in usuarios){
      if(usuario.userName == userName){
        return usuario;
      }
    }
    return null;
}

Usuario? ultimoUsuario(){
  if(usuarios.isNotEmpty){
    return usuarios.last;
  }else{
    return null;
  }
}

  List<Usuario> usuarios = [
    Usuario(
      id: 1,
      userName: 'Manuel',
      password: 'password',
      email: 'manuel.alayax@example.com',
      number: '1234567890',
      image: 'images/users/ayalax.jpg',
    ),
    Usuario(
      id: 2,
      userName: 'Adrian',
      password: 'password',
      email: 'adrian.camarena@example.com',
      number: '0987654321',
      image: 'images/users/camarena.jpg',
    ),
    Usuario(
      id: 3,
      userName: 'Kevin',
      password: 'password',
      email: 'kevin.chikil@example.com',
      number: '598343432',
      image: 'images/users/chikil.jpg',
    ),
  ];


