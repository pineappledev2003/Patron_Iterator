import 'package:iterator_flutter_dart/models/user.dart';
import 'package:iterator_flutter_dart/patron_iterator/iterator/interfaz_iterator.dart';

class UserMapIterator implements InterfazIterator<User> {
  final Map<String, List<User>> _usersByRole;
  late List<String> _roles; // Claves del mapa
  int _roleIndex = 0; // en qué **rol (clave)** estamos.
  int _userIndex = 0; // en qué **usuario dentro de la lista** de ese rol estamos.
  User? _currentUser;

  UserMapIterator({required Map<String, List<User>> users})
    : _usersByRole = users {
    _roles = _usersByRole.keys.toList();
  }

  @override
  bool hasNext() {
    while (_roleIndex < _roles.length) {
      final role = _roles[_roleIndex];
      final users = _usersByRole[role];

      if (_userIndex < users!.length) {
        return true;
      } else {
        _roleIndex++;
        _userIndex = 0;
      }
    }
    return false;
  }

  @override
  User next() {
    if (!hasNext()) {
      throw Exception("No hay más usuarios");
    } else {
      final role = _roles[_roleIndex];
      final users = _usersByRole[role]!;
      _currentUser = users[_userIndex++];
      return _currentUser!;
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
