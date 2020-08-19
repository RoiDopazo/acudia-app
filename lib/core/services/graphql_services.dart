// ignore_for_file: non_constant_identifier_names

import 'package:acudia/core/services/auth_link.dart';
import 'package:acudia/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

var authLink =
    CustomAuthLink().concat(HttpLink(uri: "$AWS_APP_SYNC_ENDPOINT/graphql"));

ValueNotifier<GraphQLClient> graphQLClient = ValueNotifier(
  GraphQLClient(
    cache: InMemoryCache(),
    link: authLink,
  ),
);

final String GRAPHQL_CREATE_ACUDIER_MUTATION =
    """mutation createAcudier(\$name: String!, \$secondName: String!, \$email: String!, \$gender: String!, \$birthDate: AWSDate!, \$photoUrl: String) {
  createAcudier(input: {name: \$name, secondName: \$secondName, email: \$email, genre: \$gender, birthDate: \$birthDate, photoUrl: \$photoUrl}) {
    name,
    secondName
    email,
    genre,
    birthDate
    photoUrl
  }
}""";

final String GRAPHQL_CREATE_CLIENT_MUTATION =
    """mutation createClient(\$name: String!, \$secondName: String!, \$email: String! \$photoUrl: String) {
  createClient(input: {name: \$name, secondName: \$secondName, email: \$email, photoUrl: \$photoUrl}) {
    name,
    secondName
    email,
    photoUrl
  }
}""";
