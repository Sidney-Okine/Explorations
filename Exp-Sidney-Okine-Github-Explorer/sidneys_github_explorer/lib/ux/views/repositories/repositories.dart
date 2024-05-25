import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sidneys_github_explorer/ux/utils/constants_and_strings_file.dart';
import 'package:sidneys_github_explorer/platform/network/github_explorer_apis.dart';
import 'package:sidneys_github_explorer/platform/network/github_explorer_endpoints.dart';
import 'package:sidneys_github_explorer/platform/network/models/response_models.dart';
import 'package:sidneys_github_explorer/platform/persistence/manager.dart';

class RepositorySelection extends StatefulWidget {
  const RepositorySelection({super.key});

  @override
  State<RepositorySelection> createState() => _RepositorySelectionState();
}

class _RepositorySelectionState extends State<RepositorySelection> {
  final githubExplorerApis = GithubExplorerApis(GithubExplorerEndpoints());
  List<Repository>? repositories;

  @override
  void initState() {
    super.initState();
    loadRepositories();
  }

  Future<void> loadRepositories() async {
    var user = await Manager.getUserModel(AppStrings.userModel);
    try {
      List<Repository> repos = await githubExplorerApis.getUserRepositories(user?.username ?? "");
      setState(() {
        repositories = repos;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.repositorySelection,
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
      body: repositories == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: repositories!.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: ListTile(
              leading: const Icon(Icons.book, color: Colors.black87),
              title: Text(
                repositories?[index].name ?? "Repository Name",
                style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                repositories![index].description ?? 'No description available',
                style: GoogleFonts.nunitoSans(),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward, color: Colors.black),
                onPressed: () {

                },
              ),
            ),
          );
        },
      ),
    );
  }
}
