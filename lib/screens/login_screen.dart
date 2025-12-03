import 'package:flutter/material.dart';
import 'package:metalixmovil/controllers/auth_controller.dart';
import 'home_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool hidePassword = true;
  bool isLoading = false;

  final Color mainColor = const Color(0xFF1FC7DB);

  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // ============================================
  // 🔹 LOGIN LOGIC (conectado al AuthController)
  // ============================================
  Future<void> _performLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email and password are required")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final user = await AuthController.login(email, password);

      setState(() => isLoading = false);

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const DashboardScreen()),
        );
      }
    } catch (e) {
      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed: $e")),
      );
    }
  }

  // ============================================
  // 🔹 UI
  // ============================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            width: 400,
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 🔹 Logo y título
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.recycling, size: 40, color: mainColor),
                        const SizedBox(width: 8),
                        Text(
                          'Metalix',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: mainColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // 🔹 Encabezado
                    const Text(
                      'Welcome Back',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Sign in to your account to continue',
                      style: TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 32),

                    // 🔹 Email Field
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined, color: mainColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 🔹 Password Field
                    TextField(
                      controller: passwordController,
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock_outline, color: mainColor),
                        suffixIcon: IconButton(
                          icon: Icon(
                            hidePassword ? Icons.visibility_off : Icons.visibility,
                            color: mainColor,
                          ),
                          onPressed: () {
                            setState(() => hidePassword = !hidePassword);
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // 🔹 Botón login
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: isLoading ? null : _performLogin,
                      child: isLoading
                          ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                          : const Text(
                        'Sign In',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // 🔹 Link de registro
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Create Account',
                            style: TextStyle(color: mainColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
