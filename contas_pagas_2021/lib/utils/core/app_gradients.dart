import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gradients/flutter_gradients.dart';

class AppGradients {
  static final linear = LinearGradient(colors: [
    Color(0xFF57B6E5),
    Color.fromRGBO(130, 87, 229, 0.695),
  ], stops: [
    0.0,
    0.695
  ], transform: GradientRotation(2.13959913 * pi));

  static final nuvem = FlutterGradients.landingAircraft(
    type: GradientType.sweep,
    center: Alignment.center,
    radius: 0.5,
  );

  static final phoenix = FlutterGradients.phoenixStart(
    type: GradientType.sweep,
    center: Alignment.center,
    radius: 0.5,
  );
}
