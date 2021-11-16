import 'dart:convert';

import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/domain/project.dart';
import 'package:flutter_example/features/crypto_project_details_page.dart';
import 'package:flutter_example/features/crypto_projects_page.dart';
import 'package:flutter_example/navigation/app_navigator.dart';
import 'package:flutter_example/theme/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final routerDelegate = BeamerDelegate(
    locationBuilder: SimpleLocationBuilder(
      routes: {
        // Return either Widgets or BeamPages if more customization is needed
        '/': (context, state) => const CryptoProjectsPage(),
        '/project/:data': (context, state) {
          const JsonDecoder decoder = JsonDecoder();
          final project = Project.fromJson(json: decoder.convert(state.data["data"]));
          return BeamPage(
            key: ValueKey('book-${project.name}'),
            title: 'A Book ${project.name}',
            popToNamed: '/',
            type: BeamPageType.cupertino,
            child: CryptoProjectDetailsPage(
              project: project,
            ),
          );
        }
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter example',
      theme: AppTheme.buildTheme(),
      routeInformationParser: BeamerParser(),
      routerDelegate: routerDelegate,
    );
  }
}
