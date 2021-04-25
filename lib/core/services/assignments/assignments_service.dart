// ignore_for_file: non_constant_identifier_names

final String GRAPHQL_ADD_ASSIGNMENT_MUTATION = """
  mutation addAssignment (\$hospId: String!, \$hospName: String, \$hospProvince: String, \$from: AWSDate, \$to: AWSDate, \$startHour: Float, \$endHour: Float, \$fare: Float, \$days: [Boolean]) {
  addAssignment(input: {hospId: \$hospId, data: {hospName: \$hospName, hospProvince: \$hospProvince, from: \$from, to: \$to, startHour: \$startHour, endHour: \$endHour, fare: \$fare, days: \$days}} ) {
    PK
    SK
    hospName
    hospProvince
    from
    to
    startHour
    endHour
    fare
    createdAt
    updatedAt
  }
}""";

final String GRAPHQL_UPDATE_ASSIGNMENT_MUTATION = """
  mutation updateAssignment (\$hospId: String!, \$assignmentId: String!, \$hospName: String, \$hospProvince: String, \$from: AWSDate, \$to: AWSDate, \$startHour: Float, \$endHour: Float, \$fare: Float, \$days: [Boolean]) {
  updateAssignment(input: {hospId: \$hospId, assignmentId: \$assignmentId, data: {hospName: \$hospName, hospProvince: \$hospProvince, from: \$from, to: \$to, startHour: \$startHour, endHour: \$endHour, fare: \$fare, days: \$days} } )
}""";

final String GRAPHQL_GET_MY_ASSIGNMENTS_QUERY = """
  query getMyAssignments() {
    getMyAssignments {
      items {
        PK
        SK
        createdAt
        hospId
        hospName
        hospProvince
        from
        to
        startHour
        endHour
        fare
        days
      }
    }
  }""";

final String GRAPHQL_REMOVE_ASSIGNMENTS_MUTATION = """
  mutation removeAssignment(\$hospId: String!, \$assignmentId: String!) {
  removeAssignment(input: {hospId: \$hospId, assignmentId: \$assignmentId }) 
}""";

final String GRAPHQL_SEARCH_ASSIGNMENTS_QUERY = """
 query searchAssignments(\$hospId: String!, \$from: AWSDate, \$to: AWSDate, \$startHour: Float, \$endHour: Float, \$minFare: Float, \$maxFare: Float) {
  searchAssignments(input: {hospId: \$hospId, query: { from: \$from, to: \$to, startHour: \$startHour, endHour: \$endHour, minFare: \$minFare, maxFare: \$maxFare } }) {
    items {
      acudier {
        profile {
          PK
          SK
          name
          secondName
          email
          genre
          birthDate
          jobsCompleted
          popularity
          photoUrl
          createdAt
          updatedAt
        }
        comments {
          author
          comment
          date
          rating
        }      
      }
      assignment {
        from
        to
        startHour
        endHour
        fare
      }
    }
  }
}""";
