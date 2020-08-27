import 'package:acudia/core/providers/hospital_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HospitalAssignmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HospitalProvider>(
        builder: (context, hospProvider, child) => Scaffold(
            appBar: AppBar(title: Text('hola')),
            body: Container(child: Center(child: Text('hola')))));
  }
}
