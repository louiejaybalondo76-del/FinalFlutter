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
    //const MainApp()
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Add to Cart App',
      theme: ThemeData(
        useMaterial3: true,
        //primarySwatch: Colors.orange
        primaryColor: Colors.deepOrangeAccent
        //colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange).copyWith(secondary: Colors.deepOrangeAccent)
        ),
      home: LoginScreen(),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => SplashScreen(),
      //   '/home': (context) => HomeScreen()
      // },
    );
  }
}
