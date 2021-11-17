import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/blocs/crypto_projects_bloc.dart';
import 'package:flutter_example/domain/project.dart';
import 'package:flutter_example/domain/stream_object.dart';
import 'package:flutter_example/features/crypto_project_details_page.dart';
import 'package:flutter_example/features/widgets/loading_indicator.dart';
import 'package:flutter_example/features/widgets/projects_list_item.dart';

class CryptoProjectsPage extends StatefulWidget {
  const CryptoProjectsPage({Key? key}) : super(key: key);

  @override
  State<CryptoProjectsPage> createState() => _CryptoProjectsPageState();
}

class _CryptoProjectsPageState extends State<CryptoProjectsPage> {
  final CryptoProjectsBloc _block = CryptoProjectsBloc();
  TextEditingController editingController = TextEditingController();
  List<Project> filteredProjects = [];
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
          onPressed: _clickedProject,
          key: Key(
            project.name,
          ),
        );
      },
    );
  }

  void _clickedProject(Project project) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return CryptoProjectDetailsPage(
            key: const Key("crypto_projects_details_page"),
            project: project,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,borderRadius: BorderRadius.circular(5)
          ),
          child: Center(
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search,),
                hintText: 'Search...',

              ),
          onChanged: (value){
            setState(() {
            _block.searchProjects(value.toLowerCase());
            });
          },
              controller: editingController,
            ),
          ),
        )
      ),
      body: StreamBuilder<StreamListObject<Project>>(
        stream: _block.projectsStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const PlatformLoadingIndicator();
          final data = snapshot.requireData;
          switch (data.state) {
            case StreamObjectState.error:
              return Center(
                child: Text(data.errorMessage),
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
      ),
    );
  }


}


