import '../../domain/models/directory.dart';
import '../../domain/models/project.dart';
import '../../domain/repositories/project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  @override
  Future<Directory> getRootDirectory() async {
    // TODO: Implementar la lógica para obtener el directorio raíz
    return Directory(
      name: 'root',
      path: '/',
      projects: [
        Project(
          name: 'Proyecto 1',
          description: 'Descripción del proyecto 1',
          technologies: ['Flutter', 'Dart'],
          url: 'https://github.com/usuario/proyecto1',
        ),
        Project(
          name: 'Proyecto 2',
          description: 'Descripción del proyecto 2',
          technologies: ['React', 'TypeScript'],
          url: 'https://github.com/usuario/proyecto2',
        ),
      ],
      subdirectories: [],
    );
  }

  @override
  Future<Directory> getDirectory(String path) async {
    // TODO: Implementar la lógica para obtener un directorio específico
    return Directory(name: path, path: path, projects: [], subdirectories: []);
  }
}
