import 'dart:convert';

import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/blocs/crypto_projects_bloc.dart';
import 'package:flutter_example/domain/project.dart';
import 'package:flutter_example/domain/stream_object.dart';
import 'package:flutter_example/features/crypto_project_details_page.dart';
import 'package:flutter_example/features/widgets/error_message_widget.dart';
import 'package:flutter_example/features/widgets/loading_indicator.dart';
import 'package:flutter_example/features/widgets/projects_list_item.dart';
import 'package:flutter_example/navigation/app_navigator.dart';
import 'package:flutter_example/navigation/app_routes.dart';

class CryptoProjectsPage extends StatefulWidget {
  const CryptoProjectsPage({Key? key}) : super(key: key);

  @override
  State<CryptoProjectsPage> createState() => _CryptoProjectsPageState();
}

class _CryptoProjectsPageState extends State<CryptoProjectsPage> with BeamerMixin {
  final CryptoProjectsBloc _block = CryptoProjectsBloc();

  @override
  void initState() {
    super.initState();
    _block.fetchCryptoProjects();
  }

  @override
  void dispose() {
    _block.dispose();
    super.dispose();
  }

  Widget _projectsList(List<Project> projects) {
    return ListView.separated(
      itemCount: projects.length,
      padding: const EdgeInsets.only(top: 16.0),
      separatorBuilder: (context, index) {
        return const Divider(
          thickness: 0.5,
          height: 8,
          color: Colors.black12,
        );
      },
      itemBuilder: (context, index) {
        final project = projects[index];
        return ProjectListItem(
          project: project,
          onPressed: (project) => _clickedProject(project),
          key: Key(
            project.name,
          ),
        );
      },
    );
  }

  void _clickedProject(Project project) {
    JsonEncoder encoder = const JsonEncoder();
    final String data = encoder.convert(project.toJson());
    beamTo(AppRoutes.projectDetails, payload: {"data":data});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crypto projects"),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return StreamBuilder<StreamListObject<Project>>(
      stream: _block.projectsStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const PlatformLoadingIndicator();
        final StreamListObject<Project> data = snapshot.requireData;
        switch (data.state) {
          case StreamObjectState.error:
            return ErrorMessageWidget(
              key: const Key("error_message_jey"),
              errorMessage: data.errorMessage,
              onPressed: () {
                _retry();
              },
            );
          case StreamObjectState.loading:
            return const PlatformLoadingIndicator();
          case StreamObjectState.success:
            return SafeArea(
              child: _projectsList(
                data.payload,
              ),
            );
        }
      },
    );
  }

  void _retry() {
    _block.retry();
  }
}
