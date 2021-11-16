import 'package:flutter/material.dart';
import 'package:flutter_example/domain/project.dart';

class CryptoProjectDetailsPage extends StatelessWidget {
  final Project project;

  const CryptoProjectDetailsPage({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.network(project.banner),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            project.name,
            style: const TextStyle(fontSize: 18),
          ),
          const Divider(
            height: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              project.description,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
