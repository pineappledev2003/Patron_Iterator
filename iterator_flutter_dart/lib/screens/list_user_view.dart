import 'package:flutter/material.dart';
import 'package:iterator_flutter_dart/models/user.dart';
import 'package:iterator_flutter_dart/patron_iterator/concreteCollection/user_list_collection.dart';

class ListViewUser extends StatefulWidget {
  const ListViewUser({super.key});

  @override
  State<ListViewUser> createState() => _ListViewUserState();
}

class _ListViewUserState extends State<ListViewUser> {
  final _formKey = GlobalKey<FormState>();
  final UserListCollection userListCollection = UserListCollection();
  List<User> usuarios = [];

  String nombre = "";
  String rol = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Usuarios (List Iterator)"),
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Rol",
                ),
                items: [
                  DropdownMenuItem(value: "Admin", child: const Text("Admin")),
                  DropdownMenuItem(value: "User", child: const Text("User")),
                ],
                onChanged: (value) {
                  rol = value!;
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        userListCollection.agregarItema(
                          User(nombre: nombre, rol: rol),
                        );
                        setState(() {
                          usuarios = userListCollection.obtenerTodos();
                        });
                      }
                    },
                    child: const Text("Agregar"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _mostrarUsuariosOrdenados();
                    },
                    child: const Text("Ordenar usuarios por nombre"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/2");
                    },
                    child: const Text("Ir a la Map"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: usuarios.length,
                  itemBuilder: (BuildContext context, int index) {
                    final user = usuarios[index];
                    return ListTile(
                      title: Text(user.nombre),
                      subtitle: Text('Rol: ${user.rol}'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _mostrarUsuariosOrdenados() {
    setState(() {
      usuarios = userListCollection.obtenerTodosLosUsuariosOrdenadosPorNombre();
    });
  }
}
