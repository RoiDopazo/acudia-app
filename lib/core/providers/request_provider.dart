import 'package:flutter/material.dart';

class RequestProvider with ChangeNotifier {
  double rating = 0.0;
  String comment;
  bool hasChange = false;

  setRating(double ratingParam) {
    this.rating = ratingParam;
    this.hasChange = true;
    notifyListeners();
  }

  setComment(String commentParam) {
    this.comment = commentParam;
  }

  reset() {
    rating = 0.0;
    hasChange = false;
    comment = null;
    notifyListeners();
  }
}
