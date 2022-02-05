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
    jobsCompleted
    popularity
    updatedAt
    deletedAt
  }
}""";

final String GRAPHQL_GET_PROFILE_STATS_QUERY = """query (\$role: String!) {
  getProfileStats(input: {role: \$role}) {
    acudier {
      name
      photoUrl
    }
    hosp {
      name
    }
    jobsCompleted
  }
}""";

final String GRAPHQL_GET_PROFILE_COMMENTS_QUERY = """query (\$role: String!) {
  getComments(input: {role: \$role}) {
    items {
      author
      date
      comment
      rating
    }
  }
}""";
