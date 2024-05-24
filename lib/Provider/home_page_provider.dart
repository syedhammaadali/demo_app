import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class HomePageProvider with ChangeNotifier {
  bool _isLoading = true;
  List<PostDataParse> _posts = [];

  bool get isLoading => _isLoading;
  List<PostDataParse> get posts => _posts;

  HomePageProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        _posts =
            responseData.map((json) => PostDataParse.fromJson(json)).toList();
        _isLoading = false;
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
      _isLoading = false;
      notifyListeners();
    }
  }
}

class PostDataParse {
  final int? userId;
  final int? id;
  final String? title;
  final String? body;

  PostDataParse({this.userId, this.id, this.title, this.body});

  factory PostDataParse.fromJson(Map<String, dynamic> json) {
    return PostDataParse(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
