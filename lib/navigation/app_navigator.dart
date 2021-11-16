import 'dart:convert';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
mixin BeamerMixin<T extends StatefulWidget> on State<T> {
  JsonEncoder encoder = const JsonEncoder();

  void beamTo(String route, {Map<String, dynamic>? payload}) {
    Beamer.of(context).beamToNamed(route, data: payload);
  }
}