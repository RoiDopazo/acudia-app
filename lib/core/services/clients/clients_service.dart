// ignore_for_file: non_constant_identifier_names

final String GRAPHQL_CREATE_CLIENT_MUTATION =
    """mutation createClient(\$name: String!, \$secondName: String!, \$email: String! \$photoUrl: String) {
  createClient(input: {name: \$name, secondName: \$secondName, email: \$email, photoUrl: \$photoUrl}) {
    name,
    secondName
    email,
    photoUrl
  }
}""";

final String GRAPHQL_GET_CLIENT_BY_ID = """query (\$email: String!) {
  getClientByID(input: {id: \$email}) {
    PK
    SK
    name
    secondName
    email
    photoUrl
    createdAt
    updatedAt
  }
}""";
