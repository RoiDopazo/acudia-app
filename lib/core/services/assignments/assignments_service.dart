// ignore_for_file: non_constant_identifier_names

final String GRAPHQL_ADD_ASSIGNMENT_MUTATION = """
  mutation addAssignment (\$hospId: String!, \$hospName: String, \$hospProvince: String, \$email: String, \$itemList: [CreateAssignmentItemInput]) {
  addAssignment(input: {hospId: \$hospId, hospName: \$hospName, hospProvince: \$hospProvince, email: \$email, itemList: \$itemList} ) {
    PK
    SK
    hospName
    hospProvince
    itemList {
      from
      to
      startHour
      endHour
    }
    createdAt
  }
}""";

final String GRAPHQL_UPDATE_ASSIGNMENT_MUTATION = """
  mutation updateAssignment (\$hospId: String!, \$itemList: [CreateAssignmentItemInput]) {
  updateAssignment(input: {hospId: \$hospId, itemList: \$itemList} )
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
        itemList {
          from
          to
          startHour
          endHour
          fare
          days
        }
      }
    }
  }""";
