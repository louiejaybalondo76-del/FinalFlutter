import 'package:e_commerce/screen/auth/login_screen.dart';
import 'package:flutter/material.dart';



class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  final String username = 'admin';
  final String password = 'admin123';

  void login() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _isLoading = false;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          //backgroundColor: Colors.red,
          content: Row(
            children: [
              Icon(Icons.warning, color: Colors.white),
              const SizedBox(width: 20),
              Text('Invalid username or password'),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Image.asset('assets/logo.png',),
                Image.asset('assets/logo.png', width: 170),
                Text(
                  "Let's create an account for you",
                  style: TextStyle(fontSize: 15),
                ),
            
                const SizedBox(height: 30),
            
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Colors.grey.shade700),
                    hintText: 'Input username',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(Icons.person),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
            
                const SizedBox(height: 12),
            
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.grey.shade700),
                    hintText: 'Input password',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(Icons.lock),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
            
                const SizedBox(height: 12),
            
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm password',
                    labelStyle: TextStyle(color: Colors.grey.shade700),
                    hintText: 'Input password',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(Icons.lock),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
            
                const SizedBox(height: 20),
            
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: _isLoading
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.0,
                            ),
                          )
                        : Text('Sign Up', style: TextStyle(fontSize: 15)),
                  ),
                ),
            
                // if (_errorMessage.isNotEmpty) ...[
                //   const SizedBox(height: 10),
                //   Text(_errorMessage, style: TextStyle(color: Colors.red)),
                // ],
                const SizedBox(height: 25),
            
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => LoginScreen()),
                    );
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
