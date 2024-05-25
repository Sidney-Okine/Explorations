import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sidneys_github_explorer/platform/network/github_explorer_apis.dart';
import 'package:sidneys_github_explorer/platform/network/github_explorer_endpoints.dart';
import 'package:sidneys_github_explorer/platform/network/models/response_models.dart';
import 'package:sidneys_github_explorer/platform/persistence/manager.dart';
import 'package:sidneys_github_explorer/ux/utils/constants_and_strings_file.dart';

class FollowersPage extends StatefulWidget {
  const FollowersPage({Key? key}) : super(key: key);

  @override
  _FollowersPageState createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  late final GithubExplorerApis _apis;
  bool _isLoading = true;
  List<Follower> _followers = [];

  @override
  void initState() {
    super.initState();
    _apis = GithubExplorerApis(GithubExplorerEndpoints());
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      var user = await Manager.getUserModel(AppStrings.userModel);
      _followers = await _apis.getUserFollowers(user?.username ?? "");
    } catch (e) {
      print("Failed to load followers: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildFollowerTile(Follower follower) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(follower.avatarUrl),
          backgroundColor: Colors.grey[200],
        ),
        title: Text(
          follower.login,
          style: GoogleFonts.nunitoSans(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          AppStrings.followers,
          style: GoogleFonts.nunitoSans(
            color: Colors.black,
            fontSize: Dimens.largeTextSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _followers.length,
        itemBuilder: (context, index) => _buildFollowerTile(_followers[index]),
      ),
    );
  }
}
