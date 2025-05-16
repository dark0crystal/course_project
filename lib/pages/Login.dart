import 'package:course_project/shared/auth_state.dart';
import 'package:course_project/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Signup.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("OK"),
          )
        ],
      ),
    );
  }

  Future<void> _handleLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final authState = Provider.of<AuthState>(context, listen: false);
      
      try {
        await authState.login(email.text.trim(), password.text);
        if (mounted) {
          Navigator.of(context).pop(); // Go back after successful login
        }
      } catch (e) {
        if (mounted) {
          _showErrorDialog(context, e.toString());
        }
      }
    } else {
      ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          content: Text("Please fix the errors above to continue."),
          backgroundColor: Colors.amber.shade100,
          leading: Icon(Icons.warning, color: Colors.amber),
          actions: [
            TextButton(
              onPressed: () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
              child: Text("DISMISS"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthState>(context);
    
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return "Enter your email";
                  } else if (!emailRegex.hasMatch(val.trim())) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Enter your password";
                  } else if (val.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: authState.isLoading ? null : () => _handleLogin(context),
                style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
                child: authState.isLoading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text("Login"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => Signup()));
                },
                child: Text("Don't have an account? Sign Up"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
