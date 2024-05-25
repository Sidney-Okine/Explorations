import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sidneys_github_explorer/platform/persistence/models/UserModel.dart';
import 'package:sidneys_github_explorer/platform/persistence/manager.dart';
import 'package:sidneys_github_explorer/ux/utils/constants_and_strings_file.dart';
import 'package:sidneys_github_explorer/ux/views/home/home_screen.dart';

import 'package:sign_button/sign_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Manager.isUserLoggedIn(AppStrings.userLoggedInState).then((isLoggedIn) {
      if (isLoggedIn == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(Dimens.defaultPadding),
              child: Text(
                AppStrings.welcomeText,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 70,
              padding: const EdgeInsets.only(top: Dimens.defaultPadding),
              child: SignInButton(
                buttonType: ButtonType.github,
                width: MediaQuery.of(context).size.width * 0.8,
                onPressed: () async {
                  try {
                    UserCredential userCredential = await signInWithGithub();
                    UserModel userModel = UserModel.fromUserCredential(userCredential);
                    await Manager.saveUserModel(AppStrings.userModel, userModel);
                    await Manager.saveUserLoggedInStatus(AppStrings.userLoggedInState, true);
                    if (context.mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    }
                  } catch (e) {}
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<UserCredential> signInWithGithub() async {
    GithubAuthProvider githubAuthProvider = GithubAuthProvider();
    return await FirebaseAuth.instance.signInWithProvider(githubAuthProvider);
  }
}