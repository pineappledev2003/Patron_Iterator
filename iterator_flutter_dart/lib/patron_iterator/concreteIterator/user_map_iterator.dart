// ignore_for_file: slash_for_doc_comments

import 'package:iterator_flutter_dart/models/user.dart';
import 'package:iterator_flutter_dart/patron_iterator/iterator/interfaz_iterator.dart';

class UserMapIterator implements InterfazIterator<User> {
  final Map<String, List<User>> _usersByRole;
  late List<String> _roles; // Claves del mapa
  int _roleIndex = 0; // en qué *rol (clave)* estamos.
  int _userIndex = 0; // en qué *usuario dentro de la lista* de ese rol estamos.
  User? _currentUser; // Usuario actual, actualizado con next()

  UserMapIterator({required Map<String, List<User>> users})
    : _usersByRole = users {
    _roles = _usersByRole.keys.toList(); // Se guardan las claves (roles)

    /**
     * {
     *    "Admin": [User1, User2],
     *     "User": [User3, User4, User5]
     *  }
     * 
     *  ? _roles = ["Admin", "User"];
     */
  }

  /**
   * Este método verifica si aún hay usuarios por recorrer, revisando cada rol en orden
   * Si ya terminó con una lista, pasa al siguiente rol automáticamente.
   */

  @override
  bool hasNext() {
    while (_roleIndex < _roles.length) {
      final role = _roles[_roleIndex]; // Rol actual
      final users = _usersByRole[role]; // Lista de usuarios de ese rol

      if (_userIndex < users!.length) {
        return true; // Si todavia hay usuarios en esta lista
      } else {
        _roleIndex++; // Pasamos al siguiente rol
        _userIndex = 0; // Reiniciamos el indice de usuario
      }
    }
    return false;
  }

  @override
  User next() {
    // Verificamos si aún quedan usuarios por recorrer
    if (!hasNext()) {
      throw Exception("No hay más usuarios"); // Si no hay más, lanzamos excepción
    } else {
      
      final role = _roles[_roleIndex]; // Obtenemos el rol actual usando el índice de rol
      final users = _usersByRole[role]!; // Obtenemos la lista de usuarios correspondiente a ese rol
      _currentUser = users[_userIndex++]; // Asignamos el usuario actual y avanzamos al siguiente índice de usuario
      return _currentUser!; // Retornamos el usuario actual
    }
  }

  @override
  void reset() {
    _roleIndex = 0;
    _userIndex = 0;
    _currentUser = null;
  }

  @override
  User current() {
    if (_currentUser == null) {
      throw Exception("Llama a next() primero");
    } else {
      return _currentUser!;
    }
  }
}