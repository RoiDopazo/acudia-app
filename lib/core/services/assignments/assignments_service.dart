// ignore_for_file: non_constant_identifier_names

final String GRAPHQL_ADD_ASSIGNMENT_MUTATION = r"""
  mutation addAssignment ($hospId: String!, $hospName: String, $hospProvince: String, $email: String, $itemList: [CreateAssignmentItemInput]) {
  addAssignment(input: {hospId: $hospId, hospName: $hospName, hospProvince: $hospProvince, email: $email, itemList: $itemList} ) {
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
