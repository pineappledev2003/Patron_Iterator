import 'package:iterator_flutter_dart/patron_iterator/iterator/interfaz_iterator.dart';

abstract class IterableCollection<T> {
  InterfazIterator<T> createIterator();
}
