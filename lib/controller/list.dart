import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Post>> fetchPost() async {
  http.Response response =
      await http.get('https://virtserver.swaggerhub.com/nguansak/lucky-draw/1.0.0/rewardItem');
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
  final String id;
  final String name;
  final int quota;

  Post({this.id, this.name, this.quota});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      name: json['name'],
      quota: json['quota'],
    );
  }
}