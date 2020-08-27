// import 'package:latlong/latlong.dart';

import 'package:geolocator/geolocator.dart';

capitalize(String text) {
  String lcText = text != null ? text.toLowerCase() : '';
  return lcText.splitMapJoin(new RegExp(r"(?:^|\s(?!de|del|y\s)|\/|-)\S"),
      onMatch: (m) => "${m.group(0).toUpperCase()}");
}

// ${m.group(0)}'.substring(0, 1).toUpperCase()

class Hospital {
  final int codCNH;
  final String name;
  final String address;
  final String postalCode;
  final int phone;
  final int codMu;
  final String municipallity;
  final int codProv;
  final String province;
  final int codAuto;
  final String state;
  final int codFi;
  final String healthCarePurpose;
  final int codPat;
  final String patrimonialDependence;
  final int codFu;
  final String functionalDependence;
  final bool isPrivate;
  double distance;
  final Map<String, double> coords;

  Hospital({
    this.codCNH,
    this.name,
    this.address,
    this.postalCode,
    this.phone,
    this.codMu,
    this.municipallity,
    this.codProv,
    this.province,
    this.codAuto,
    this.state,
    this.codFi,
    this.healthCarePurpose,
    this.codPat,
    this.patrimonialDependence,
    this.codFu,
    this.functionalDependence,
    this.isPrivate,
    this.distance,
    this.coords,
  });

  setDistance(double distance) {
    this.distance = distance;
  }

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      codCNH: int.parse(json["CODCNH"]),
      name: capitalize(json["NOMBRE"]),
      address: capitalize(json["DIRECCION"]),
      postalCode: json["CODPOSTAL"],
      phone: json["TELEFONO"] != '' ? int.parse(json["TELEFONO"]) : null,
      codMu: int.parse(json["CODMU"]),
      municipallity: capitalize(json["MUNICIPIOS"]),
      codProv: int.parse(json["CODPROV"]),
      province: capitalize(json["PROVINCIAS"]),
      codAuto: int.parse(json["CODAUTO"]),
      state: capitalize(json["COMUNIDADES"]),
      codFi: int.parse(json["CODFI"]),
      healthCarePurpose: capitalize(json["FINALIDAD_ASISITENCIAL"]),
      codPat: int.parse(json["CODPAT"]),
      patrimonialDependence: capitalize(json["DEPENDENCIA_PATRIMONIAL"]),
      codFu: int.parse(json["CODFU"]),
      functionalDependence: capitalize(json["DEPENDENCIA_FUNCIONAL"]),
      isPrivate: json["DEPENDENCIA_FUNCIONA"] == 'PRIVADOS',
      coords: {"lat": json["Y"], "lng": json["X"]},
      distance: 0,
    );
  }
}
