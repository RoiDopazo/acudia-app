class Comment {
  final String author;
  final String comment;
  final DateTime date;
  final double rating;

  Comment({this.author, this.comment, this.date, this.rating});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      author: json['author'].trim(),
      date: DateTime.parse(json["date"]),
      comment: json['comment'],
      rating: json['rating'],
    );
  }

  static List<Comment> fromJsonList(List<dynamic> jsonList) {
    List<Comment> commentList = [];

    jsonList.forEach((element) {
      commentList.add(Comment.fromJson(element));
    });

    return commentList;
  }
}
