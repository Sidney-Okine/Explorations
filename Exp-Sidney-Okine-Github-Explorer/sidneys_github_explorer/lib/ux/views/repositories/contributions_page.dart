import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sidneys_github_explorer/platform/network/github_explorer_apis.dart';
import 'package:sidneys_github_explorer/platform/network/github_explorer_endpoints.dart';
import 'package:sidneys_github_explorer/platform/network/graph_ql_client.dart';
import 'package:sidneys_github_explorer/platform/persistence/manager.dart';
import 'package:sidneys_github_explorer/ux/utils/constants_and_strings_file.dart';

class ContributionsPage extends StatefulWidget {
  const ContributionsPage({Key? key}) : super(key: key);

  @override
  State<ContributionsPage> createState() => _ContributionsPageState();
}

class _ContributionsPageState extends State<ContributionsPage> {
  late final GithubExplorerApis _apis;
  bool _isLoading = true;
  final List<BarChartGroupData> _barGroups = [];
  List<Map<String, dynamic>> _repoDetails = [];
  final List<Color> _barColors = [
    Colors.deepPurple,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.red
  ];

  @override
  void initState() {
    super.initState();
    if (GraphQLService.client == null) {
      GraphQLService.initGraphQL();
    }

    _apis = GithubExplorerApis(GithubExplorerEndpoints());
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      var user = await Manager.getUserModel(AppStrings.userModel);
      var contributions =
          await _apis.fetchUserCommitContributions(user?.username ?? "");
      int index = 0;
      _repoDetails = contributions.map((c) {
        final color = _barColors[index % _barColors.length];
        _barGroups.add(
          BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(y: c.totalCount.toDouble(), colors: [color])
            ],
          ),
        );
        index++;
        return {
          'name': c.repositoryName,
          'color': color,
        };
      }).toList();
    } catch (e) {
      print("Failed to load contributions: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildLegend() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _repoDetails.map((repoDetail) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.circle, color: repoDetail['color'] as Color, size: 12),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  repoDetail['name'] as String,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.albertSans(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: Dimens.defaultTextSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.contributions,
          style: GoogleFonts.nunitoSans(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: Dimens.largeTextSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Dimens.defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 1.2,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: _barGroups.fold<double>(
                                  0,
                                  (previousValue, element) => element.barRods
                                      .fold(
                                          0,
                                          (prev, rod) =>
                                              rod.y > prev ? rod.y : prev)) *
                              15.0,
                          barGroups: _barGroups,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      AppStrings.repositoryContributions,
                      style: GoogleFonts.nunitoSans(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: Dimens.mediumTextSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildLegend(),
                  ],
                ),
              ),
            ),
    );
  }
}
