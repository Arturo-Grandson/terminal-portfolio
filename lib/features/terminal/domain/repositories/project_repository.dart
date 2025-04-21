import '../models/directory.dart';

abstract class ProjectRepository {
  Future<Directory> getRootDirectory();
  Future<Directory> getDirectory(String path);
}
