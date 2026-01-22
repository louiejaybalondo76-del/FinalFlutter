import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/screen/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Adidas',
      theme: ThemeData(useMaterial3: true, primaryColor: Colors.black),
      home: LoginScreen(),
    );
  }
}
