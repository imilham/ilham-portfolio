import '../../models/portfolio_items.dart';

abstract class IProjectRepository {
  Future<List<Project>> getProjects();
  Future<Project?> getProjectById(String id);
}

class InMemoryProjectRepository implements IProjectRepository {
  final List<Project> _projects;

  InMemoryProjectRepository(this._projects);

  @override
  Future<List<Project>> getProjects() async => List.unmodifiable(_projects);

  @override
  Future<Project?> getProjectById(String id) async {
    try {
      return _projects.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}
