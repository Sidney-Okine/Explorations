import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sidneys_github_explorer/platform/persistence/models/UserModel.dart';
import 'package:sidneys_github_explorer/ux/utils/constants_and_strings_file.dart';
import 'package:sidneys_github_explorer/ux/views/followers/followers_page.dart';
import 'package:sidneys_github_explorer/ux/views/home/home_view_model.dart';
import 'package:sidneys_github_explorer/ux/views/repositories/contributions_page.dart';
import 'package:sidneys_github_explorer/ux/views/repositories/repositories.dart';
import 'package:sidneys_github_explorer/ux/views/user_profile/user_profile_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewModel _homeViewModel = HomeViewModel();
  UserModel? _userModel;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchUserModel();
  }

  void _fetchUserModel() async {
    setState(() => isLoading = true);
    _userModel = await _homeViewModel.fetchUserModel();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          AppStrings.appName,
          style: GoogleFonts.nunitoSans(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: Dimens.mediumTextSize,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: Dimens.defaultMargin),
              _buildUserDetails(),
              const SizedBox(height: Dimens.defaultMargin),
              _buildGridSections(),
            ],
          ),
        ),
      ),
    );
  }

  _buildUserDetails() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: Dimens.defaultPadding,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(_userModel?.photoURL ?? ""),
            ),
          ),
          Text(
            _userModel?.displayName ?? "",
            style: GoogleFonts.albertSans(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: Dimens.defaultTextSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            _userModel?.email ?? "",
            style: GoogleFonts.albertSans(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: Dimens.defaultTextSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: Dimens.defaultPadding,),
        ],
      ),
    );
  }

  Widget _buildGridSections() {
    final List<Map<String, dynamic>> sections = [
      {"title": "Profile", "icon": Icons.person_2_outlined, "onTap": () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UserProfileScreen()));
      }},
      {"title": "Repositories", "icon": Icons.book, "onTap": () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RepositorySelection()));
      }},
      {"title": "Followers", "icon": Icons.people, "onTap": () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FollowersPage()));
      }},
      {"title": "Contributions", "icon": Icons.code , "onTap": () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ContributionsPage()));
      }},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: sections.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: sections[index]["onTap"],
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(sections[index]["icon"], color: Colors.white, size: 50),
                const SizedBox(height: 10),
                Text(
                  sections[index]["title"],
                  style: GoogleFonts.nunitoSans(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: Dimens.defaultTextSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
