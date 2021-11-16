import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/features/crypto_projects_page.dart';
import 'package:flutter_example/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter example',
      theme: AppTheme.buildTheme(),
      home: const CryptoProjectsPage(),
    );
  }
}