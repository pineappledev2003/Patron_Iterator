// ignore_for_file: slash_for_doc_comments

import 'package:iterator_flutter_dart/models/user.dart';
import 'package:iterator_flutter_dart/patron_iterator/iterator/interfaz_iterator.dart';

class UserListIterator implements InterfazIterator<User> {
  final List<User> _users; //Lista original de usuarios
  int _position = 0; // Posicion actual dentro de la lista
  User? _currentUser; // Guarda el ultimo usuario que se devolvio con next()

  UserListIterator({required List<User> users}) : _users = users;

  /**
   *  ? Verifica si todavía quedan elementos por recorrer.
   *  ? Si _position es menor que el largo de la lista, retorna true.
   *  ? Cuando _position alcanza el final de la lista, retorna false.
   *  
   *  ! Ejemplo
   *  ? Lista de 3 elementos (length = 3), si _position = 0, hay más → true.
   *  ? i _position = 3, ya terminó → false.
   */

  @override
  bool hasNext() {
    return _position < _users.length;
  }

  /**
   * ? Si ya no hay más elementos (!hasNext()), lanza una excepción.
   * ? Si sí hay:
   * ? Guarda el usuario actual en _currentUser.
   * ? Incrementa _position para apuntar al siguiente.
   * ? Retorna el usuario actual.
   * 
   * ! Ejemplo
   * ? _position = 0, devuelve _users[0], luego _position = 1.
   * ? _position = 1, devuelve _users[1], luego _position = 2.
   */

  @override
  User next() {
    if (!hasNext()) {
      throw Exception("No more elements");
    } else {
      _currentUser = _users[_position++];
      return _currentUser!;
    }
  }

  /**
   * ? Reinicia el iterador:
   * ? Pone _position en 0 (vuelve al inicio).
   * ? Limpia _currentUser.
   */

  @override
  void reset() {
    _position = 0;
    _currentUser = null;
  }

  /**
   * ? Devuelve el usuario actual, es decir, el último que devolvió next().
   * ? Si aún no se llamó a next(), lanza una excepción (porque no hay "usuario actual").
   */

  @override
  User current() {
    if (_currentUser == null) {
      throw Exception("Call next() first");
    } else {
      return _currentUser!;
    }
  }
}