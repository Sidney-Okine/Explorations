import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sidneys_github_explorer/platform/persistence/manager.dart';
import 'package:sidneys_github_explorer/ux/utils/constants_and_strings_file.dart';
import 'package:sidneys_github_explorer/platform/network/github_explorer_apis.dart';
import 'package:sidneys_github_explorer/platform/network/github_explorer_endpoints.dart';
import 'package:sidneys_github_explorer/platform/network/models/response_models.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  UserProfile? userProfile;
  final githubExplorerApis = GithubExplorerApis(GithubExplorerEndpoints());

  @override
  void initState() {
    super.initState();
    getUserProfile();
  }

  Future<void> getUserProfile() async {
    var user = await Manager.getUserModel(AppStrings.userModel);
    try {
      UserProfile profile =
          await githubExplorerApis.getUserProfile(user?.username ?? "");
      setState(() {
        userProfile = profile;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.userProfile,
          style: GoogleFonts.nunitoSans(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: userProfile == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Dimens.defaultPadding),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(userProfile!.avatarUrl ??
                          ''),
                      backgroundColor: Colors.transparent,
                    ),
                    const SizedBox(height: Dimens.defaultMargin),
                    Text(
                      userProfile!.name ?? 'Name not available',
                      style: GoogleFonts.nunitoSans(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: Dimens.defaultPadding,
                    ),
                    _infoCard('Username', userProfile!.login ?? ""),
                    _infoCard(
                      'ID',
                      userProfile!.id.toString(),
                    ),
                    _infoCard(
                      'Company',
                      userProfile!.company ?? 'Not available',
                    ),
                    _infoCard(
                      'Location',
                      userProfile!.location ?? 'Not available',
                    ),
                    _infoCard(
                      'Email',
                      userProfile!.email ?? 'Not available',
                    ),
                    _infoCard(
                      'Bio',
                      userProfile!.bio ?? 'Not available',
                    ),
                    _infoCard(
                      'Public Repos',
                      userProfile!.publicRepos.toString(),
                    ),
                    _infoCard(
                      'Followers',
                      userProfile!.followers.toString(),
                    ),
                    _infoCard(
                      'Following',
                      userProfile!.following.toString(),
                    ),
                    const SizedBox(
                      height: Dimens.defaultPadding,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _infoCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: ListTile(
        leading: const Icon(Icons.code, color: Colors.black),
        title: Text(title,
            style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
      ),
    );
  }
}
