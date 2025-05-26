import 'package:iterator_flutter_dart/models/user.dart';
import 'package:iterator_flutter_dart/patron_iterator/iterator/interfaz_iterator.dart';

class UserListReverseIterator implements InterfazIterator<User> {
  final List<User> _users;
  int _position;
  User? _currentUser;

  UserListReverseIterator({required List<User> users})
    : _users = users,
      _position = users.length - 1;

  @override
  bool hasNext() {
    return _position >= 0;
  }

  @override
  User next() {
    if (!hasNext()) {
      throw Exception("No more elements");
    } else {
      _currentUser = _users[_position--];
      return _currentUser!;
    }
  }

  @override
  void reset() {
    _position = _users.length - 1;
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
