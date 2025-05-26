import 'package:flutter/material.dart';
import 'package:iterator_flutter_dart/models/user.dart';
import 'package:iterator_flutter_dart/patron_iterator/concreteCollection/user_map_collection.dart';

class MapUserView extends StatefulWidget {
  const MapUserView({super.key});

  @override
  State<MapUserView> createState() => _MapUserViewState();
}

class _MapUserViewState extends State<MapUserView> {
  final _formKey = GlobalKey<FormState>();
  final UserMapCollection userMapCollection = UserMapCollection();
  String nombre = "";
  String rol = "";

  String rolBuscador = "";
  Map<String, List<User>> _usuariosEncontrados = {};

  TextEditingController nombreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Usuarios (Map Iterator)"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                controller: nombreController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nombre",
                  labelStyle: TextStyle(color: Colors.black),
                ),
                cursorColor: Colors.black,
                onChanged: (value) {
                  nombre = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Este campo es obligatorio";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField(
                value: rol.isNotEmpty ? rol : null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Rol",
                ),
                items: [
                  DropdownMenuItem(value: "Admin", child: const Text("Admin")),
                  DropdownMenuItem(value: "User", child: const Text("User")),
                ],
                onChanged: (value) {
                  setState(() {
                    rol = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    userMapCollection.agregarItem(
                      User(nombre: nombre, rol: rol),
                    );

                    setState(() {
                      nombreController.clear();
                      rol = "";
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Usuario agregado correctamente'),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                child: const Text("Agregar"),
              ),
              const SizedBox(height: 50),
              const Text("Encuntra las personas asignadas a un rol especifico"),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Rol",
                ),
                items: [
                  DropdownMenuItem(value: "Admin", child: const Text("Admin")),
                  DropdownMenuItem(value: "User", child: const Text("User")),
                ],
                onChanged: (value) {
                  rolBuscador = value!;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _buscarGentePorRol(rolBuscador);
                },
                child: const Text("Buscar la gente con roles"),
              ),
              const SizedBox(height: 20),
              Expanded(
                child:
                    _usuariosEncontrados.isEmpty
                        ? const Text('No se encontraron usuarios.')
                        : ListView(
                          children:
                              _usuariosEncontrados.entries.map((entry) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Rol: ${entry.key}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    ...entry.value.map(
                                      (user) => ListTile(
                                        title: Text(user.nombre),
                                        subtitle: Text(user.rol),
                                      ),
                                    ),
                                    const Divider(),
                                  ],
                                );
                              }).toList(),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _buscarGentePorRol(String rol) {
    setState(() {
      _usuariosEncontrados = userMapCollection.buscarRolComoMap(rol);
    });
  }
}
