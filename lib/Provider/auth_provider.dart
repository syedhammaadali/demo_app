import 'dart:convert';
import 'package:demo_app/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  int? _loggedInUserId; 

  bool get isLoading => _isLoading;
  int? get loggedInUserId => _loggedInUserId;

  Future<void> login(String email, String password, BuildContext context) async {
    _setLoading(true);
    final url = Uri.parse('https://jsonplaceholder.typicode.com/users/');
    try {
      final response = await http.get(url);
      final List<dynamic> responseData = json.decode(response.body);
      
      final user = responseData.firstWhere((user) => user['email'] == email, orElse: () => null);
      
      if (user != null) {
        if (user['username'] == password) {
          _loggedInUserId = user['id'];
          _showSnackBar(context, 'Login Successful', Colors.green);
          _showSnackBar(context, "Logged in user is $_loggedInUserId", Colors.black);
          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
        } else {
          _showSnackBar(context, 'Invalid email or password', Colors.red);
        }
      } else {
        _showSnackBar(context, 'Email not found', Colors.red);
      }
    } catch (error) {
      _showSnackBar(context, 'Failed to connect to server', Colors.red);
    }
    _setLoading(false);
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color,
    ));
  }
}
