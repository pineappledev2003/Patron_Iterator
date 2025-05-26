abstract class InterfazIterator<T> {
  T next(); //Siguiente
  bool hasNext(); // hay Mas

  void reset(); // Reiniciar
  T current(); // Actual
}