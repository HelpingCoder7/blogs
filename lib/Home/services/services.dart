import 'dart:developer';
import 'package:blogs/Home/model/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiServices {
  Future<List<Blogmodel>> fetchBlogs() async {
    const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    const String adminSecret =
        '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      // log('Response body: ${response.body}');
      log('data fetched');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        final List<dynamic> data = responseBody['blogs'] ?? [];
        final List<Blogmodel> blogs =
            data.map((e) => Blogmodel.fromJson(e)).toList();
        return blogs;
      } else {
        log('Request failed with status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('An error occurred: $e');
      return [];
    }
  }
}
