import 'package:iterator_flutter_dart/models/user.dart';
import 'package:iterator_flutter_dart/patron_iterator/iterator/interfaz_iterator.dart';

class UserListIterator implements InterfazIterator<User> {
  final List<User> _users;
  int _position = 0;
  User? _currentUser;

  UserListIterator({required List<User> users}) : _users = users;

  @override
  bool hasNext() {
    return _position < _users.length;
  }

  @override
  User next() {
    if (!hasNext()) {
      throw Exception("No more elements");
    } else {
      _currentUser = _users[_position++];
      return _currentUser!;
    }
  }

  @override
  void reset() {
    _position = 0;
    _currentUser = null;
  }

  @override
  User current() {
    if (_currentUser == null) {
      throw Exception("Call next() first");
    } else {
      return _currentUser!;
    }
  }
}
