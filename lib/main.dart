import 'package:expense_tracker/binding/initial_binding.dart';
import 'package:expense_tracker/domain/expense/expense.dart';
import 'package:expense_tracker/domain/note/note.dart';
import 'package:expense_tracker/presentation/home/app_root.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_quill/flutter_quill.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

late Isar isar;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  isar = await Isar.open(
    [
      ExpenseSchema,
      NoteSchema,
    ],
    directory: dir.path,
    inspector: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBindings(),
      navigatorKey: navigatorKey,
      title: 'Expense',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AppRoot(),
      localizationsDelegates: const [
        FlutterQuillLocalizations.delegate,
      ],
    );
  }
}
