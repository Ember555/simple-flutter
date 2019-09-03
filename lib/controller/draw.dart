import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Post> drawPost() async {
  http.Response response = await http.post(
      'https://virtserver.swaggerhub.com/nguansak/lucky-draw/1.0.0/reward/draw');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final double status;
  Result result;

  Post({this.status, this.result});

  factory Post.fromJson(Map<String, dynamic> json) {
    print(json);
    return Post(
      status: json['status'],
      result: Result.fromJson(json['result'])
    );
  }
}

class Result {
  String ticketId;
  Reward reward;

  Result({
    this.ticketId,
    this.reward
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      ticketId: json['ticketId'],
      reward: Reward.fromJson(json['reward'])
    );
  }
}

class Reward {
  String id;

  Reward({
    this.id,
  });

  factory Reward.fromJson(Map<String, dynamic> json) {
    return Reward(
      id: json['id'],
    );
  }
}
