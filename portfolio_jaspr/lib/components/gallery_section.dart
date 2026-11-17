import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import '../models/portfolio_items.dart';
import '../core/utils/drive_utils.dart';

class GallerySection extends StatelessComponent {
  final List<GalleryPhoto> gallery;

  const GallerySection({required this.gallery, super.key});

  @override
  Component build(BuildContext context) {
    if (gallery.isEmpty) {
      return div([]);
    }

    return section(
      id: 'gallery',
      classes: 'py-24 px-6 bg-transparent border-t border-[#1A1A22]/60',
      [
        div(classes: 'max-w-7xl mx-auto space-y-16', [
          // Header
          div(classes: 'space-y-3', [
            span(
              classes:
                  'text-xs font-semibold text-[#AB4AFF] uppercase tracking-wider',
              [Component.text('Moments & Visuals')],
            ),
            h2(
              classes:
                  'text-3xl sm:text-5xl font-bold tracking-tight text-white',
              [
                Component.text('Photo '),
                span(classes: 'text-[#AB4AFF]', [Component.text('Gallery')]),
              ],
            ),
          ]),

          // Grid
          div(classes: 'grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6', [
            for (var photo in gallery)
              div(
                classes:
                    'group relative rounded-2xl overflow-hidden bg-[#121216] border border-[#1A1A22] aspect-[4/3] shadow-lg',
                [
                  img(
                    src: getDriveViewUrl(photo.url, width: 600),
                    alt: photo.caption,
                    classes:
                        'w-full h-full object-cover group-hover:scale-105 transition-transform duration-500',
                    attributes: {
                      'loading': 'lazy',
                      'decoding': 'async',
                      'referrerpolicy': 'no-referrer',
                    },
                  ),
                  div(
                    classes:
                        'absolute inset-0 bg-gradient-to-t from-black/80 via-black/20 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex flex-col justify-end p-6',
                    [
                      span(
                        classes:
                            'text-xs font-bold text-[#AB4AFF] uppercase tracking-wider',
                        [Component.text(photo.category)],
                      ),
                      h4(
                        classes: 'text-base font-semibold text-white',
                        [Component.text(photo.caption)],
                      ),
                    ],
                  ),
                ],
              ),
          ]),
        ]),
      ],
    );
  }
}
