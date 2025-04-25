import 'package:course_project/shared/auth_state.dart';
import 'package:flutter/material.dart';
import 'Signup.dart';


class Login extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Success"),
        content: Text("You have logged in successfully!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              AuthState.isLoggedIn.value = true;
              Navigator.of(context).pop(); // Go back after login
            },
            child: Text("OK"),
          )
        ],
      ),
    );
  }

  void _showValidationBanner(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text(message),
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

  void _handleLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Logging in...")),
      );

      Future.delayed(Duration(seconds: 1), () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        _showSuccessDialog(context);
      });
    } else {
      _showValidationBanner(context, "Please fix the errors above to continue.");
    }
  }

  @override
  Widget build(BuildContext context) {
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
                onPressed: () => _handleLogin(context),
                style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
                child: Text("Login"),
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
