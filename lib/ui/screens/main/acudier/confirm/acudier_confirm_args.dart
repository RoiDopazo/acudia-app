import 'package:acudia/core/entity/hospital_entity.dart';
import 'package:acudia/core/entity/profile_entity.dart';

class AcudierConfirmArguments {
  final Profile acudier;
  final Hospital hospital;

  AcudierConfirmArguments({
    this.acudier,
    this.hospital,
  });
}
