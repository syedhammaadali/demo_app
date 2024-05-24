import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!regex.hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  return authProvider.isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              authProvider.login(
                                _emailController.text,
                                _passwordController.text,
                                context,
                              );
                            }
                          },
                          child: Text("Login"),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
