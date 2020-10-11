// ignore_for_file: non_constant_identifier_names

import 'package:acudia/core/services/auth_link.dart';
import 'package:acudia/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

var authLink = CustomAuthLink().concat(HttpLink(uri: "$AWS_APP_SYNC_ENDPOINT/graphql"));

ValueNotifier<GraphQLClient> graphQLClient = ValueNotifier(
  GraphQLClient(
    cache: InMemoryCache(),
    link: authLink,
  ),
);
