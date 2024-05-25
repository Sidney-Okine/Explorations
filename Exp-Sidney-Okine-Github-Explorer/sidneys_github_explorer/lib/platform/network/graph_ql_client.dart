import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  static GraphQLClient? client;
  static const String _token = "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";

  static void initGraphQL() {
    final HttpLink httpLink = HttpLink(
      'https://api.github.com/graphql',
      defaultHeaders: {
        'Authorization': 'Bearer $_token',
      },
    );

    client = GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    );
  }
}




