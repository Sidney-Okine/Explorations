

class UserProfile {
  final String? login;
  final int? id;
  final String? avatarUrl;
  final String? url;
  final String? name;
  final String? company;
  final String? blog;
  final String? location;
  final String? email;
  final String? bio;
  final int? publicRepos;
  final int? followers;
  final int? following;

  UserProfile({
    this.login,
    this.id,
    this.avatarUrl,
    this.url,
    this.name,
    this.company,
    this.blog,
    this.location,
    this.email,
    this.bio,
    this.publicRepos,
    this.followers,
    this.following,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      login: json['login'],
      id: json['id'],
      avatarUrl: json['avatar_url'],
      url: json['url'],
      name: json['name'],
      company: json['company'],
      blog: json['blog'],
      location: json['location'],
      email: json['email'],
      bio: json['bio'],
      publicRepos: json['public_repos'],
      followers: json['followers'],
      following: json['following'],
    );
  }
}

class Repository {
  final int? id;
  final String? name;
  final String? fullName;
  final String? htmlUrl;
  final String? description;
  final String? language;
  final int? stargazersCount;

  Repository({
    this.id,
    this.name,
    this.fullName,
    this.htmlUrl,
    this.description,
    this.language,
    this.stargazersCount,
  });

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      id: json['id'],
      name: json['name'],
      fullName: json['full_name'],
      htmlUrl: json['html_url'],
      description: json['description'],
      language: json['language'],
      stargazersCount: json['stargazers_count'],
    );
  }
}

class Follower {
  final String login;
  final int id;
  final String avatarUrl;
  final String htmlUrl;

  Follower({
    required this.login,
    required this.id,
    required this.avatarUrl,
    required this.htmlUrl,
  });

  factory Follower.fromJson(Map<String, dynamic> json) {
    return Follower(
      login: json['login'],
      id: json['id'],
      avatarUrl: json['avatar_url'],
      htmlUrl: json['html_url'],
    );
  }
}

class Commit {
  final String sha;
  final String url;
  final String message;

  Commit({
    required this.sha,
    required this.url,
    required this.message,
  });

  factory Commit.fromJson(Map<String, dynamic> json) {
    return Commit(
      sha: json['sha'],
      url: json['url'],
      message: json['commit']['message'],
    );
  }
}