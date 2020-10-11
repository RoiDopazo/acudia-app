// ignore_for_file: non_constant_identifier_names

final String GRAPHQL_GET_PROFILE_QUERY = """query (\$role: String!) {
  getProfile(input: {role: \$role}) {
    PK
    SK
    name
    secondName
    email
    genre
    birthDate
    photoUrl
    createdAt
    updatedAt
    deletedAt
  }
}""";
