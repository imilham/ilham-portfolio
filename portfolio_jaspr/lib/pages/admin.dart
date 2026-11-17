import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../core/services/firebase_service.dart';
import '../data/portfolio_data.dart';
import '../models/education_experience.dart';
import '../models/portfolio_items.dart';
import '../models/profile.dart';
import '../models/site_data.dart';

@client
class AdminPage extends StatefulComponent {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  // Authentication State
  bool _isAuthenticated = false;
  bool _isAuthLoading = false;
  String _authError = '';
  String _idToken = '';

  // Login form inputs
  String _loginEmail = '';
  String _loginPassword = '';

  // Site Data State
  SiteData _data = defaultSiteData;
  bool _isLoadingData = false;
  String _activeTab = 'profile'; // profile, resume, education, experience, projects, gallery, blog

  // UI Toast
  String _toastMessage = '';
  bool _isSaving = false;

  // New item inputs for sub-lists
  String _newSkillInput = '';
  String _newCertInput = '';
  String _newCarouselInput = '';

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _fetchLiveFirestoreData();
    }
  }

  void _fetchLiveFirestoreData() async {
    try {
      final liveData = await FirebaseService.fetchSiteData();
      if (mounted) {
        setState(() {
          _data = liveData;
          _isLoadingData = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isLoadingData = false);
      }
    }
  }

  void _handleLogin() async {
    if (_loginEmail.trim().isEmpty || _loginPassword.isEmpty) {
      setState(() => _authError = 'Please enter both email and password.');
      return;
    }

    setState(() {
      _isAuthLoading = true;
      _authError = '';
    });

    try {
      final token = await FirebaseService.signInWithEmailAndPassword(
        _loginEmail.trim(),
        _loginPassword,
      );
      if (mounted) {
        setState(() {
          _idToken = token;
          _isAuthenticated = true;
          _isAuthLoading = false;
        });
        _showToast('Logged in successfully!');
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _authError = e.toString().replaceAll('Exception:', '').trim();
          _isAuthLoading = false;
        });
      }
    }
  }

  void _handleLogout() {
    setState(() {
      _isAuthenticated = false;
      _idToken = '';
      _loginPassword = '';
    });
  }

  void _saveAllChanges() async {
    setState(() => _isSaving = true);
    try {
      final success = await FirebaseService.saveSiteData(
        _data,
        idToken: _idToken.isNotEmpty ? _idToken : null,
      );
      if (mounted) {
        setState(() => _isSaving = false);
        if (success) {
          _showToast('All changes saved to Firestore!');
        } else {
          _showToast('Failed to save to Firestore.');
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSaving = false);
        _showToast('Error saving: $e');
      }
    }
  }

  void _showToast(String message) {
    setState(() => _toastMessage = message);
  }

  // --- Profile Helpers ---
  void _updateProfileField(Profile Function(Profile p) updater) {
    setState(() {
      _data = _data.copyWith(profile: updater(_data.profile));
    });
  }

  void _addSkill() {
    final s = _newSkillInput.trim();
    if (s.isNotEmpty && !_data.profile.skills.contains(s)) {
      _updateProfileField((p) => p.copyWith(skills: [...p.skills, s]));
      setState(() => _newSkillInput = '');
    }
  }

  void _removeSkill(String s) {
    _updateProfileField((p) => p.copyWith(skills: p.skills.where((x) => x != s).toList()));
  }

  void _addCert() {
    final c = _newCertInput.trim();
    if (c.isNotEmpty && !_data.profile.certifications.contains(c)) {
      _updateProfileField((p) => p.copyWith(certifications: [...p.certifications, c]));
      setState(() => _newCertInput = '');
    }
  }

  void _removeCert(String c) {
    _updateProfileField((p) => p.copyWith(certifications: p.certifications.where((x) => x != c).toList()));
  }

  void _addCarouselText() {
    final t = _newCarouselInput.trim();
    if (t.isNotEmpty && !_data.profile.carouselTexts.contains(t)) {
      _updateProfileField((p) => p.copyWith(carouselTexts: [...p.carouselTexts, t]));
      setState(() => _newCarouselInput = '');
    }
  }

  void _removeCarouselText(String t) {
    _updateProfileField((p) => p.copyWith(carouselTexts: p.carouselTexts.where((x) => x != t).toList()));
  }

  void _updateStat(int index, {String? value, String? label}) {
    final currentStats = List<StatItem>.from(_data.profile.stats);
    if (index >= 0 && index < currentStats.length) {
      currentStats[index] = StatItem(
        value: value ?? currentStats[index].value,
        label: label ?? currentStats[index].label,
      );
      _updateProfileField((p) => p.copyWith(stats: currentStats));
    }
  }

  // --- Education Helpers ---
  void _addEducation() {
    final newId = DateTime.now().millisecondsSinceEpoch.toString();
    final item = Education(
      id: newId,
      degree: 'New Degree / Certification',
      school: 'University or Institution',
      year: '2024 – Present',
      description: 'Program description and specialization.',
    );
    setState(() {
      _data = _data.copyWith(education: [..._data.education, item]);
    });
  }

  void _updateEducation(int index, Education Function(Education e) updater) {
    final list = List<Education>.from(_data.education);
    if (index >= 0 && index < list.length) {
      list[index] = updater(list[index]);
      setState(() => _data = _data.copyWith(education: list));
    }
  }

  void _deleteEducation(int index) {
    final list = List<Education>.from(_data.education)..removeAt(index);
    setState(() => _data = _data.copyWith(education: list));
  }

  // --- Experience Helpers ---
  void _addExperience() {
    final newId = DateTime.now().millisecondsSinceEpoch.toString();
    final item = Experience(
      id: newId,
      role: 'Senior Mobile Engineer',
      company: 'Company Name',
      period: 'Jan 2024 – Present',
      description: 'Engineered cross-platform mobile apps with Clean Architecture.',
      technologies: ['Flutter', 'Dart', 'Firebase'],
    );
    setState(() {
      _data = _data.copyWith(experience: [..._data.experience, item]);
    });
  }

  void _updateExperience(int index, Experience Function(Experience e) updater) {
    final list = List<Experience>.from(_data.experience);
    if (index >= 0 && index < list.length) {
      list[index] = updater(list[index]);
      setState(() => _data = _data.copyWith(experience: list));
    }
  }

  void _deleteExperience(int index) {
    final list = List<Experience>.from(_data.experience)..removeAt(index);
    setState(() => _data = _data.copyWith(experience: list));
  }

  // --- Project Helpers ---
  void _addProject() {
    final newId = DateTime.now().millisecondsSinceEpoch.toString();
    final item = Project(
      id: newId,
      title: 'New Project',
      description: 'High-performance mobile application.',
      tags: ['Flutter', 'Dart'],
      liveUrl: 'https://',
      githubUrl: 'https://github.com',
      image: 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=800&q=80',
      featured: true,
    );
    setState(() {
      _data = _data.copyWith(projects: [..._data.projects, item]);
    });
  }

  void _updateProject(int index, Project Function(Project p) updater) {
    final list = List<Project>.from(_data.projects);
    if (index >= 0 && index < list.length) {
      list[index] = updater(list[index]);
      setState(() => _data = _data.copyWith(projects: list));
    }
  }

  void _deleteProject(int index) {
    final list = List<Project>.from(_data.projects)..removeAt(index);
    setState(() => _data = _data.copyWith(projects: list));
  }

  // --- Gallery Helpers ---
  void _addGalleryPhoto() {
    final newId = DateTime.now().millisecondsSinceEpoch.toString();
    final item = GalleryPhoto(
      id: newId,
      url: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80',
      caption: 'Photo Caption',
      category: 'Mobile',
    );
    setState(() {
      _data = _data.copyWith(gallery: [..._data.gallery, item]);
    });
  }

  void _updateGalleryPhoto(int index, GalleryPhoto Function(GalleryPhoto g) updater) {
    final list = List<GalleryPhoto>.from(_data.gallery);
    if (index >= 0 && index < list.length) {
      list[index] = updater(list[index]);
      setState(() => _data = _data.copyWith(gallery: list));
    }
  }

  void _deleteGalleryPhoto(int index) {
    final list = List<GalleryPhoto>.from(_data.gallery)..removeAt(index);
    setState(() => _data = _data.copyWith(gallery: list));
  }

  // --- Blog Helpers ---
  void _addBlogPost() {
    final newId = DateTime.now().millisecondsSinceEpoch.toString();
    final item = BlogPost(
      id: newId,
      title: 'New Article Title',
      slug: 'new-article-title-${DateTime.now().millisecondsSinceEpoch % 1000}',
      excerpt: 'Brief overview of this technical article.',
      content: 'Full markdown or article text goes here...',
      tags: ['Flutter', 'Architecture'],
      coverImage: 'https://images.unsplash.com/photo-1633356122102-3fe601e05bd2?w=800&q=80',
      publishedAt: '2026-11-17',
      published: true,
    );
    setState(() {
      _data = _data.copyWith(blog: [..._data.blog, item]);
    });
  }

  void _updateBlogPost(int index, BlogPost Function(BlogPost b) updater) {
    final list = List<BlogPost>.from(_data.blog);
    if (index >= 0 && index < list.length) {
      list[index] = updater(list[index]);
      setState(() => _data = _data.copyWith(blog: list));
    }
  }

  void _deleteBlogPost(int index) {
    final list = List<BlogPost>.from(_data.blog)..removeAt(index);
    setState(() => _data = _data.copyWith(blog: list));
  }

  @override
  Component build(BuildContext context) {
    if (!_isAuthenticated) {
      return _buildLoginView();
    }
    return _buildDashboardView();
  }

  // =========================================================================
  // LOGIN SCREEN
  // =========================================================================
  Component _buildLoginView() {
    return div(
      classes:
          'min-h-screen bg-[#0A0A0C] flex flex-col items-center justify-center p-6 text-[#F4F4F6] relative selection:bg-[#AB4AFF] selection:text-white',
      [
        div(classes: 'w-full max-w-md', [
          // Back to portfolio link
          Link(
            to: '/',
            classes:
                'inline-flex items-center gap-2 text-[#8A8A93] hover:text-[#AB4AFF] transition-colors mb-8 text-sm font-medium',
            child: span([text('← Back to Portfolio')]),
          ),

          // Login Box
          div(
            classes:
                'bg-[#121216] border border-[#1A1A22] rounded-2xl p-8 shadow-2xl',
            [
              div(classes: 'flex flex-col items-center mb-8 text-center', [
                div(
                  classes:
                      'w-14 h-14 bg-[#1A1A22] rounded-full flex items-center justify-center mb-4 text-2xl border border-[#2A2A38]',
                  [text('🔒')],
                ),
                h1(
                  classes: 'text-2xl font-bold tracking-tight text-white',
                  [text('Admin Access')],
                ),
                p(
                  classes: 'text-xs text-[#8A8A93] mt-2 max-w-xs leading-relaxed',
                  [
                    text(
                        'Sign in with your Firebase Auth credentials to manage your portfolio, CV, projects, and articles.'),
                  ],
                ),
              ]),

              // Error banner
              if (_authError.isNotEmpty)
                div(
                  classes:
                      'p-3 mb-4 bg-red-500/10 border border-red-500/30 text-red-400 rounded-xl text-xs text-center font-medium',
                  [text(_authError)],
                ),

              // Form fields
              div(classes: 'space-y-4', [
                div([
                  label(
                    classes:
                        'block text-xs font-semibold text-[#8A8A93] mb-1.5 uppercase tracking-wider',
                    [text('Admin Email')],
                  ),
                  input<String>(
                    type: InputType.email,
                    value: _loginEmail,
                    onInput: (val) => _loginEmail = val,
                    classes:
                        'w-full px-4 py-3 bg-[#0A0A0C] border border-[#1A1A22] rounded-xl focus:border-[#AB4AFF] focus:outline-none transition-all text-sm text-[#F4F4F6]',
                    attributes: {'placeholder': 'admin@example.com'},
                  ),
                ]),
                div([
                  label(
                    classes:
                        'block text-xs font-semibold text-[#8A8A93] mb-1.5 uppercase tracking-wider',
                    [text('Password')],
                  ),
                  input<String>(
                    type: InputType.password,
                    value: _loginPassword,
                    onInput: (val) => _loginPassword = val,
                    classes:
                        'w-full px-4 py-3 bg-[#0A0A0C] border border-[#1A1A22] rounded-xl focus:border-[#AB4AFF] focus:outline-none transition-all text-sm text-[#F4F4F6]',
                    attributes: {'placeholder': '••••••••••••'},
                  ),
                ]),

                // Sign In Button
                button(
                  [
                    if (_isAuthLoading)
                      span(classes: 'animate-pulse', [text('Signing in...')])
                    else
                      text('Sign In to Dashboard →'),
                  ],
                  onClick: _handleLogin,
                  disabled: _isAuthLoading,
                  classes:
                      'w-full mt-2 py-3 rounded-xl font-bold text-sm text-white bg-gradient-to-r from-[#AB4AFF] to-[#8B1FFF] hover:from-[#9732f0] hover:to-[#7812e5] transition-all duration-200 shadow-lg shadow-[#AB4AFF]/20 cursor-pointer disabled:opacity-50',
                ),
              ]),
            ],
          ),
        ]),
      ],
    );
  }

  // =========================================================================
  // MAIN ADMIN DASHBOARD
  // =========================================================================
  Component _buildDashboardView() {
    return div(
      classes:
          'min-h-screen bg-[#0A0A0C] text-[#F4F4F6] flex flex-col selection:bg-[#AB4AFF] selection:text-white',
      [
        // Toast Notification
        if (_toastMessage.isNotEmpty)
          div(
            classes:
                'fixed bottom-6 right-6 z-[100] bg-[#AB4AFF] text-white px-5 py-3 rounded-xl shadow-2xl text-sm font-semibold flex items-center gap-3 animate-bounce',
            [
              text(_toastMessage),
              button(
                [text('✕')],
                onClick: () => setState(() => _toastMessage = ''),
                classes: 'text-xs text-white/80 hover:text-white cursor-pointer ml-2',
              ),
            ],
          ),

        // Header Bar
        header(
          classes:
              'sticky top-0 z-50 border-b border-[#1A1A22] bg-[#0A0A0C]/95 backdrop-blur-md',
          [
            div(
              classes:
                  'max-w-7xl mx-auto px-6 h-16 flex items-center justify-between',
              [
                // Left Brand
                div(classes: 'flex items-center gap-3', [
                  Link(
                    to: '/',
                    classes:
                        'flex items-center gap-1.5 text-sm font-medium text-[#8A8A93] hover:text-[#AB4AFF] transition-colors',
                    child: text('← Portfolio'),
                  ),
                  span(classes: 'text-[#2A2A38]', [text('|')]),
                  span(
                    classes: 'text-sm font-bold tracking-tight text-white flex items-center gap-1',
                    [
                      text('Admin Console'),
                      span(classes: 'text-[#AB4AFF]', [text('•')]),
                    ],
                  ),
                ]),

                // Right Actions
                div(classes: 'flex items-center gap-3', [
                  // Save Button
                  button(
                    [
                      if (_isSaving)
                        span(classes: 'animate-pulse', [text('Saving...')])
                      else
                        text('💾 Save All Changes'),
                    ],
                    onClick: _saveAllChanges,
                    disabled: _isSaving,
                    classes:
                        'px-4 py-2 rounded-xl text-xs font-bold text-white bg-gradient-to-r from-[#AB4AFF] to-[#8B1FFF] hover:from-[#9732f0] hover:to-[#7812e5] shadow-lg shadow-[#AB4AFF]/25 transition-all cursor-pointer disabled:opacity-50',
                  ),

                  // Blog Preview Link
                  Link(
                    to: '/blog',
                    classes:
                        'hidden sm:inline-flex items-center gap-1 text-xs text-[#8A8A93] hover:text-white px-3 py-2 rounded-xl border border-[#1A1A22] transition-colors',
                    child: text('Blog ↗'),
                  ),

                  // Logout Button
                  button(
                    [text('Log Out')],
                    onClick: _handleLogout,
                    classes:
                        'text-xs text-[#8A8A93] hover:text-red-400 px-3 py-2 rounded-xl border border-[#1A1A22] hover:border-red-400/50 transition-colors cursor-pointer',
                  ),
                ]),
              ],
            ),
          ],
        ),

        // Body with Sidebar & Content Area
        div(classes: 'flex flex-1 max-w-7xl mx-auto w-full', [
          // Sidebar (Desktop)
          aside(
            classes:
                'w-56 shrink-0 border-r border-[#1A1A22] py-6 px-3 hidden md:block',
            [
              nav(classes: 'flex flex-col gap-1.5', [
                _buildTabButton('profile', '👤 Profile'),
                _buildTabButton('resume', '📄 Manage CV'),
                _buildTabButton('education', '🎓 Education'),
                _buildTabButton('experience', '💼 Experience'),
                _buildTabButton('projects', '🚀 Projects'),
                _buildTabButton('gallery', '🖼️ Gallery'),
                _buildTabButton('blog', '✍️ Blog Articles'),
              ]),
            ],
          ),

          // Mobile Navigation Bar
          div(
            classes:
                'md:hidden fixed bottom-0 left-0 right-0 z-50 bg-[#0D0D14] border-t border-[#1A1A22] flex overflow-x-auto p-1',
            [
              _buildMobileTabButton('profile', 'Profile'),
              _buildMobileTabButton('resume', 'CV'),
              _buildMobileTabButton('education', 'Edu'),
              _buildMobileTabButton('experience', 'Exp'),
              _buildMobileTabButton('projects', 'Projects'),
              _buildMobileTabButton('gallery', 'Gallery'),
              _buildMobileTabButton('blog', 'Blog'),
            ],
          ),

          // Main Content
          div(classes: 'flex-1 p-6 pb-24 md:pb-8 overflow-y-auto max-w-4xl', [
            if (_isLoadingData)
              div(
                classes:
                    'p-12 text-center text-sm text-[#8A8A93] animate-pulse',
                [text('Loading Firestore data...')],
              )
            else ...[
              if (_activeTab == 'profile') _buildProfileTab(),
              if (_activeTab == 'resume') _buildResumeTab(),
              if (_activeTab == 'education') _buildEducationTab(),
              if (_activeTab == 'experience') _buildExperienceTab(),
              if (_activeTab == 'projects') _buildProjectsTab(),
              if (_activeTab == 'gallery') _buildGalleryTab(),
              if (_activeTab == 'blog') _buildBlogTab(),
            ],
          ]),
        ]),
      ],
    );
  }

  Component _buildTabButton(String tabId, String label) {
    final isActive = _activeTab == tabId;
    return button(
      [text(label)],
      onClick: () => setState(() => _activeTab = tabId),
      classes:
          'w-full text-left px-4 py-3 rounded-xl text-xs font-semibold transition-all cursor-pointer ${isActive ? "bg-[#AB4AFF]/15 text-[#AB4AFF] border border-[#AB4AFF]/30 shadow-sm" : "text-[#8A8A93] hover:text-[#F4F4F6] hover:bg-[#13131A]"}',
    );
  }

  Component _buildMobileTabButton(String tabId, String label) {
    final isActive = _activeTab == tabId;
    return button(
      [text(label)],
      onClick: () => setState(() => _activeTab = tabId),
      classes:
          'flex-1 text-center py-2 px-1 text-[11px] font-semibold transition-colors cursor-pointer shrink-0 ${isActive ? "text-[#AB4AFF]" : "text-[#8A8A93]"}',
    );
  }

  // =========================================================================
  // TAB 1: PROFILE
  // =========================================================================
  Component _buildProfileTab() {
    final profile = _data.profile;
    return div(classes: 'space-y-6', [
      _buildSectionHeader('General Profile'),

      // Primary Info Card
      _buildCard([
        div(classes: 'grid grid-cols-1 md:grid-cols-2 gap-4', [
          _buildField(
            'Full Name',
            input<String>(
              value: profile.name,
              onInput: (v) => _updateProfileField((curr) => curr.copyWith(name: v)),
              classes: _inputClass,
            ),
          ),
          _buildField(
            'Location',
            input<String>(
              value: profile.location,
              onInput: (v) => _updateProfileField((curr) => curr.copyWith(location: v)),
              classes: _inputClass,
            ),
          ),
          _buildField(
            'Email Address',
            input<String>(
              value: profile.email,
              onInput: (v) => _updateProfileField((curr) => curr.copyWith(email: v)),
              classes: _inputClass,
            ),
          ),
          _buildField(
            'Browser Tab Title',
            input<String>(
              value: profile.siteTitle,
              onInput: (v) => _updateProfileField((curr) => curr.copyWith(siteTitle: v)),
              classes: _inputClass,
            ),
          ),
          _buildField(
            'Tagline (Hero)',
            input<String>(
              value: profile.tagline,
              onInput: (v) => _updateProfileField((curr) => curr.copyWith(tagline: v)),
              classes: _inputClass,
            ),
          ),
          _buildField(
            'Hero Photo URL (Drive or CDN)',
            input<String>(
              value: profile.heroPhoto,
              onInput: (v) => _updateProfileField((curr) => curr.copyWith(heroPhoto: v)),
              classes: _inputClass,
            ),
          ),
          _buildField(
            'GitHub Profile URL',
            input<String>(
              value: profile.github,
              onInput: (v) => _updateProfileField((curr) => curr.copyWith(github: v)),
              classes: _inputClass,
            ),
          ),
          _buildField(
            'LinkedIn Profile URL',
            input<String>(
              value: profile.linkedin,
              onInput: (v) => _updateProfileField((curr) => curr.copyWith(linkedin: v)),
              classes: _inputClass,
            ),
          ),
        ]),
        div(classes: 'mt-4', [
          _buildField(
            'Professional Biography',
            textarea(
              [text(profile.bio)],
              onInput: (v) => _updateProfileField((curr) => curr.copyWith(bio: v)),
              classes: '$_inputClass min-h-[110px] resize-y',
            ),
          ),
        ]),
      ]),

      // Hero Stats Card
      _buildCard([
        _buildSubTitle('Hero Statistics (Counters)'),
        div(classes: 'grid grid-cols-1 md:grid-cols-3 gap-4 mt-3', [
          for (int i = 0; i < profile.stats.length; i++)
            div(classes: 'space-y-2 p-3 bg-[#0A0A0C] border border-[#1A1A22] rounded-xl', [
              _buildField(
                'Value (e.g. 15+)',
                input<String>(
                  value: profile.stats[i].value,
                  onInput: (v) => _updateStat(i, value: v),
                  classes: _inputClass,
                ),
              ),
              _buildField(
                'Label (e.g. Projects)',
                input<String>(
                  value: profile.stats[i].label,
                  onInput: (v) => _updateStat(i, label: v),
                  classes: _inputClass,
                ),
              ),
            ]),
        ]),
      ]),

      // Name Carousel Texts
      _buildCard([
        _buildSubTitle('Hero Rotating Text Carousel'),
        div(classes: 'flex flex-wrap gap-2 my-3', [
          for (var t in profile.carouselTexts)
            span(
              classes:
                  'inline-flex items-center gap-1.5 px-3 py-1 bg-[#1A1A22] border border-[#2A2A38] rounded-lg text-xs text-white',
              [
                text(t),
                button(
                  [text('✕')],
                  onClick: () => _removeCarouselText(t),
                  classes: 'text-xs text-[#8A8A93] hover:text-red-400 cursor-pointer ml-1',
                ),
              ],
            ),
        ]),
        div(classes: 'flex gap-2 mt-2', [
          input<String>(
            value: _newCarouselInput,
            onInput: (v) => _newCarouselInput = v,
            classes: _inputClass,
            attributes: {'placeholder': 'Add role (e.g. Mobile Architect)'},
          ),
          button(
            [text('+ Add')],
            onClick: _addCarouselText,
            classes:
                'px-4 py-2 bg-[#AB4AFF] hover:bg-[#9732f0] text-white rounded-xl text-xs font-bold cursor-pointer shrink-0',
          ),
        ]),
      ]),

      // Skills List
      _buildCard([
        _buildSubTitle('Technical Skills Chips'),
        div(classes: 'flex flex-wrap gap-2 my-3', [
          for (var s in profile.skills)
            span(
              classes:
                  'inline-flex items-center gap-1.5 px-3 py-1 bg-[#AB4AFF]/10 border border-[#AB4AFF]/20 text-[#AB4AFF] rounded-full text-xs font-semibold',
              [
                text(s),
                button(
                  [text('✕')],
                  onClick: () => _removeSkill(s),
                  classes: 'text-xs text-[#AB4AFF] hover:text-red-400 cursor-pointer ml-1',
                ),
              ],
            ),
        ]),
        div(classes: 'flex gap-2 mt-2', [
          input<String>(
            value: _newSkillInput,
            onInput: (v) => _newSkillInput = v,
            classes: _inputClass,
            attributes: {'placeholder': 'Add a skill (e.g. Riverpod, GraphQL)'},
          ),
          button(
            [text('+ Add Skill')],
            onClick: _addSkill,
            classes:
                'px-4 py-2 bg-[#AB4AFF] hover:bg-[#9732f0] text-white rounded-xl text-xs font-bold cursor-pointer shrink-0',
          ),
        ]),
      ]),

      // Certifications List
      _buildCard([
        _buildSubTitle('Certifications'),
        div(classes: 'space-y-2 my-3', [
          for (var c in profile.certifications)
            div(
              classes:
                  'flex items-center justify-between px-3 py-2 bg-[#0A0A0C] border border-[#1A1A22] rounded-xl text-xs text-white',
              [
                text(c),
                button(
                  [text('✕')],
                  onClick: () => _removeCert(c),
                  classes: 'text-xs text-[#8A8A93] hover:text-red-400 cursor-pointer',
                ),
              ],
            ),
        ]),
        div(classes: 'flex gap-2 mt-2', [
          input<String>(
            value: _newCertInput,
            onInput: (v) => _newCertInput = v,
            classes: _inputClass,
            attributes: {'placeholder': 'Add certification (e.g. AWS Certified)'},
          ),
          button(
            [text('+ Add Cert')],
            onClick: _addCert,
            classes:
                'px-4 py-2 bg-[#AB4AFF] hover:bg-[#9732f0] text-white rounded-xl text-xs font-bold cursor-pointer shrink-0',
          ),
        ]),
      ]),
    ]);
  }

  // =========================================================================
  // TAB 2: MANAGE CV
  // =========================================================================
  Component _buildResumeTab() {
    final profile = _data.profile;
    return div(classes: 'space-y-6', [
      _buildSectionHeader('Curriculum Vitae / Resume'),
      _buildCard([
        div(classes: 'space-y-4', [
          p(
            classes: 'text-xs text-[#8A8A93] leading-relaxed',
            [
              text(
                  'Upload your latest PDF CV to Google Drive, set its sharing permission to "Anyone with the link can view", and paste the link below.'),
            ],
          ),
          _buildField(
            'Google Drive CV URL',
            input<String>(
              value: profile.cvUrl,
              onInput: (v) => _updateProfileField((curr) => curr.copyWith(cvUrl: v)),
              classes: _inputClass,
              attributes: {
                'placeholder': 'https://drive.google.com/file/d/.../view?usp=sharing'
              },
            ),
          ),
          if (profile.cvUrl.isNotEmpty)
            div(classes: 'pt-2', [
              a(
                href: profile.cvUrl,
                target: Target.blank,
                classes:
                    'inline-flex items-center gap-1.5 text-xs text-[#AB4AFF] hover:underline font-semibold',
                [text('Test CV Link in New Tab ↗')],
              ),
            ]),
        ]),
      ]),
    ]);
  }

  // =========================================================================
  // TAB 3: EDUCATION
  // =========================================================================
  Component _buildEducationTab() {
    return div(classes: 'space-y-6', [
      div(classes: 'flex items-center justify-between', [
        _buildSectionHeader('Education History'),
        button(
          [text('+ Add Education')],
          onClick: _addEducation,
          classes:
              'px-3 py-1.5 rounded-xl bg-[#1A1A22] border border-[#2A2A38] text-xs font-semibold text-[#AB4AFF] hover:bg-[#AB4AFF] hover:text-white transition-colors cursor-pointer',
        ),
      ]),
      for (int i = 0; i < _data.education.length; i++)
        _buildCard([
          div(classes: 'flex justify-between items-start mb-3', [
            span(
              classes: 'text-xs font-bold text-[#AB4AFF]',
              [text('Education #${i + 1}')],
            ),
            button(
              [text('Delete')],
              onClick: () => _deleteEducation(i),
              classes:
                  'text-xs text-red-400 hover:text-red-300 transition-colors cursor-pointer',
            ),
          ]),
          div(classes: 'grid grid-cols-1 md:grid-cols-2 gap-4', [
            _buildField(
              'Degree / Qualification',
              input<String>(
                value: _data.education[i].degree,
                onInput: (v) => _updateEducation(i, (e) => e.copyWith(degree: v)),
                classes: _inputClass,
              ),
            ),
            _buildField(
              'School / Institution',
              input<String>(
                value: _data.education[i].school,
                onInput: (v) => _updateEducation(i, (e) => e.copyWith(school: v)),
                classes: _inputClass,
              ),
            ),
            _buildField(
              'Year Period',
              input<String>(
                value: _data.education[i].year,
                onInput: (v) => _updateEducation(i, (e) => e.copyWith(year: v)),
                classes: _inputClass,
              ),
            ),
          ]),
          div(classes: 'mt-3', [
            _buildField(
              'Description',
              textarea(
                [text(_data.education[i].description)],
                onInput: (v) => _updateEducation(i, (e) => e.copyWith(description: v)),
                classes: '$_inputClass min-h-[70px]',
              ),
            ),
          ]),
        ]),
    ]);
  }

  // =========================================================================
  // TAB 4: EXPERIENCE
  // =========================================================================
  Component _buildExperienceTab() {
    return div(classes: 'space-y-6', [
      div(classes: 'flex items-center justify-between', [
        _buildSectionHeader('Work Experience'),
        button(
          [text('+ Add Experience')],
          onClick: _addExperience,
          classes:
              'px-3 py-1.5 rounded-xl bg-[#1A1A22] border border-[#2A2A38] text-xs font-semibold text-[#AB4AFF] hover:bg-[#AB4AFF] hover:text-white transition-colors cursor-pointer',
        ),
      ]),
      for (int i = 0; i < _data.experience.length; i++)
        _buildCard([
          div(classes: 'flex justify-between items-start mb-3', [
            span(
              classes: 'text-xs font-bold text-[#AB4AFF]',
              [text('Position #${i + 1}')],
            ),
            button(
              [text('Delete')],
              onClick: () => _deleteExperience(i),
              classes:
                  'text-xs text-red-400 hover:text-red-300 transition-colors cursor-pointer',
            ),
          ]),
          div(classes: 'grid grid-cols-1 md:grid-cols-2 gap-4', [
            _buildField(
              'Job Role / Title',
              input<String>(
                value: _data.experience[i].role,
                onInput: (v) => _updateExperience(i, (e) => e.copyWith(role: v)),
                classes: _inputClass,
              ),
            ),
            _buildField(
              'Company / Organization',
              input<String>(
                value: _data.experience[i].company,
                onInput: (v) => _updateExperience(i, (e) => e.copyWith(company: v)),
                classes: _inputClass,
              ),
            ),
            _buildField(
              'Period (e.g. Jan 2024 – Present)',
              input<String>(
                value: _data.experience[i].period,
                onInput: (v) => _updateExperience(i, (e) => e.copyWith(period: v)),
                classes: _inputClass,
              ),
            ),
            _buildField(
              'Technologies (comma-separated)',
              input<String>(
                value: _data.experience[i].technologies.join(', '),
                onInput: (v) => _updateExperience(
                  i,
                  (e) => e.copyWith(
                    technologies:
                        v.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList(),
                  ),
                ),
                classes: _inputClass,
              ),
            ),
          ]),
          div(classes: 'mt-3', [
            _buildField(
              'Key Responsibilities & Achievements',
              textarea(
                [text(_data.experience[i].description)],
                onInput: (v) => _updateExperience(i, (e) => e.copyWith(description: v)),
                classes: '$_inputClass min-h-[80px]',
              ),
            ),
          ]),
        ]),
    ]);
  }

  // =========================================================================
  // TAB 5: PROJECTS
  // =========================================================================
  Component _buildProjectsTab() {
    return div(classes: 'space-y-6', [
      div(classes: 'flex items-center justify-between', [
        _buildSectionHeader('Projects Showcase'),
        button(
          [text('+ Add Project')],
          onClick: _addProject,
          classes:
              'px-3 py-1.5 rounded-xl bg-[#1A1A22] border border-[#2A2A38] text-xs font-semibold text-[#AB4AFF] hover:bg-[#AB4AFF] hover:text-white transition-colors cursor-pointer',
        ),
      ]),
      for (int i = 0; i < _data.projects.length; i++)
        _buildCard([
          div(classes: 'flex justify-between items-start mb-3', [
            span(
              classes: 'text-xs font-bold text-[#AB4AFF]',
              [text('Project #${i + 1}: ${_data.projects[i].title}')],
            ),
            button(
              [text('Delete')],
              onClick: () => _deleteProject(i),
              classes:
                  'text-xs text-red-400 hover:text-red-300 transition-colors cursor-pointer',
            ),
          ]),
          div(classes: 'grid grid-cols-1 md:grid-cols-2 gap-4', [
            _buildField(
              'Project Title',
              input<String>(
                value: _data.projects[i].title,
                onInput: (v) => _updateProject(i, (p) => p.copyWith(title: v)),
                classes: _inputClass,
              ),
            ),
            _buildField(
              'Image URL (Drive or Unsplash)',
              input<String>(
                value: _data.projects[i].image,
                onInput: (v) => _updateProject(i, (p) => p.copyWith(image: v)),
                classes: _inputClass,
              ),
            ),
            _buildField(
              'Live URL',
              input<String>(
                value: _data.projects[i].liveUrl,
                onInput: (v) => _updateProject(i, (p) => p.copyWith(liveUrl: v)),
                classes: _inputClass,
              ),
            ),
            _buildField(
              'GitHub URL',
              input<String>(
                value: _data.projects[i].githubUrl,
                onInput: (v) => _updateProject(i, (p) => p.copyWith(githubUrl: v)),
                classes: _inputClass,
              ),
            ),
            _buildField(
              'Tech Tags (comma-separated)',
              input<String>(
                value: _data.projects[i].tags.join(', '),
                onInput: (v) => _updateProject(
                  i,
                  (p) => p.copyWith(
                    tags:
                        v.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList(),
                  ),
                ),
                classes: _inputClass,
              ),
            ),
            div(classes: 'flex items-center gap-2 pt-6', [
              label(classes: 'flex items-center gap-2 cursor-pointer text-xs font-medium', [
                input(
                  type: InputType.checkbox,
                  checked: _data.projects[i].featured,
                  onChange: (val) => _updateProject(i, (p) => p.copyWith(featured: !_data.projects[i].featured)),
                  classes: 'w-4 h-4 accent-[#AB4AFF]',
                ),
                text('Featured on Homepage'),
              ]),
            ]),
          ]),
          div(classes: 'mt-3', [
            _buildField(
              'Short Description',
              textarea(
                [text(_data.projects[i].description)],
                onInput: (v) => _updateProject(i, (p) => p.copyWith(description: v)),
                classes: '$_inputClass min-h-[70px]',
              ),
            ),
          ]),
        ]),
    ]);
  }

  // =========================================================================
  // TAB 6: GALLERY
  // =========================================================================
  Component _buildGalleryTab() {
    return div(classes: 'space-y-6', [
      div(classes: 'flex items-center justify-between', [
        _buildSectionHeader('Photo Gallery'),
        button(
          [text('+ Add Photo')],
          onClick: _addGalleryPhoto,
          classes:
              'px-3 py-1.5 rounded-xl bg-[#1A1A22] border border-[#2A2A38] text-xs font-semibold text-[#AB4AFF] hover:bg-[#AB4AFF] hover:text-white transition-colors cursor-pointer',
        ),
      ]),
      for (int i = 0; i < _data.gallery.length; i++)
        _buildCard([
          div(classes: 'flex justify-between items-start mb-3', [
            span(
              classes: 'text-xs font-bold text-[#AB4AFF]',
              [text('Photo #${i + 1}')],
            ),
            button(
              [text('Delete')],
              onClick: () => _deleteGalleryPhoto(i),
              classes:
                  'text-xs text-red-400 hover:text-red-300 transition-colors cursor-pointer',
            ),
          ]),
          div(classes: 'grid grid-cols-1 md:grid-cols-2 gap-4', [
            _buildField(
              'Photo URL',
              input<String>(
                value: _data.gallery[i].url,
                onInput: (v) => _updateGalleryPhoto(i, (g) => g.copyWith(url: v)),
                classes: _inputClass,
              ),
            ),
            _buildField(
              'Category (e.g. Mobile, Tech)',
              input<String>(
                value: _data.gallery[i].category,
                onInput: (v) => _updateGalleryPhoto(i, (g) => g.copyWith(category: v)),
                classes: _inputClass,
              ),
            ),
          ]),
          div(classes: 'mt-3', [
            _buildField(
              'Caption',
              input<String>(
                value: _data.gallery[i].caption,
                onInput: (v) => _updateGalleryPhoto(i, (g) => g.copyWith(caption: v)),
                classes: _inputClass,
              ),
            ),
          ]),
        ]),
    ]);
  }

  // =========================================================================
  // TAB 7: BLOG
  // =========================================================================
  Component _buildBlogTab() {
    return div(classes: 'space-y-6', [
      div(classes: 'flex items-center justify-between', [
        _buildSectionHeader('Technical Articles & Blog'),
        button(
          [text('+ Add Article')],
          onClick: _addBlogPost,
          classes:
              'px-3 py-1.5 rounded-xl bg-[#1A1A22] border border-[#2A2A38] text-xs font-semibold text-[#AB4AFF] hover:bg-[#AB4AFF] hover:text-white transition-colors cursor-pointer',
        ),
      ]),
      for (int i = 0; i < _data.blog.length; i++)
        _buildCard([
          div(classes: 'flex justify-between items-start mb-3', [
            span(
              classes: 'text-xs font-bold text-[#AB4AFF]',
              [text('Article #${i + 1}: ${_data.blog[i].title}')],
            ),
            button(
              [text('Delete')],
              onClick: () => _deleteBlogPost(i),
              classes:
                  'text-xs text-red-400 hover:text-red-300 transition-colors cursor-pointer',
            ),
          ]),
          div(classes: 'grid grid-cols-1 md:grid-cols-2 gap-4', [
            _buildField(
              'Article Title',
              input<String>(
                value: _data.blog[i].title,
                onInput: (v) => _updateBlogPost(i, (b) => b.copyWith(title: v)),
                classes: _inputClass,
              ),
            ),
            _buildField(
              'Slug (URL Path)',
              input<String>(
                value: _data.blog[i].slug,
                onInput: (v) => _updateBlogPost(i, (b) => b.copyWith(slug: v)),
                classes: _inputClass,
              ),
            ),
            _buildField(
              'Cover Image URL',
              input<String>(
                value: _data.blog[i].coverImage,
                onInput: (v) => _updateBlogPost(i, (b) => b.copyWith(coverImage: v)),
                classes: _inputClass,
              ),
            ),
            _buildField(
              'Publication Date (YYYY-MM-DD)',
              input<String>(
                value: _data.blog[i].publishedAt,
                onInput: (v) => _updateBlogPost(i, (b) => b.copyWith(publishedAt: v)),
                classes: _inputClass,
              ),
            ),
            _buildField(
              'Tags (comma-separated)',
              input<String>(
                value: _data.blog[i].tags.join(', '),
                onInput: (v) => _updateBlogPost(
                  i,
                  (b) => b.copyWith(
                    tags:
                        v.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList(),
                  ),
                ),
                classes: _inputClass,
              ),
            ),
          ]),
          div(classes: 'mt-3', [
            _buildField(
              'Article Excerpt',
              textarea(
                [text(_data.blog[i].excerpt)],
                onInput: (v) => _updateBlogPost(i, (b) => b.copyWith(excerpt: v)),
                classes: '$_inputClass min-h-[60px]',
              ),
            ),
          ]),
          div(classes: 'mt-3', [
            _buildField(
              'Full Content (Markdown or Text)',
              textarea(
                [text(_data.blog[i].content)],
                onInput: (v) => _updateBlogPost(i, (b) => b.copyWith(content: v)),
                classes: '$_inputClass min-h-[160px] font-mono text-xs',
              ),
            ),
          ]),
        ]),
    ]);
  }

  // --- UI Building Blocks ---
  static const String _inputClass =
      'w-full px-3.5 py-2.5 bg-[#0A0A0C] border border-[#1A1A22] rounded-xl focus:border-[#AB4AFF] focus:outline-none transition-colors text-xs text-[#F4F4F6] placeholder-[#8A8A93]';

  Component _buildSectionHeader(String title) {
    return h2(
      classes: 'text-lg font-bold text-white tracking-tight',
      [text(title)],
    );
  }

  Component _buildSubTitle(String title) {
    return p(
      classes: 'text-xs font-bold text-[#8A8A93] uppercase tracking-wider',
      [text(title)],
    );
  }

  Component _buildField(String labelText, Component fieldWidget) {
    return div(classes: 'flex flex-col gap-1.5', [
      label(
        classes: 'text-[11px] font-semibold text-[#8A8A93] uppercase tracking-wide',
        [text(labelText)],
      ),
      fieldWidget,
    ]);
  }

  Component _buildCard(List<Component> children) {
    return div(
      classes:
          'bg-[#121216] border border-[#1A1A22] rounded-2xl p-5 shadow-lg space-y-3',
      children,
    );
  }
}
