import 'package:flutter/material.dart';
import 'list_contact.dart';
import 'database/db_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.initHive(); // Inisialisasi Hive sebelum menjalankan aplikasi
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contact',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 187, 63, 36),
        ),
        useMaterial3: true,
      ),
      home: const ListContact(),
    );
  }
}
