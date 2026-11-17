import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import '../data/portfolio_data.dart';
import '../components/navigation.dart';
import '../components/footer.dart';

class BlogPostPage extends StatelessComponent {
  final String slug;

  const BlogPostPage({required this.slug, super.key});

  @override
  Component build(BuildContext context) {
    final post = defaultSiteData.blog.cast<dynamic>().firstWhere(
          (item) => item.slug == slug,
          orElse: () => null,
        );

    if (post == null) {
      return div(classes: 'min-h-screen bg-[#0A0A0C] text-[#F4F4F6] flex flex-col justify-between', [
        const Navigation(),
        main_(classes: 'pt-32 pb-24 px-6 text-center space-y-6', [
          h1(classes: 'text-4xl font-bold text-white', [text('Article Not Found')]),
          p(classes: 'text-[#8A8A93]', [text('The requested blog post does not exist.')]),
          Link(
            to: '/blog',
            classes: 'inline-block px-4 py-2 rounded-lg bg-[#AB4AFF] text-white font-medium',
            child: text('← Back to Blog'),
          ),
        ]),
        const Footer(),
      ]);
    }

    return div(classes: 'min-h-screen bg-[#0A0A0C] text-[#F4F4F6] flex flex-col justify-between', [
      div([
        const Navigation(),
        article(classes: 'pt-32 pb-24 px-6 max-w-4xl mx-auto space-y-10 w-full', [
          // Back link
          Link(
            to: '/blog',
            classes: 'inline-flex items-center gap-2 text-sm text-[#AB4AFF] hover:underline',
            child: text('← Back to all articles'),
          ),

          // Header
          div(classes: 'space-y-4 border-b border-[#1A1A22] pb-8', [
            div(classes: 'flex flex-wrap items-center gap-3 text-xs text-[#8A8A93]', [
              span([text(post.publishedAt)]),
              span([text('•')]),
              for (var tag in post.tags)
                span(
                  classes: 'px-2.5 py-0.5 rounded-full bg-[#1A1A22] text-[#C4C4CC] border border-[#2A2A36]',
                  [text(tag)],
                ),
            ]),
            h1(classes: 'text-3xl sm:text-5xl font-extrabold text-white leading-tight', [
              text(post.title),
            ]),
            p(classes: 'text-lg text-[#8A8A93] italic', [
              text(post.excerpt),
            ]),
          ]),

          // Cover Image
          if (post.coverImage.isNotEmpty)
            div(classes: 'rounded-2xl overflow-hidden border border-[#1A1A22] shadow-2xl', [
              img(
                src: post.coverImage,
                alt: post.title,
                classes: 'w-full h-auto max-h-[480px] object-cover',
              ),
            ]),

          // Article Body
          div(classes: 'prose prose-invert max-w-none text-base sm:text-lg text-[#C4C4CC] leading-relaxed space-y-6', [
            for (var paragraph in post.content.split('\n\n'))
              if (paragraph.trim().startsWith('# '))
                h2(classes: 'text-2xl sm:text-3xl font-bold text-white pt-6 border-b border-[#1A1A22] pb-2', [
                  text(paragraph.replaceFirst('# ', '').trim()),
                ])
              else if (paragraph.trim().startsWith('## '))
                h3(classes: 'text-xl sm:text-2xl font-bold text-white pt-4', [
                  text(paragraph.replaceFirst('## ', '').trim()),
                ])
              else if (paragraph.trim().startsWith('```'))
                pre(classes: 'p-4 rounded-xl bg-[#121216] border border-[#2A2A36] text-xs sm:text-sm font-mono overflow-x-auto text-emerald-400', [
                  code([text(paragraph.replaceAll('```', '').trim())]),
                ])
              else
                p(classes: 'text-[#C4C4CC]', [text(paragraph.trim())]),
          ]),
        ]),
      ]),
      const Footer(),
    ]);
  }
}
