import '../../models/portfolio_items.dart';

abstract class IBlogRepository {
  Future<List<BlogPost>> getBlogPosts();
  Future<BlogPost?> getPostBySlug(String slug);
}

class InMemoryBlogRepository implements IBlogRepository {
  final List<BlogPost> _posts;

  InMemoryBlogRepository(this._posts);

  @override
  Future<List<BlogPost>> getBlogPosts() async {
    return _posts.where((p) => p.published).toList();
  }

  @override
  Future<BlogPost?> getPostBySlug(String slug) async {
    try {
      return _posts.firstWhere((p) => p.slug == slug && p.published);
    } catch (_) {
      return null;
    }
  }
}
