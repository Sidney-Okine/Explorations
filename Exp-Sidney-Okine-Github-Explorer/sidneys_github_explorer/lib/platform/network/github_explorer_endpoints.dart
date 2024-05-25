import 'dart:convert';
import 'package:http/http.dart' as http;

class GithubExplorerEndpoints {
  static const String _baseUrl = 'https://api.github.com';

  Future<dynamic> fetchUserProfile(String username) async {
    final response = await http.get(Uri.parse('$_baseUrl/users/$username'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  Future<dynamic> fetchUserRepositories(String username) async {
    final response = await http.get(Uri.parse('$_baseUrl/users/$username/repos'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load user repositories');
    }
  }

  Future<dynamic> fetchUserFollowers(String username) async {
    final response = await http.get(Uri.parse('$_baseUrl/users/$username/followers'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load user followers');
    }
  }

  Future<dynamic> fetchUserCommitHistory(String username, String repo) async {
    final response = await http.get(Uri.parse('$_baseUrl/repos/$username/$repo/commits'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load commit history');
    }
  }
}