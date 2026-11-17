import '../repositories/project_repository.dart';
import '../repositories/blog_repository.dart';
import '../../models/portfolio_items.dart';

class GetFeaturedProjectsUseCase {
  final IProjectRepository repository;
  GetFeaturedProjectsUseCase(this.repository);

  Future<List<Project>> execute() async {
    final all = await repository.getProjects();
    final featured = all.where((p) => p.featured).toList();
    return featured.isNotEmpty ? featured : all;
  }
}

class GetBlogPostsUseCase {
  final IBlogRepository repository;
  GetBlogPostsUseCase(this.repository);

  Future<List<BlogPost>> execute() async {
    return await repository.getBlogPosts();
  }
}

class GetBlogPostBySlugUseCase {
  final IBlogRepository repository;
  GetBlogPostBySlugUseCase(this.repository);

  Future<BlogPost?> execute(String slug) async {
    return await repository.getPostBySlug(slug);
  }
}
