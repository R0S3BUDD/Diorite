import 'package:diorite/core/local_storage_service.dart';
import 'package:diorite/views/home_view.dart';
import 'package:flutter/material.dart';

void main() async {
  await LocalStorageService().init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomeView());
  }
}
