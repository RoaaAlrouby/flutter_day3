import 'package:flutter/material.dart';
import 'package:flutter_day3/widgets/app_text_field.dart';
import 'flutter_secure_storage.dart';
import 'widgets/validators.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _secureStorage = SecureStorage();

  String? _storedEmail;
  String? _storedPassword;
  bool _dataVisible = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      await _secureStorage.saveData('email', _emailController.text.trim());
      await _secureStorage.saveData(
        'password',
        _passwordController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data saved successfully!'),
          backgroundColor: Color(0xFF00695C),
        ),
      );
    }
  }

  Future<void> _showData() async {
    final email = await _secureStorage.readData('email');
    final password = await _secureStorage.readData('password');
    setState(() {
      _storedEmail = email;
      _storedPassword = password;
      _dataVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0F2F1),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding:  EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF004D40),
                    ),
                  ),
                  SizedBox(height: 40),
                  AppTextField(
                    controller: _emailController,
                    label: 'Email',
                    icon: Icons.email_outlined,
                    validator: Validators.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20),
                  AppTextField(
                    controller: _passwordController,
                    label: 'Password',
                    icon: Icons.lock_outline,
                    validator: Validators.validatePassword,
                    obscureText: _obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Color(0xFF00695C),
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF00695C),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 14),
                  ElevatedButton(
                    onPressed: _showData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF00695C),
                      foregroundColor: Colors.white,
                      padding:  EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Show Data',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (_dataVisible) ...[
                    SizedBox(height: 28),
                    Text(
                      'Email: ${_storedEmail ?? 'No data'}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Password: ${_storedPassword ?? 'No data'}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
