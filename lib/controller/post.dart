import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Post>> fetchPost(int count) async {
  http.Response response =
      await http.get('https://jsonplaceholder.typicode.com/users');
  List responseJson = json.decode(response.body);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return responseJson.map((m) => Post.fromJson(m)).toList();
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final int id;
  final String name;
  final String username;
  final String email;

  Post({this.id, this.name, this.username, this.email});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
    );
  }
}