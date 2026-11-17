import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import '../models/portfolio_items.dart';
import '../core/utils/drive_utils.dart';

class ProjectsSection extends StatelessComponent {
  final List<Project> projects;

  const ProjectsSection({required this.projects, super.key});

  @override
  Component build(BuildContext context) {
    final displayProjects = projects.where((p) => p.featured).isNotEmpty
        ? projects.where((p) => p.featured).toList()
        : projects;

    return section(
      id: 'projects',
      classes: 'py-24 px-6 bg-transparent border-t border-[#1A1A22]/60',
      [
        div(classes: 'max-w-7xl mx-auto space-y-16', [
          // Header
          div(classes: 'space-y-3', [
            span(
              classes:
                  'text-xs font-semibold text-[#AB4AFF] uppercase tracking-wider',
              [text('Portfolio Showcase')],
            ),
            h2(
              classes:
                  'text-3xl sm:text-5xl font-bold tracking-tight text-white',
              [
                text('Featured '),
                span(classes: 'text-[#AB4AFF]', [text('Projects')]),
              ],
            ),
            p(
              classes: 'text-base sm:text-lg text-[#8A8A93] max-w-2xl',
              [
                text(
                  'A curated collection of mobile applications, web architectures, and open-source contributions.',
                ),
              ],
            ),
          ]),

          // Projects Grid
          div(classes: 'grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8', [
            for (var project in displayProjects) _projectCard(project),
          ]),
        ]),
      ],
    );
  }

  Component _projectCard(Project project) {
    return div(
      classes:
          'flex flex-col rounded-2xl bg-[#121216] border border-[#1A1A22] overflow-hidden hover:border-[#AB4AFF]/50 transition-all duration-300 shadow-xl group',
      [
        // Image
        div(classes: 'relative h-48 w-full overflow-hidden bg-[#1A1A22]', [
          img(
            src: getDriveViewUrl(project.image, width: 700),
            alt: project.title,
            classes:
                'w-full h-full object-cover group-hover:scale-105 transition-transform duration-500',
            attributes: {
              'loading': 'lazy',
              'decoding': 'async',
              'referrerpolicy': 'no-referrer',
            },
          ),
          if (project.featured)
            div(
              classes:
                  'absolute top-3 right-3 px-2.5 py-1 rounded-full text-xs font-semibold bg-[#AB4AFF] text-white shadow-md',
              [text('Featured')],
            ),
        ]),

        // Content
        div(classes: 'p-6 flex-1 flex flex-col justify-between space-y-6', [
          div(classes: 'space-y-3', [
            h3(
              classes:
                  'text-xl font-bold text-white group-hover:text-[#AB4AFF] transition-colors',
              [text(project.title)],
            ),
            p(
              classes: 'text-sm text-[#8A8A93] leading-relaxed line-clamp-3',
              [text(project.description)],
            ),
            // Tags
            div(classes: 'flex flex-wrap gap-1.5 pt-2', [
              for (var tag in project.tags)
                span(
                  classes:
                      'px-2.5 py-1 rounded-md text-xs font-medium bg-[#1A1A22] text-[#C4C4CC]',
                  [text(tag)],
                ),
            ]),
          ]),

          // Actions
          div(classes: 'flex items-center gap-3 pt-4 border-t border-[#1A1A22]', [
            if (project.liveUrl.isNotEmpty && project.liveUrl != '#')
              a(
                href: project.liveUrl,
                target: Target.blank,
                classes:
                    'inline-flex items-center gap-1.5 text-xs font-semibold text-white px-3 py-2 rounded-lg bg-[#AB4AFF] hover:bg-[#9732f0] transition-colors',
                [text('View Project ↗')],
              ),
            if (project.githubUrl.isNotEmpty && project.githubUrl != '#')
              a(
                href: project.githubUrl,
                target: Target.blank,
                classes:
                    'inline-flex items-center gap-1.5 text-xs font-semibold text-[#C4C4CC] px-3 py-2 rounded-lg bg-[#1A1A22] hover:bg-[#2A2A36] transition-colors',
                [text('Source Code')],
              ),
          ]),
        ]),
      ],
    );
  }
}
