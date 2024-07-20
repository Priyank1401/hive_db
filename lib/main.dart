import 'package:flutter/material.dart';
import 'package:hive_db/hive/boxes.dart';
import 'package:hive_db/home_screen.dart';
import 'package:hive_db/model/notes_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(NotesModelAdapter());
  await Hive.openBox<NotesModel>('notes');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hive DB',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: const AppBarTheme(
            foregroundColor: Colors.white
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
