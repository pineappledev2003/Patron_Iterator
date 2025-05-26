class User {
  late String _nombre;
  late String _rol;

  User({required String nombre, required String rol})
    : _nombre = nombre,
      _rol = rol;

  set cambiarNombre(String nuevoNombre) {
    _nombre = nuevoNombre;
  }

  set cambiarRol(String nuevoRol) {
    _rol = nuevoRol;
  }

  String get nombre {
    return _nombre;
  }

  String get rol {
    return _rol;
  }

  @override
  String toString() {
    return "Nombre: $nombre - Rol: $rol";
  }
}
