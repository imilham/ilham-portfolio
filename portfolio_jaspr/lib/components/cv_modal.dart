import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class CvModal extends StatelessComponent {
  final String cvDownloadUrl;
  final String cvPreviewUrl;
  final String cvExternalViewUrl;

  const CvModal({
    required this.cvDownloadUrl,
    required this.cvPreviewUrl,
    required this.cvExternalViewUrl,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      id: 'cv-modal-overlay',
      classes:
          'fixed inset-0 z-[100] hidden items-center justify-center p-3 sm:p-6 bg-black/85 backdrop-blur-md transition-opacity duration-300 opacity-0',
      [
        // Modal Card Container
        div(
          id: 'cv-modal-card',
          classes:
              'relative w-full max-w-5xl h-[88vh] bg-[#0A0A0F] border border-[#2A2A38] rounded-2xl shadow-2xl flex flex-col overflow-hidden',
          attributes: {
            'style': 'box-shadow: 0 0 50px rgba(171, 74, 255, 0.2);',
          },
          [
            // Header Bar
            div(
              classes:
                  'flex items-center justify-between px-5 py-4 bg-[#101016] border-b border-[#222230]',
              [
                // Title & Badge
                div(classes: 'flex items-center gap-3', [
                  span(classes: 'text-xl', [text('📄')]),
                  div([
                    h3(
                      classes: 'text-sm sm:text-base font-bold text-white',
                      [text('Mohamed Ilham — Curriculum Vitae')],
                    ),
                    p(
                      classes: 'text-xs text-[#8A8A93]',
                      [text('PDF Document • Interactive Preview')],
                    ),
                  ]),
                ]),

                // Actions: Open in Tab, Download PDF, Close Button
                div(classes: 'flex items-center gap-2 sm:gap-3', [
                  if (cvExternalViewUrl.isNotEmpty)
                    a(
                      href: cvExternalViewUrl,
                      target: Target.blank,
                      classes:
                          'hidden sm:inline-flex items-center gap-1.5 text-xs font-semibold text-[#C4C4CC] hover:text-white px-3 py-2 rounded-lg bg-[#181822] hover:bg-[#232330] border border-[#262634] transition-colors',
                      [text('Open in Tab ↗')],
                    ),
                  if (cvDownloadUrl.isNotEmpty)
                    a(
                      href: cvDownloadUrl,
                      target: Target.blank,
                      classes:
                          'inline-flex items-center gap-1.5 text-xs font-bold text-white px-4 py-2 rounded-lg bg-gradient-to-r from-[#AB4AFF] to-[#8B1FFF] hover:from-[#9732f0] hover:to-[#7812e5] shadow-lg shadow-[#AB4AFF]/25 transition-all hover:scale-[1.02]',
                      [
                        span([text('⬇')]),
                        text('Download PDF'),
                      ],
                    ),
                  button(
                    id: 'close-cv-modal-btn',
                    classes:
                        'p-2 text-[#A1A1AA] hover:text-white hover:bg-[#20202C] rounded-lg transition-colors cursor-pointer text-lg leading-none flex items-center justify-center w-9 h-9',
                    attributes: {'aria-label': 'Close modal'},
                    [text('✕')],
                  ),
                ]),
              ],
            ),

            // Modal Body with Embedded PDF Iframe
            div(
              classes: 'relative w-full flex-1 bg-[#0A0A0F] overflow-hidden',
              [
                iframe(
                  [],
                  id: 'cv-pdf-iframe',
                  src: '',
                  classes: 'w-full h-full border-0 bg-[#0A0A0F]',
                  allow: 'autoplay',
                  attributes: {
                    'data-preview-url': cvPreviewUrl,
                  },
                ),
              ],
            ),
          ],
        ),

        // Vanilla JavaScript Controller to open/close with zero framework overhead
        script(
          content: '''
(function() {
  function initCvModal() {
    var overlay = document.getElementById('cv-modal-overlay');
    var iframe = document.getElementById('cv-pdf-iframe');
    var closeBtn = document.getElementById('close-cv-modal-btn');
    var openBtn = document.getElementById('open-cv-modal-btn');

    if (!overlay || !iframe) return;

    var previewUrl = iframe.getAttribute('data-preview-url') || '';

    function openModal(e) {
      if (e) e.preventDefault();
      if (!iframe.src && previewUrl) {
        iframe.src = previewUrl;
      }
      overlay.classList.remove('hidden');
      overlay.classList.add('flex');
      setTimeout(function() {
        overlay.classList.remove('opacity-0');
        overlay.classList.add('opacity-100');
      }, 10);
      document.body.style.overflow = 'hidden';
    }

    function closeModal() {
      overlay.classList.remove('opacity-100');
      overlay.classList.add('opacity-0');
      setTimeout(function() {
        overlay.classList.remove('flex');
        overlay.classList.add('hidden');
        document.body.style.overflow = '';
      }, 300);
    }

    if (openBtn) {
      openBtn.addEventListener('click', openModal);
    }

    if (closeBtn) {
      closeBtn.addEventListener('click', closeModal);
    }

    // Close when clicking outside the card
    overlay.addEventListener('click', function(e) {
      if (e.target === overlay) {
        closeModal();
      }
    });

    // Close on Escape key
    window.addEventListener('keydown', function(e) {
      if (e.key === 'Escape' && !overlay.classList.contains('hidden')) {
        closeModal();
      }
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initCvModal);
  } else {
    initCvModal();
  }
})();
''',
        ),
      ],
    );
  }
}
