import 'package:iterator_flutter_dart/models/user.dart';
import 'package:iterator_flutter_dart/patron_iterator/concreteIterator/user_map_iterator.dart';
import 'package:iterator_flutter_dart/patron_iterator/iterableCollection/iterable_collection.dart';
import 'package:iterator_flutter_dart/patron_iterator/iterator/interfaz_iterator.dart';

class UserMapCollection implements IterableCollection<User> {
  final Map<String, List<User>> _userByRole = {};

  void agregarItem(User user) {
    _userByRole.putIfAbsent(user.rol, () => []);
    _userByRole[user.rol]!.add(user);
  }

  @override
  InterfazIterator<User> createIterator() {
    return UserMapIterator(users: _userByRole);
  }

  Map<String, List<User>> buscarRolComoMap(String rolBuscado) {
    final Map<String, List<User>> resultado = {};
    final iterator = createIterator();

    while (iterator.hasNext()) {
      final user = iterator.next();
      if (user.rol == rolBuscado) {
        resultado.putIfAbsent(rolBuscado, () => []);
        resultado[rolBuscado]!.add(user);
      }
    }

    return resultado;
  }

  // List<User> obtenerTodos() {
  //   final List<User> resultado = [];
  //   final iterator = createIterator();

  //   while (iterator.hasNext()) {
  //     resultado.add(iterator.next());
  //   }

  //   return resultado;
  // }

  // Map<String, List<User>> obtenerTodos() {
  //   final Map<String, List<User>> resultado = {};
  //   final iterator = createIterator();
  //   iterator.reset();

  //   while (iterator.hasNext()) {
  //     final user = iterator.next();
  //     resultado.putIfAbsent(user.rol, () => []);
  //     resultado[user.rol]!.add(user);
  //   }

  //   return resultado;
  // }
}
