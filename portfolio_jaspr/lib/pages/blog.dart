import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import '../data/portfolio_data.dart';
import '../components/ambient_background.dart';
import '../components/navigation.dart';
import '../components/footer.dart';

class Blog extends StatelessComponent {
  const Blog({super.key});

  @override
  Component build(BuildContext context) {
    final posts = defaultSiteData.blog.where((p) => p.published).toList();

    return div(
      classes:
          'min-h-screen bg-[#0A0A0C] text-[#F4F4F6] flex flex-col justify-between relative',
      [
        const AmbientBackground(),
        div(
          classes:
              'relative z-10 flex-1 flex flex-col justify-between min-h-screen',
          [
            div([
              const Navigation(),
              main_(
                classes:
                    'pt-32 pb-24 px-6 max-w-6xl mx-auto space-y-12 w-full',
                [
                  // Header
                  div(classes: 'space-y-4 max-w-2xl', [
                    span(
                      classes:
                          'text-xs font-semibold text-[#AB4AFF] uppercase tracking-wider',
                      [text('Engineering Thoughts & Case Studies')],
                    ),
                    h1(
                      classes:
                          'text-4xl sm:text-6xl font-extrabold text-white',
                      [
                        text('Articles & '),
                        span(classes: 'text-[#AB4AFF]', [text('Insights')]),
                      ],
                    ),
                    p(classes: 'text-base sm:text-lg text-[#8A8A93]', [
                      text(
                        'Deep dives into Flutter internals, full-stack Dart architecture, and modern cross-platform engineering.',
                      ),
                    ]),
                  ]),

                  // Posts List
                  div(classes: 'grid grid-cols-1 md:grid-cols-2 gap-8', [
                    for (var post in posts)
                      div(
                        classes:
                            'flex flex-col rounded-2xl bg-[#121216]/80 backdrop-blur-md border border-[#1A1A22] overflow-hidden hover:border-[#AB4AFF]/50 transition-all shadow-xl group',
                        [
                          if (post.coverImage.isNotEmpty)
                            div(
                              classes:
                                  'h-48 w-full overflow-hidden bg-[#1A1A22]',
                              [
                                img(
                                  src: post.coverImage,
                                  alt: post.title,
                                  classes:
                                      'w-full h-full object-cover group-hover:scale-105 transition-transform duration-500',
                                ),
                              ],
                            ),
                          div(
                            classes:
                                'p-6 sm:p-8 flex-1 flex flex-col justify-between space-y-6',
                            [
                              div(classes: 'space-y-3', [
                                div(
                                  classes:
                                      'flex items-center gap-3 text-xs text-[#8A8A93]',
                                  [
                                    span([text(post.publishedAt)]),
                                    span([text('•')]),
                                    span(
                                      classes:
                                          'text-[#AB4AFF] font-medium',
                                      [
                                        text(post.tags.isNotEmpty
                                            ? post.tags.first
                                            : 'Article')
                                      ],
                                    ),
                                  ],
                                ),
                                h2(
                                  classes:
                                      'text-xl font-bold text-white group-hover:text-[#AB4AFF] transition-colors',
                                  [text(post.title)],
                                ),
                                p(
                                  classes:
                                      'text-sm text-[#8A8A93] leading-relaxed line-clamp-3',
                                  [text(post.excerpt)],
                                ),
                              ]),
                              div(
                                classes: 'pt-4 border-t border-[#1A1A22]',
                                [
                                  Link(
                                    to: '/blog/${post.slug}',
                                    classes:
                                        'inline-flex items-center gap-2 text-sm font-semibold text-[#AB4AFF] hover:underline',
                                    child: text('Read full story →'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                  ]),
                ],
              ),
            ]),
            const Footer(),
          ],
        ),
      ],
    );
  }
}
