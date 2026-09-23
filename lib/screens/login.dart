import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dashboard.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscurePassword = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // create a function to handle login
  Future<void> handleLogin() async {
    final email = emailController.text;
    final password = passwordController.text;

    // Perform login logic here
    // Example: Make an API call to authenticate the user
    try {
      final response = await http.post(
        Uri.parse('http://10.29.215.50:8000/api/login'),
        body: {'email': email, 'password': password},
      );
      // handle the response from the API
      if (response.statusCode == 200) {
        // Login successful
        // Navigate to the next screen or show a success message
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardScreen(),
          ), // Replace with your actual Dashboard widget class name
        );
        // nextpage

        print('Login successful');
      } else if (response.statusCode == 401) {
        // Invalid credentials
        // Show an error message or handle the failure case
        print('Invalid credentials');
      } else {
        // Login failed
        // Show an error message or handle the failure case
        print('Login failed');
      }
    } catch (e) {
      // Handle any exceptions that occur during the API call
      print('Error during login: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('SHEREHE MANGEMENT SYSTEM'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              
              const SizedBox(height: 8),
              const Text(
                'Welcome back',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black,), textAlign: TextAlign.center),
              
              const SizedBox(height: 4),
                const Text(
                  'please login to continue',
                  style: TextStyle(fontSize: 14, color: Colors.black87, ),textAlign: TextAlign.center),
                
                const SizedBox(height: 28),
          
                // Card Container matching the UI design
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 28.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.grey.shade400,
                      width: 1.2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [                     
              const SizedBox(height: 40),
              const Text(
                'Email',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
              ),
              const SizedBox(height: 8),

              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 15,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                              color: Colors.grey.shade600,
                              width: 1.2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade600,
                              width: 1.2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xFFAB6005),
                              width: 1.5,
                            ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Password',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 15,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                              color: Colors.grey.shade600,
                              width: 1.2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xFFAB6005),
                              width: 1.5,
                            ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                height: 50,

                child: ElevatedButton(
                  onPressed: () {
                    handleLogin();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffab6005),elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                  ),
                  ),

                  child: const Text('LOGIN', style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,
                              color: Colors.white,)),
                ),
              ),
        ],
       ),
                ),        
     ],
   ),
        ),
        ),
  );
  }
}
