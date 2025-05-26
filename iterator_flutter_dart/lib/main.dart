import 'package:flutter/material.dart';
import 'package:iterator_flutter_dart/screens/list_user_view.dart';
import 'package:iterator_flutter_dart/screens/map_user_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Patron Iterator",
      initialRoute: "/",
      routes: {
        "/":(BuildContext context) => ListViewUser(),
        "/2":(BuildContext context) => MapUserView()
      },
    );
  }
}
