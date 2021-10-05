// ignore_for_file: non_constant_identifier_names

final String GRAPHQL_CREATE_REQUEST =
    """mutation (\$acudier: String!, \$acudierName: String!, \$acudierPhoto: String, \$clientName: String!, \$clientPhoto: String, \$hospId: String!, \$hospName: String!, \$from: AWSDate!, \$to: AWSDate!, \$startHour: Float!, \$endHour: Float!, \$price: Float!) {
  createRequest(input: {acudier: \$acudier, acudierName: \$acudierName, acudierPhoto: \$acudierPhoto, clientName: \$clientName, clientPhoto: \$clientPhoto, hospId: \$hospId, hospName: \$hospName, from: \$from, to: \$to, startHour: \$startHour, endHour: \$endHour, price: \$price}) {
    PK
  }
}""";

final String GRAPHQL_GET_MY_REQUESTS = """query (\$role: String!, \$status: String, \$active: Boolean) {
  getMyRequests(input: {role: \$role, status: \$status, active: \$active }) {
    incoming {
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
        hospId
        hospName
        price
        createdAt
        updatedAt  
      }
    active {
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
        hospId
        hospName
        price
        createdAt
        updatedAt  
      }
  }
}""";
