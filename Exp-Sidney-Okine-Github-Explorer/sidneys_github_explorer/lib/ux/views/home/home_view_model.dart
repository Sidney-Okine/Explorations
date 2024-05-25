import 'package:sidneys_github_explorer/platform/persistence/manager.dart';
import 'package:sidneys_github_explorer/platform/persistence/models/UserModel.dart';
import 'package:sidneys_github_explorer/ux/utils/constants_and_strings_file.dart';

class HomeViewModel {
  Future<UserModel?> fetchUserModel() async {
    return await Manager.getUserModel(AppStrings.userModel);
  }
}