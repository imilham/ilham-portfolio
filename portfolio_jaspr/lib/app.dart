import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'data/portfolio_data.dart';
import 'pages/home.dart';
import 'pages/blog.dart';
import 'pages/blog_post.dart';

class App extends StatelessComponent {
  const App({super.key});

  @override
  Component build(BuildContext context) {
    return div(
      classes:
          'min-h-screen bg-[#0A0A0C] text-[#F4F4F6] font-sans antialiased selection:bg-[#AB4AFF] selection:text-white',
      [
        Router(routes: [
          Route(
            path: '/',
            title:
                'Mohamed Ilham | Senior Mobile Engineer & Flutter Specialist',
            builder: (context, state) => const Home(),
          ),
          Route(
            path: '/blog',
            title: 'Blog | Mohamed Ilham',
            builder: (context, state) => const Blog(),
          ),
          // Statically pre-rendered routes for each blog post in SSG mode
          for (var post in defaultSiteData.blog)
            Route(
              path: '/blog/${post.slug}',
              title: '${post.title} | Mohamed Ilham',
              builder: (context, state) => BlogPostPage(slug: post.slug),
            ),
        ]),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [];
}
