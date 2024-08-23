import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:souq_chemicals/pages/models/colors.dart';

class Loading extends StatelessWidget {
  appcolors col = appcolors();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: col.white,
      child: Center(
        child: SpinKitChasingDots(
          color: col.primarycolor,
          size: 50,
        ),
      ),
    );
  }
}
