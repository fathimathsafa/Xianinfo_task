import 'package:cm_task/presentation/home_screen/view/home_screen.dart';
import 'package:cm_task/presentation/sale_screen/controller/sale_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCcaEO8JVS6N9Z759CN7AZaN2cGTaJpsQw",
      appId: "1:21559201865:android:79a7a92a2462b93e046f98",
      messagingSenderId: "", 
      projectId: "cmtask-6115c",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => SaleProvider()), 
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        
        home: HomeScreen(),
      ),
    );
  }
}
