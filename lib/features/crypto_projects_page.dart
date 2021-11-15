import 'package:flutter/material.dart';
import 'package:flutter_example/blocs/crypto_projects_bloc.dart';
import 'package:flutter_example/domain/project.dart';

class CryptoProjectsPage extends StatefulWidget {
  const CryptoProjectsPage({Key? key}) : super(key: key);

  @override
  State<CryptoProjectsPage> createState() => _CryptoProjectsPageState();
}

class _CryptoProjectsPageState extends State<CryptoProjectsPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crypto projects"),
      ),
      body: StreamBuilder<List<Project>>(
        stream: _block.projectsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            final errorMsg = snapshot.error as String;
            return Center(
              child: Text(errorMsg),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List<Project> projects = snapshot.data ?? [];

          if(projects.isEmpty) {
            return const Center(
              child: Text("No projects available"),
            );
          }

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
              return ListTile(
                leading: SizedBox(
                  height: 32.0,
                  width: 32.0,
                  child: Image.network(project.thumbnail),
                ),
                title: Text(project.name),
                subtitle: Text(
                  project.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
