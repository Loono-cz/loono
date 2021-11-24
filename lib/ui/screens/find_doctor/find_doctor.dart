import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/find_doctor/map_preview.dart';

class FindDoctorScreen extends StatelessWidget {
  const FindDoctorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: MapPreview(),
      ),
    );
  }
}
