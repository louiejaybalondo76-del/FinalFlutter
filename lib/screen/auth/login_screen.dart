import 'package:e_commerce/screen/auth/signup_screen.dart';
import 'package:e_commerce/screen/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import ito

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  // Default admin credentials
  final String adminUser = 'admin';
  final String adminPass = '123';

  void login() async {
    setState(() {
      _isLoading = true;
    });

    // Kunin ang data mula sa local storage na sinave ng Signup Screen
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? savedUser = prefs.getString('saved_username');
    final String? savedPass = prefs.getString('saved_password');

    // Konting delay para sa loading effect
    await Future.delayed(const Duration(seconds: 2));

    String inputUser = _usernameController.text;
    String inputPass = _passwordController.text;

    // Check kung match sa Signup data O sa Default admin data
    bool isAuthorized = (inputUser == savedUser && inputPass == savedPass) || 
                        (inputUser == adminUser && inputPass == adminPass);

    if (isAuthorized) {
      if (mounted) {
        Navigator.pushReplacement( // Ginamit ang pushReplacement para hindi na makabalik sa login
          context,
          MaterialPageRoute(builder: (context) => const BottomNavBar()),
        );
      }
    } else {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Row(
              children: [
                Icon(Icons.warning, color: Colors.white),
                SizedBox(width: 20),
                Text('Invalid username or password'),
              ],
            ),
          ),
        );
      }
    }
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
                Image.asset('adidaslogo.png', width: 170),
                const Text('Welcome back, please sign in..'),
                const SizedBox(height: 30),
                
                // Username Field
                _buildTextField(
                  controller: _usernameController,
                  label: 'Username',
                  hint: 'Input username',
                  icon: Icons.person,
                ),
                const SizedBox(height: 12),
                
                // Password Field
                _buildTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hint: 'Input password',
                  icon: Icons.lock,
                  isObscure: true,
                ),
                const SizedBox(height: 20),

                // Sign In Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.0,
                            ),
                          )
                        : const Text('Sign In', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 25),

                // Link to Signup
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SignupScreen()),
                        );
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method para sa TextField para hindi paulit-ulit ang code
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool isObscure = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey.shade700),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        fillColor: Colors.white,
        filled: true,
        prefixIcon: Icon(icon),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}