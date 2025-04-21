import 'project.dart';

class Directory {
  final String name;
  final String path;
  final List<Project> projects;
  final List<Directory> subdirectories;

  const Directory({
    required this.name,
    required this.path,
    required this.projects,
    required this.subdirectories,
  });

  Directory copyWith({
    String? name,
    String? path,
    List<Project>? projects,
    List<Directory>? subdirectories,
  }) {
    return Directory(
      name: name ?? this.name,
      path: path ?? this.path,
      projects: projects ?? this.projects,
      subdirectories: subdirectories ?? this.subdirectories,
    );
  }
}
