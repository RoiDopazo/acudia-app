// ignore_for_file: non_constant_identifier_names

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

final String GRAPHQL_GET_ACUDIER_BY_ID = """query (\$email: String!) {
  getAcudierByID(input: {id: \$email}) {
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
  }
}""";

final String GRAPHQL_GET_ACUDIER_REQUESTS = """query (\$acudier: String!, \$status: String) {
  getAcudierRequests(input: {acudier: \$acudier, status: \$status}) {
    items {
      PK
      SK
      status
      acudier
      acudierName
      acudierPhoto
      client
      clientName
      clientPhoto
      from
      to
      startHour
      endHour
      price
      createdAt
      updatedAt  
    }
  }
}""";
