import 'package:flutter/material.dart';
import 'package:flutter_example/domain/project.dart';

class ProjectListItem extends StatelessWidget {
  final Project project;
  final Function(Project)? onPressed;

  const ProjectListItem({
    Key? key,
    required this.project,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed != null ? () => onPressed?.call(project) : null,
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
  }
}
