import 'package:acudia/core/entity/assignment_entity.dart';
import 'package:acudia/core/entity/comment_entity.dart';
import 'package:acudia/core/entity/hospital_entity.dart';
import 'package:acudia/core/entity/profile_entity.dart';

class AcudierDetailsArguments {
  final Profile acudier;
  final Hospital hospital;
  final List<Assignment> assignments;
  final List<Comment> comments;

  AcudierDetailsArguments({this.acudier, this.hospital, this.assignments, this.comments});
}
