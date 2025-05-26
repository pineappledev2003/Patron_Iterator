// ignore_for_file: avoid_print

import 'package:iterator_flutter_dart/models/user.dart';
import 'package:iterator_flutter_dart/patron_iterator/concreteCollection/user_list_collection.dart';
import 'package:iterator_flutter_dart/patron_iterator/concreteCollection/user_map_collection.dart';
import 'package:iterator_flutter_dart/patron_iterator/iterableCollection/iterable_collection.dart';

void main() {
  // Crear y llenar la colección con List<User>
  final listaUsuarios = UserListCollection();
  listaUsuarios.agregarItema(User(nombre: "Daniel", rol: "Admin"));
  listaUsuarios.agregarItema(User(nombre: "Luis", rol: "User"));
  listaUsuarios.agregarItema(User(nombre: "Bea", rol: "Admin"));
  listaUsuarios.agregarItema(User(nombre: "Andrea", rol: "User"));
  listaUsuarios.agregarItema(User(nombre: "Santiago", rol: "User"));
  listaUsuarios.agregarItema(User(nombre: "Valeria", rol: "User"));
  listaUsuarios.agregarItema(User(nombre: "Carlos", rol: "Admin"));
  listaUsuarios.agregarItema(User(nombre: "Lucía", rol: "User"));
  listaUsuarios.agregarItema(User(nombre: "Julián", rol: "User"));
  listaUsuarios.agregarItema(User(nombre: "Fernanda", rol: "Admin"));

  // Crear y llenar la colección con Map<String, List<User>>
  final mapaUsuarios = UserMapCollection();
  mapaUsuarios.agregarItem(User(nombre: 'Mateo', rol: 'User'));
  mapaUsuarios.agregarItem(User(nombre: 'Sofía', rol: 'Admin'));
  mapaUsuarios.agregarItem(User(nombre: 'Tomás', rol: 'User'));
  mapaUsuarios.agregarItem(User(nombre: 'Isabela', rol: 'User'));
  mapaUsuarios.agregarItem(User(nombre: 'Camilo', rol: 'Admin'));
  mapaUsuarios.agregarItem(User(nombre: 'Gabriela', rol: 'User'));
  mapaUsuarios.agregarItem(User(nombre: 'Andrés', rol: 'User'));
  mapaUsuarios.agregarItem(User(nombre: 'Juliana', rol: 'Admin'));
  mapaUsuarios.agregarItem(User(nombre: 'Sebastián', rol: 'User'));
  mapaUsuarios.agregarItem(User(nombre: 'Natalia', rol: 'User'));

  mostrarUsuarios(listaUsuarios);
  mostrarUsuarios(mapaUsuarios);

  obtenerYOrdenarManualmente(listaUsuarios);
  buscarUsuariosPorRol(mapaUsuarios, "Admin");

  //buscarUsuarioPorNombre(listaUsuarios, "Andrea");
  //buscarUsuarioPorNombre(mapaUsuarios, "Juliana");
}

// Función que recorre y muestra usuarios usando el patrón Iterator
void mostrarUsuarios(IterableCollection<User> coleccion) {
  final iterator = coleccion.createIterator();
  iterator.reset();

  print('Listado de usuarios:');
  while (iterator.hasNext()) {
    final user = iterator.next();
    print('Nombre: ${user.nombre}, Rol: ${user.rol}');
  }
  print('--------------------');
}

//Ordenar nombres
void obtenerYOrdenarManualmente(UserListCollection collection) {
  print("Usuarios ordenados manualmente:");
  for (var user in collection.obtenerTodosLosUsuariosOrdenadosPorNombre()) {
    print("Nombre: ${user.nombre}, Rol: ${user.rol}");
  }
  print("---------------------------");
}

void buscarUsuariosPorRol(UserMapCollection coleccion, String rol) {
  final resultado = coleccion.buscarRolComoMap(rol);

  print('Usuarios con rol "$rol":');
  if (resultado.containsKey(rol)) {
    for (var user in resultado[rol]!) {
      print("Nombre: ${user.nombre}, Rol: ${user.rol}");
    }
  } else {
    print("No se encontraron usuarios con el rol '$rol'.");
  }
  print("---------------------------");
}

void buscarUsuarioPorNombre(IterableCollection<User> coleccion, String nombreBuscado) {
    final iterator = coleccion.createIterator();
    iterator.reset();

    print('Buscando usuario con nombre "$nombreBuscado"...');
    bool encontrado = false;

    while (iterator.hasNext()) {
      final user = iterator.next();
      if (user.nombre == nombreBuscado) {
        print("¡Usuario encontrado! Nombre: ${user.nombre}, Rol: ${user.rol}");
        encontrado = true;
        break; // Salimos del ciclo si ya lo encontramos
      }
    }

    if (!encontrado) {
      print("No se encontró ningún usuario con ese nombre.");
    }

    print('--------------------');
  }


//bool yaAgregado = false;

  // if (!yaAgregado) {
      //   if (coleccion is UserListCollection) {
      //     coleccion.agregarItema(
      //       User(nombre: "Marianna", rol: "Admin"),
      //     );
      //   } else if (coleccion is UserMapCollection) {
      //     coleccion.agregarItem(
      //       User(nombre: "Seoanes", rol: "User"),
      //     );
      //   }
      //   yaAgregado = true;
      // }


