import 'dart:convert';
import 'dart:io';

import 'package:bloc_practice/model/post_model.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  Future<List<PostModel>> fetchPosts() async {
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/comments'),
      );
      if (response.statusCode == 200) {
        final body = json.decode(response.body) as List;
        return body.map((e) => PostModel.fromJson(e)).toList();
      }
    } on SocketException {
      throw Exception('error while fetching');
    }
    throw Exception('error while fetching');
  }
}
