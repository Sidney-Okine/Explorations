import 'dart:convert';
import 'package:sidneys_github_explorer/platform/network/github_explorer_endpoints.dart';
import 'package:sidneys_github_explorer/platform/network/models/response_models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'graph_ql_client.dart';

class GithubExplorerApis {
  final GithubExplorerEndpoints _endpoints;

  GithubExplorerApis(this._endpoints);

  Future<UserProfile> getUserProfile(String username) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final userProfile = await _endpoints.fetchUserProfile(username);
      prefs.setString('userProfile', jsonEncode(userProfile));
      return userProfile;
    } catch (_) {
      final cachedData = prefs.getString('userProfile');
      if (cachedData != null) {
        return UserProfile.fromJson(jsonDecode(cachedData));
      } else {
        throw Exception('Failed to load user profile');
      }
    }
  }

  Future<List<RepositoryCommitContribution>> fetchUserCommitContributions(String username) async {
    const String readRepositories = r'''
      query UserCommitContributions($username: String!) {
        user(login: $username) {
          contributionsCollection {
            commitContributionsByRepository(maxRepositories: 100) {
              repository {
                name
              }
              contributions {
                totalCount
              }
            }
          }
        }
      }
    ''';

    final QueryOptions options = QueryOptions(
      document: gql(readRepositories),
      variables: <String, dynamic>{
        'username': username,
      },
    );

    final QueryResult result = await GraphQLService.client?.query(options) ?? QueryResult(data: {}, options: options, source: QueryResultSource.network);

    if (result.hasException) {
      print(result.exception.toString());
      throw Exception('Failed to load user commit contributions');
    }

    final List<dynamic> repositoriesJson = result.data!['user']['contributionsCollection']['commitContributionsByRepository'] as List<dynamic>;

    List<RepositoryCommitContribution> contributions = repositoriesJson.map((dynamic repoJson) => RepositoryCommitContribution.fromJson(repoJson)).toList();

    return contributions;
  }



  Future<List<Repository>> getUserRepositories(String username) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final repositories = await _endpoints.fetchUserRepositories(username);
      prefs.setString('userRepositories', jsonEncode(repositories));
      return repositories;
    } catch (_) {
      final cachedData = prefs.getString('userRepositories');
      if (cachedData != null) {
        Iterable list = json.decode(cachedData);
        return list.map((model) => Repository.fromJson(model)).toList();
      } else {
        throw Exception('Failed to load user repositories');
      }
    }
  }

  Future<List<Follower>> getUserFollowers(String username) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final followers = await _endpoints.fetchUserFollowers(username);
      prefs.setString('userFollowers', jsonEncode(followers));
      return followers;
    } catch (_) {
      final cachedData = prefs.getString('userFollowers');
      if (cachedData != null) {
        Iterable list = json.decode(cachedData);
        return list.map((model) => Follower.fromJson(model)).toList();
      } else {
        throw Exception('Failed to load user followers');
      }
    }
  }

  Future<List<Commit>> getUserCommitHistory(
      String username, String repo) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final commits = await _endpoints.fetchUserCommitHistory(username, repo);
      prefs.setString('userCommitHistory', jsonEncode(commits));
      return commits;
    } catch (_) {
      final cachedData = prefs.getString('userCommitHistory');
      if (cachedData != null) {
        Iterable list = json.decode(cachedData);
        return list.map((model) => Commit.fromJson(model)).toList();
      } else {
        throw Exception('Failed to load commit history');
      }
    }
  }
}

class RepositoryCommitContribution {
  final String repositoryName;
  final int totalCount;

  RepositoryCommitContribution({required this.repositoryName, required this.totalCount});

  factory RepositoryCommitContribution.fromJson(Map<String, dynamic> json) {
    return RepositoryCommitContribution(
      repositoryName: json['repository']['name'] as String,
      totalCount: json['contributions']['totalCount'] as int,
    );
  }
}
