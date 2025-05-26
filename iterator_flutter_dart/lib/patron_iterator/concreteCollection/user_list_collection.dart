import 'package:iterator_flutter_dart/models/user.dart';
import 'package:iterator_flutter_dart/patron_iterator/concreteIterator/user_list_iterator.dart';
//import 'package:iterator_flutter_dart/patron_iterator/concreteIterator/user_list_reverse.dart';
import 'package:iterator_flutter_dart/patron_iterator/iterableCollection/iterable_collection.dart';
import 'package:iterator_flutter_dart/patron_iterator/iterator/interfaz_iterator.dart';

class UserListCollection implements IterableCollection<User> {
  final List<User> _users = [];

  void agregarItema(User user) {
    _users.add(user);
  }

  @override
  InterfazIterator<User> createIterator() {
    return UserListIterator(users: _users);
    //return UserListReverseIterator(users: _users);
  }

  List<User> obtenerTodosLosUsuariosOrdenadosPorNombre() {
    final List<User> resultado = [];
    final iterator = createIterator();

    while (iterator.hasNext()) {
      resultado.add(iterator.next());
    }

    resultado.sort((a, b) => a.nombre.compareTo(b.nombre));
    return resultado;
  }

  List<User> obtenerTodos() {
    final List<User> resultado = [];
    final iterator = createIterator();

    while (iterator.hasNext()) {
      resultado.add(iterator.next());
    }

    return resultado;
  }

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
