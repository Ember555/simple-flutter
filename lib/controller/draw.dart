import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

Future<Post> drawPost() async {
  http.Response response = await http.post(
      'https://luckydraw-api-fydvnltgua-an.a.run.app/reward/draw', body: {'playerId': 'test'});

  if (response.statusCode == 200 || response.statusCode == 400) {
    // If the call to the server was successful, parse the JSON.
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final int code;
  String message = '';
  Result result;

  Post({this.code, this.result, this.message});

  factory Post.fromJson(Map<String, dynamic> json) {
    if (json['code'] == 200) {
      return Post(code: json['code'], result: Result.fromJson(json['result']));
    }
    return Post(code: json['code'], message: json['message']);
  }
}

class Result {
  String ticketId;
  Reward reward;

  Result({this.ticketId, this.reward});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
        ticketId: json['ticketId'], reward: Reward.fromJson(json['reward']));
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
