import { useState, useEffect } from 'react';
import Link from 'next/link';
import { useRouter } from 'next/navigation';
import {
  ArrowLeft, User, GraduationCap, Briefcase, FolderGit2,
  Image, BookOpen, Plus, Trash2, Save, Eye, EyeOff,
  ChevronDown, ChevronUp, ExternalLink, X, FileText
} from 'lucide-react';
import {
  loadData, saveData, updateData,
  type SiteData, type Education, type Experience, type Project,
  type GalleryPhoto, type BlogPost, type Profile
} from '../data/store';
import { useSiteData } from '../hooks/useSiteData';
import { auth } from '../lib/firebase';
import { onAuthStateChanged, signOut } from 'firebase/auth';

type Tab = 'profile' | 'resume' | 'education' | 'experience' | 'projects' | 'gallery' | 'blog';

const TABS: { id: Tab; label: string; icon: React.ReactNode }[] = [
  { id: 'profile', label: 'Profile', icon: <User size={18} /> },
  { id: 'resume', label: 'Manage CV', icon: <FileText size={18} /> },
  { id: 'education', label: 'Education', icon: <GraduationCap size={18} /> },
  { id: 'experience', label: 'Experience', icon: <Briefcase size={16} /> },
  { id: 'projects', label: 'Projects', icon: <FolderGit2 size={16} /> },
  { id: 'gallery', label: 'Gallery', icon: <Image size={16} /> },
  { id: 'blog', label: 'Blog', icon: <BookOpen size={16} /> },
];

function uid() {
  return Math.random().toString(36).slice(2);
}

function Toast({ msg, onClose }: { msg: string; onClose: () => void }) {
  useEffect(() => {
    const t = setTimeout(onClose, 2500);
    return () => clearTimeout(t);
  }, [onClose]);
  return (
    <div className="fixed bottom-6 right-6 z-[100] bg-[#AB4AFF] text-white px-5 py-3 rounded-xl shadow-2xl text-sm font-medium flex items-center gap-3">
      {msg}
      <button onClick={onClose}><X size={14} /></button>
    </div>
  );
}

export function Admin() {
  const [activeTab, setActiveTab] = useState<Tab>('profile');
  const { data: initialData, loading: dataLoading, error } = useSiteData();
  const [data, setData] = useState<SiteData | null>(null);
  const [toast, setToast] = useState('');
  const [authChecking, setAuthChecking] = useState(true);
  const router = useRouter();

  useEffect(() => {
    const unsubscribe = onAuthStateChanged(auth, (user) => {
      if (!user) {
        router.push('/adminim/login');
      } else {
        setAuthChecking(false);
      }
    });
    return () => unsubscribe();
  }, [router]);

  useEffect(() => {
    if (initialData && !data) {
      setData(initialData);
    }
  }, [initialData, data]);

  const handleLogout = async () => {
    await signOut(auth);
    router.push('/adminim/login');
  };

  const save = async (updated: SiteData) => {
    setData(updated);
    try {
      await updateData(updated);
      setToast('Saved successfully!');
    } catch (err) {
      setToast('Failed to save data!');
    }
  };

  if (authChecking || dataLoading || !data) {
    return (
      <div className="min-h-screen bg-[#0A0A0C] flex items-center justify-center">
        <div className="w-12 h-12 border-4 border-[#1A1A22] border-t-[#AB4AFF] rounded-full animate-spin"></div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-[#0A0A0C] text-[#F4F4F6] flex flex-col">
      {toast && <Toast msg={toast} onClose={() => setToast('')} />}

      {/* Header */}
      <header className="sticky top-0 z-50 border-b border-[#1A1A22] bg-[#0A0A0C]/95 backdrop-blur-md">
        <div className="max-w-7xl mx-auto px-6 h-14 flex items-center justify-between">
          <div className="flex items-center gap-4">
            <Link href="/" className="flex items-center gap-2 text-[#8A8A93] hover:text-[#AB4AFF] transition-colors text-sm">
              <ArrowLeft size={15} />
              Portfolio
            </Link>
            <span className="text-[#1A1A22]">|</span>
            <span className="text-[#F4F4F6] font-semibold text-sm" style={{ fontFamily: 'Plus Jakarta Sans, sans-serif' }}>
              Admin Panel
            </span>
          </div>
          <div className="flex items-center gap-4">
            <Link href="/blog" className="text-xs text-[#8A8A93] hover:text-[#AB4AFF] flex items-center gap-1 transition-colors">
              Blog <ExternalLink size={11} />
            </Link>
            <button
              onClick={handleLogout}
              className="text-xs text-[#8A8A93] hover:text-red-400 flex items-center gap-1 transition-colors border border-[#1A1A22] px-3 py-1.5 rounded-lg hover:border-red-400"
            >
              Log Out
            </button>
          </div>
        </div>
      </header>

      <div className="flex flex-1 max-w-7xl mx-auto w-full">
        {/* Sidebar */}
        <aside className="w-52 shrink-0 border-r border-[#1A1A22] py-6 px-3 hidden md:block">
          <nav className="flex flex-col gap-1">
            {TABS.map(tab => (
              <button
                key={tab.id}
                onClick={() => setActiveTab(tab.id)}
                className={`flex items-center gap-2.5 px-3 py-2.5 rounded-xl text-sm transition-all text-left ${
                  activeTab === tab.id
                    ? 'bg-[#AB4AFF]/15 text-[#AB4AFF] font-medium'
                    : 'text-[#8A8A93] hover:text-[#F4F4F6] hover:bg-[#13131A]'
                }`}
              >
                {tab.icon}
                {tab.label}
              </button>
            ))}
          </nav>
        </aside>

        {/* Mobile Tab Bar */}
        <div className="md:hidden fixed bottom-0 left-0 right-0 z-50 bg-[#0D0D14] border-t border-[#1A1A22] flex">
          {TABS.map(tab => (
            <button
              key={tab.id}
              onClick={() => setActiveTab(tab.id)}
              className={`flex-1 flex flex-col items-center gap-1 py-2 text-[10px] transition-colors ${
                activeTab === tab.id ? 'text-[#AB4AFF]' : 'text-[#8A8A93]'
              }`}
            >
              {tab.icon}
              {tab.label}
            </button>
          ))}
        </div>

        {/* Content */}
        <main className="flex-1 p-6 pb-20 md:pb-6 overflow-y-auto">
          {activeTab === 'profile' && <ProfileEditor data={data} onSave={save} />}
          {activeTab === 'resume' && <ResumeEditor data={data} onSave={save} />}
          {activeTab === 'education' && <EducationEditor data={data} onSave={save} />}
          {activeTab === 'experience' && <ExperienceEditor data={data} onSave={save} />}
          {activeTab === 'projects' && <ProjectsEditor data={data} onSave={save} />}
          {activeTab === 'gallery' && <GalleryEditor data={data} onSave={save} />}
          {activeTab === 'blog' && <BlogEditor data={data} onSave={save} />}
        </main>
      </div>
    </div>
  );
}

/* ─── Shared UI ─────────────────────────────────────────────────────────── */

function SectionHeader({ title, action }: { title: string; action?: React.ReactNode }) {
  return (
    <div className="flex items-center justify-between mb-6">
      <h2 className="text-[#F4F4F6]" style={{ fontFamily: 'Plus Jakarta Sans, sans-serif', fontSize: '1.3rem', fontWeight: 700 }}>
        {title}
      </h2>
      {action}
    </div>
  );
}

function Field({ label, children }: { label: string; children: React.ReactNode }) {
  return (
    <div className="flex flex-col gap-1.5">
      <label className="text-xs text-[#8A8A93] font-medium uppercase tracking-wide">{label}</label>
      {children}
    </div>
  );
}

const inputCls = "bg-[#0D0D14] border border-[#1A1A22] rounded-xl px-4 py-2.5 text-sm text-[#F4F4F6] placeholder-[#8A8A93] focus:outline-none focus:border-[#AB4AFF] transition-colors w-full";
const textareaCls = inputCls + " resize-y min-h-[90px]";

function SaveBtn({ onClick }: { onClick: () => void }) {
  return (
    <button
      onClick={onClick}
      className="flex items-center gap-2 bg-[#AB4AFF] hover:bg-[#9933EE] text-white px-5 py-2.5 rounded-xl text-sm font-medium transition-colors"
    >
      <Save size={14} />
      Save Changes
    </button>
  );
}

function AddBtn({ onClick, label }: { onClick: () => void; label: string }) {
  return (
    <button
      onClick={onClick}
      className="flex items-center gap-2 bg-[#13131A] border border-[#1A1A22] hover:border-[#AB4AFF]/50 text-[#8A8A93] hover:text-[#AB4AFF] px-4 py-2 rounded-xl text-sm transition-all"
    >
      <Plus size={14} />
      {label}
    </button>
  );
}

function DeleteBtn({ onClick }: { onClick: () => void }) {
  return (
    <button
      onClick={onClick}
      className="text-[#8A8A93] hover:text-red-400 transition-colors p-1.5 rounded-lg hover:bg-red-400/10"
    >
      <Trash2 size={14} />
    </button>
  );
}

function Card({ children }: { children: React.ReactNode }) {
  return (
    <div className="bg-[#13131A] border border-[#1A1A22] rounded-2xl p-5">
      {children}
    </div>
  );
}

/* ─── Profile ───────────────────────────────────────────────────────────── */

function ProfileEditor({ data, onSave }: { data: SiteData; onSave: (d: SiteData) => void }) {
  const [p, setP] = useState<Profile>(data.profile);
  const [skillInput, setSkillInput] = useState('');
  const [carouselInput, setCarouselInput] = useState('');

  const set = (key: keyof Profile, val: any) => setP(prev => ({ ...prev, [key]: val }));

  const addSkill = () => {
    const s = skillInput.trim();
    if (s && !p.skills.includes(s)) {
      set('skills', [...p.skills, s]);
      setSkillInput('');
    }
  };

  const removeSkill = (s: string) => set('skills', p.skills.filter(x => x !== s));

  const addCarouselText = () => {
    const s = carouselInput.trim();
    const currentTexts = p.carouselTexts || [];
    if (s && !currentTexts.includes(s)) {
      set('carouselTexts', [...currentTexts, s]);
      setCarouselInput('');
    }
  };

  const removeCarouselText = (s: string) => set('carouselTexts', (p.carouselTexts || []).filter(x => x !== s));

  const updateStat = (idx: number, key: 'label' | 'value', val: string) => {
    const stats = [...p.stats];
    stats[idx] = { ...stats[idx], [key]: val };
    set('stats', stats);
  };

  return (
    <div className="max-w-2xl space-y-6">
      <SectionHeader title="Profile" action={<SaveBtn onClick={() => onSave({ ...data, profile: p })} />} />

      <Card>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <Field label="Name"><input className={inputCls} value={p.name} onChange={e => set('name', e.target.value)} /></Field>
          <Field label="Location"><input className={inputCls} value={p.location} onChange={e => set('location', e.target.value)} /></Field>
          <Field label="Email"><input className={inputCls} value={p.email} onChange={e => set('email', e.target.value)} /></Field>
          <Field label="Site Title (Browser Tab)"><input className={inputCls} value={p.siteTitle || ''} onChange={e => set('siteTitle', e.target.value)} /></Field>
          <Field label="Tagline"><input className={inputCls} value={p.tagline} onChange={e => set('tagline', e.target.value)} /></Field>
          <Field label="GitHub URL"><input className={inputCls} value={p.github} onChange={e => set('github', e.target.value)} /></Field>
          <Field label="LinkedIn URL"><input className={inputCls} value={p.linkedin} onChange={e => set('linkedin', e.target.value)} /></Field>
          <Field label="Twitter URL"><input className={inputCls} value={p.twitter} onChange={e => set('twitter', e.target.value)} /></Field>
          <Field label="Hero Photo URL"><input className={inputCls} value={p.heroPhoto} onChange={e => set('heroPhoto', e.target.value)} /></Field>
        </div>
        <div className="mt-4">
          <Field label="Bio"><textarea className={textareaCls} value={p.bio} onChange={e => set('bio', e.target.value)} /></Field>
        </div>
      </Card>

      {/* Name Carousel Settings */}
      <Card>
        <p className="text-xs text-[#8A8A93] font-medium uppercase tracking-wide mb-4">Name Animation (Hero Section)</p>
        <div className="space-y-4">
          <label className="flex items-center gap-3 cursor-pointer">
            <input 
              type="checkbox" 
              className="w-5 h-5 accent-[#AB4AFF] rounded bg-[#1A1A22] border-none"
              checked={!!p.enableCarousel} 
              onChange={e => set('enableCarousel', e.target.checked)} 
            />
            <span className="text-[#F4F4F6]">Enable animated fading text</span>
          </label>
          
          {p.enableCarousel && (
            <div className="mt-4 p-4 border border-[#1A1A22] rounded-xl bg-[#0A0A0C]">
              <p className="text-sm text-[#8A8A93] mb-3">Add texts that will fade in and out (e.g. "Ilham", "a Developer").</p>
              <div className="flex gap-2 mb-3">
                <input 
                  className={inputCls} 
                  placeholder="Add a name or role" 
                  value={carouselInput} 
                  onChange={e => setCarouselInput(e.target.value)} 
                  onKeyDown={e => e.key === 'Enter' && addCarouselText()} 
                />
                <button className="px-4 py-2 bg-[#1A1A22] text-[#F4F4F6] rounded-xl hover:bg-[#AB4AFF] transition-colors" onClick={addCarouselText}>
                  Add
                </button>
              </div>
              <div className="flex flex-wrap gap-2">
                {(p.carouselTexts || []).map(t => (
                  <div key={t} className="flex items-center gap-2 bg-[#1A1A22] px-3 py-1.5 rounded-lg text-sm">
                    {t}
                    <button className="text-[#8A8A93] hover:text-red-400" onClick={() => removeCarouselText(t)}><X size={14} /></button>
                  </div>
                ))}
              </div>
            </div>
          )}
        </div>
      </Card>

      {/* Stats */}
      <Card>
        <p className="text-xs text-[#8A8A93] font-medium uppercase tracking-wide mb-4">Hero Stats</p>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          {p.stats.map((stat, i) => (
            <div key={i} className="flex flex-col gap-2">
              <input className={inputCls} placeholder="Value (e.g. 20+)" value={stat.value} onChange={e => updateStat(i, 'value', e.target.value)} />
              <input className={inputCls} placeholder="Label" value={stat.label} onChange={e => updateStat(i, 'label', e.target.value)} />
            </div>
          ))}
        </div>
      </Card>

      {/* Skills */}
      <Card>
        <p className="text-xs text-[#8A8A93] font-medium uppercase tracking-wide mb-4">Skills</p>
        <div className="flex flex-wrap gap-2 mb-3">
          {p.skills.map(s => (
            <span key={s} className="flex items-center gap-1.5 bg-[#AB4AFF]/10 text-[#AB4AFF] px-3 py-1 rounded-full text-sm">
              {s}
              <button onClick={() => removeSkill(s)} className="hover:text-red-400 transition-colors"><X size={11} /></button>
            </span>
          ))}
        </div>
        <div className="flex gap-2">
          <input
            className={inputCls}
            placeholder="Add a skill..."
            value={skillInput}
            onChange={e => setSkillInput(e.target.value)}
            onKeyDown={e => e.key === 'Enter' && addSkill()}
          />
          <button onClick={addSkill} className="bg-[#AB4AFF] hover:bg-[#9933EE] text-white px-4 rounded-xl transition-colors shrink-0 text-sm">Add</button>
        </div>
      </Card>
    </div>
  );
}

// -- Resume Editor --
function ResumeEditor({ data, onSave }: { data: SiteData, onSave: (d: SiteData) => void }) {
  const [p, setP] = useState<Profile>(data.profile);

  const set = (key: keyof Profile, value: any) => setP({ ...p, [key]: value });

  return (
    <div className="max-w-2xl space-y-6">
      <SectionHeader title="Manage CV" action={<SaveBtn onClick={() => onSave({ ...data, profile: p })} />} />

      <Card>
        <div className="space-y-4">
          <p className="text-sm text-[#8A8A93]">
            Upload your CV to Google Drive, make sure the link is set to "Anyone with the link can view", and paste the link below.
          </p>
          <Field label="CV/Resume Link (Google Drive URL)">
            <input 
              className={inputCls} 
              value={p.cvUrl || ''} 
              onChange={e => set('cvUrl', e.target.value)} 
              placeholder="https://drive.google.com/..." 
            />
          </Field>
        </div>
      </Card>
    </div>
  );
}

// -- Education Editor --─────────────────────────────────────────────────────────── */

function EducationEditor({ data, onSave }: { data: SiteData; onSave: (d: SiteData) => void }) {
  const [items, setItems] = useState<Education[]>(data.education);

  const add = () => setItems(prev => [...prev, { id: uid(), degree: '', school: '', year: '', description: '' }]);
  const remove = (id: string) => setItems(prev => prev.filter(e => e.id !== id));
  const update = (id: string, key: keyof Education, val: string) =>
    setItems(prev => prev.map(e => e.id === id ? { ...e, [key]: val } : e));

  return (
    <div className="max-w-2xl space-y-4">
      <SectionHeader
        title="Education"
        action={
          <div className="flex gap-2">
            <AddBtn onClick={add} label="Add" />
            <SaveBtn onClick={() => onSave({ ...data, education: items })} />
          </div>
        }
      />
      {items.map(edu => (
        <Card key={edu.id}>
          <div className="flex justify-end mb-3"><DeleteBtn onClick={() => remove(edu.id)} /></div>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <Field label="Degree"><input className={inputCls} value={edu.degree} onChange={e => update(edu.id, 'degree', e.target.value)} placeholder="BSc in Computer Science" /></Field>
            <Field label="School"><input className={inputCls} value={edu.school} onChange={e => update(edu.id, 'school', e.target.value)} placeholder="University Name" /></Field>
            <Field label="Year"><input className={inputCls} value={edu.year} onChange={e => update(edu.id, 'year', e.target.value)} placeholder="2020 – 2024" /></Field>
          </div>
          <div className="mt-4">
            <Field label="Description"><textarea className={textareaCls} value={edu.description} onChange={e => update(edu.id, 'description', e.target.value)} /></Field>
          </div>
        </Card>
      ))}
      {items.length === 0 && (
        <div className="text-center py-12 text-[#8A8A93] bg-[#13131A] border border-dashed border-[#1A1A22] rounded-2xl">
          No education entries yet. Click "Add" to get started.
        </div>
      )}
    </div>
  );
}

/* ─── Experience ────────────────────────────────────────────────────────── */

function ExperienceEditor({ data, onSave }: { data: SiteData; onSave: (d: SiteData) => void }) {
  const [items, setItems] = useState<Experience[]>(data.experience);
  const [techInput, setTechInput] = useState<Record<string, string>>({});

  const add = () => setItems(prev => [...prev, { id: uid(), role: '', company: '', period: '', description: '', technologies: [] }]);
  const remove = (id: string) => setItems(prev => prev.filter(e => e.id !== id));
  const update = (id: string, key: keyof Experience, val: any) =>
    setItems(prev => prev.map(e => e.id === id ? { ...e, [key]: val } : e));

  const addTech = (id: string) => {
    const t = (techInput[id] || '').trim();
    if (!t) return;
    const exp = items.find(e => e.id === id);
    if (exp && !exp.technologies.includes(t)) {
      update(id, 'technologies', [...exp.technologies, t]);
      setTechInput(prev => ({ ...prev, [id]: '' }));
    }
  };

  const removeTech = (id: string, tech: string) => {
    const exp = items.find(e => e.id === id);
    if (exp) update(id, 'technologies', exp.technologies.filter(t => t !== tech));
  };

  return (
    <div className="max-w-2xl space-y-4">
      <SectionHeader
        title="Experience"
        action={
          <div className="flex gap-2">
            <AddBtn onClick={add} label="Add" />
            <SaveBtn onClick={() => onSave({ ...data, experience: items })} />
          </div>
        }
      />
      {items.map(exp => (
        <Card key={exp.id}>
          <div className="flex justify-end mb-3"><DeleteBtn onClick={() => remove(exp.id)} /></div>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <Field label="Role"><input className={inputCls} value={exp.role} onChange={e => update(exp.id, 'role', e.target.value)} placeholder="Frontend Developer" /></Field>
            <Field label="Company"><input className={inputCls} value={exp.company} onChange={e => update(exp.id, 'company', e.target.value)} placeholder="Company Name" /></Field>
            <Field label="Period"><input className={inputCls} value={exp.period} onChange={e => update(exp.id, 'period', e.target.value)} placeholder="Jan 2024 – Present" /></Field>
          </div>
          <div className="mt-4 space-y-3">
            <Field label="Description"><textarea className={textareaCls} value={exp.description} onChange={e => update(exp.id, 'description', e.target.value)} /></Field>
            <Field label="Technologies">
              <div className="flex flex-wrap gap-2 mb-2">
                {exp.technologies.map(t => (
                  <span key={t} className="flex items-center gap-1.5 bg-[#AB4AFF]/10 text-[#AB4AFF] px-2.5 py-1 rounded-full text-xs">
                    {t}
                    <button onClick={() => removeTech(exp.id, t)} className="hover:text-red-400"><X size={10} /></button>
                  </span>
                ))}
              </div>
              <div className="flex gap-2">
                <input
                  className={inputCls}
                  placeholder="Add technology..."
                  value={techInput[exp.id] || ''}
                  onChange={e => setTechInput(prev => ({ ...prev, [exp.id]: e.target.value }))}
                  onKeyDown={e => e.key === 'Enter' && addTech(exp.id)}
                />
                <button onClick={() => addTech(exp.id)} className="bg-[#AB4AFF] hover:bg-[#9933EE] text-white px-4 rounded-xl transition-colors shrink-0 text-sm">Add</button>
              </div>
            </Field>
          </div>
        </Card>
      ))}
      {items.length === 0 && (
        <div className="text-center py-12 text-[#8A8A93] bg-[#13131A] border border-dashed border-[#1A1A22] rounded-2xl">
          No experience entries yet.
        </div>
      )}
    </div>
  );
}

/* ─── Projects ──────────────────────────────────────────────────────────── */

function ProjectsEditor({ data, onSave }: { data: SiteData; onSave: (d: SiteData) => void }) {
  const [items, setItems] = useState<Project[]>(data.projects);
  const [tagInput, setTagInput] = useState<Record<string, string>>({});

  const add = () => setItems(prev => [...prev, { id: uid(), title: '', description: '', tags: [], liveUrl: '', githubUrl: '', featured: false, image: '' }]);
  const remove = (id: string) => setItems(prev => prev.filter(p => p.id !== id));
  const update = (id: string, key: keyof Project, val: any) =>
    setItems(prev => prev.map(p => p.id === id ? { ...p, [key]: val } : p));

  const addTag = (id: string) => {
    const t = (tagInput[id] || '').trim();
    if (!t) return;
    const proj = items.find(p => p.id === id);
    if (proj && !proj.tags.includes(t)) {
      update(id, 'tags', [...proj.tags, t]);
      setTagInput(prev => ({ ...prev, [id]: '' }));
    }
  };

  const removeTag = (id: string, tag: string) => {
    const proj = items.find(p => p.id === id);
    if (proj) update(id, 'tags', proj.tags.filter(t => t !== tag));
  };

  return (
    <div className="max-w-2xl space-y-4">
      <SectionHeader
        title="Projects"
        action={
          <div className="flex gap-2">
            <AddBtn onClick={add} label="Add Project" />
            <SaveBtn onClick={() => onSave({ ...data, projects: items })} />
          </div>
        }
      />
      {items.map(proj => (
        <Card key={proj.id}>
          <div className="flex items-center justify-between mb-3">
            <label className="flex items-center gap-2 text-sm text-[#8A8A93] cursor-pointer">
              <input type="checkbox" checked={proj.featured} onChange={e => update(proj.id, 'featured', e.target.checked)} className="accent-[#AB4AFF]" />
              Featured
            </label>
            <DeleteBtn onClick={() => remove(proj.id)} />
          </div>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <Field label="Title"><input className={inputCls} value={proj.title} onChange={e => update(proj.id, 'title', e.target.value)} /></Field>
            <Field label="Image URL"><input className={inputCls} value={proj.image} onChange={e => update(proj.id, 'image', e.target.value)} placeholder="https://..." /></Field>
            <Field label="Live URL"><input className={inputCls} value={proj.liveUrl} onChange={e => update(proj.id, 'liveUrl', e.target.value)} placeholder="https://..." /></Field>
            <Field label="GitHub URL"><input className={inputCls} value={proj.githubUrl} onChange={e => update(proj.id, 'githubUrl', e.target.value)} placeholder="https://github.com/..." /></Field>
          </div>
          <div className="mt-4 space-y-3">
            <Field label="Description"><textarea className={textareaCls} value={proj.description} onChange={e => update(proj.id, 'description', e.target.value)} /></Field>
            <Field label="Tags">
              <div className="flex flex-wrap gap-2 mb-2">
                {proj.tags.map(t => (
                  <span key={t} className="flex items-center gap-1.5 bg-[#AB4AFF]/10 text-[#AB4AFF] px-2.5 py-1 rounded-full text-xs">
                    {t}
                    <button onClick={() => removeTag(proj.id, t)} className="hover:text-red-400"><X size={10} /></button>
                  </span>
                ))}
              </div>
              <div className="flex gap-2">
                <input
                  className={inputCls}
                  placeholder="Add tag..."
                  value={tagInput[proj.id] || ''}
                  onChange={e => setTagInput(prev => ({ ...prev, [proj.id]: e.target.value }))}
                  onKeyDown={e => e.key === 'Enter' && addTag(proj.id)}
                />
                <button onClick={() => addTag(proj.id)} className="bg-[#AB4AFF] hover:bg-[#9933EE] text-white px-4 rounded-xl transition-colors shrink-0 text-sm">Add</button>
              </div>
            </Field>
          </div>
        </Card>
      ))}
      {items.length === 0 && (
        <div className="text-center py-12 text-[#8A8A93] bg-[#13131A] border border-dashed border-[#1A1A22] rounded-2xl">
          No projects yet.
        </div>
      )}
    </div>
  );
}

/* ─── Gallery ───────────────────────────────────────────────────────────── */

function GalleryEditor({ data, onSave }: { data: SiteData; onSave: (d: SiteData) => void }) {
  const [items, setItems] = useState<GalleryPhoto[]>(data.gallery);

  const add = () => setItems(prev => [...prev, { id: uid(), url: '', caption: '', category: '' }]);
  const remove = (id: string) => setItems(prev => prev.filter(p => p.id !== id));
  const update = (id: string, key: keyof GalleryPhoto, val: string) =>
    setItems(prev => prev.map(p => p.id === id ? { ...p, [key]: val } : p));

  return (
    <div className="max-w-3xl space-y-4">
      <SectionHeader
        title="Photo Gallery"
        action={
          <div className="flex gap-2">
            <AddBtn onClick={add} label="Add Photo" />
            <SaveBtn onClick={() => onSave({ ...data, gallery: items })} />
          </div>
        }
      />
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        {items.map(photo => (
          <Card key={photo.id}>
            <div className="flex justify-end mb-2"><DeleteBtn onClick={() => remove(photo.id)} /></div>
            {photo.url && (
              <div className="mb-3 rounded-xl overflow-hidden h-40">
                <img src={photo.url} alt={photo.caption} className="w-full h-full object-cover" />
              </div>
            )}
            <div className="space-y-3">
              <Field label="Image URL"><input className={inputCls} value={photo.url} onChange={e => update(photo.id, 'url', e.target.value)} placeholder="https://..." /></Field>
              <Field label="Caption"><input className={inputCls} value={photo.caption} onChange={e => update(photo.id, 'caption', e.target.value)} /></Field>
              <Field label="Category"><input className={inputCls} value={photo.category} onChange={e => update(photo.id, 'category', e.target.value)} placeholder="Nature, Urban, Travel..." /></Field>
            </div>
          </Card>
        ))}
      </div>
      {items.length === 0 && (
        <div className="text-center py-12 text-[#8A8A93] bg-[#13131A] border border-dashed border-[#1A1A22] rounded-2xl">
          No photos yet. Add photo URLs to display in your gallery.
        </div>
      )}
    </div>
  );
}

/* ─── Blog ──────────────────────────────────────────────────────────────── */

function BlogEditor({ data, onSave }: { data: SiteData; onSave: (d: SiteData) => void }) {
  const [items, setItems] = useState<BlogPost[]>(data.blog);
  const [editing, setEditing] = useState<string | null>(null);
  const [tagInput, setTagInput] = useState<Record<string, string>>({});

  const add = () => {
    const id = uid();
    const newPost: BlogPost = {
      id,
      title: 'New Post',
      slug: 'new-post-' + id,
      excerpt: '',
      content: '# New Post\n\nStart writing here...',
      tags: [],
      coverImage: '',
      publishedAt: new Date().toISOString().slice(0, 10),
      published: false,
    };
    setItems(prev => [newPost, ...prev]);
    setEditing(id);
  };

  const remove = (id: string) => setItems(prev => prev.filter(p => p.id !== id));
  const update = (id: string, key: keyof BlogPost, val: any) =>
    setItems(prev => prev.map(p => p.id === id ? { ...p, [key]: val } : p));

  const togglePublish = (id: string) => {
    const post = items.find(p => p.id === id);
    if (post) update(id, 'published', !post.published);
  };

  const addTag = (id: string) => {
    const t = (tagInput[id] || '').trim();
    if (!t) return;
    const post = items.find(p => p.id === id);
    if (post && !post.tags.includes(t)) {
      update(id, 'tags', [...post.tags, t]);
      setTagInput(prev => ({ ...prev, [id]: '' }));
    }
  };

  const removeTag = (id: string, tag: string) => {
    const post = items.find(p => p.id === id);
    if (post) update(id, 'tags', post.tags.filter(t => t !== tag));
  };

  return (
    <div className="max-w-3xl space-y-4">
      <SectionHeader
        title="Blog Posts"
        action={
          <div className="flex gap-2">
            <AddBtn onClick={add} label="New Post" />
            <SaveBtn onClick={() => onSave({ ...data, blog: items })} />
          </div>
        }
      />
      {items.map(post => (
        <Card key={post.id}>
          <div className="flex items-center justify-between mb-3">
            <button
              onClick={() => setEditing(editing === post.id ? null : post.id)}
              className="flex items-center gap-2 text-[#F4F4F6] hover:text-[#AB4AFF] transition-colors font-medium text-sm"
            >
              {editing === post.id ? <ChevronUp size={14} /> : <ChevronDown size={14} />}
              {post.title}
            </button>
            <div className="flex items-center gap-2">
              <span className={`text-xs px-2.5 py-1 rounded-full ${post.published ? 'bg-green-500/10 text-green-400' : 'bg-yellow-500/10 text-yellow-400'}`}>
                {post.published ? 'Published' : 'Draft'}
              </span>
              <button
                onClick={() => togglePublish(post.id)}
                className="text-[#8A8A93] hover:text-[#AB4AFF] transition-colors p-1.5"
                title={post.published ? 'Unpublish' : 'Publish'}
              >
                {post.published ? <EyeOff size={14} /> : <Eye size={14} />}
              </button>
              {post.published && (
                <Link href={`/blog/${post.slug}`} target="_blank" className="text-[#8A8A93] hover:text-[#AB4AFF] transition-colors p-1.5">
                  <ExternalLink size={14} />
                </Link>
              )}
              <DeleteBtn onClick={() => remove(post.id)} />
            </div>
          </div>

          {editing === post.id && (
            <div className="space-y-4 pt-3 border-t border-[#1A1A22]">
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <Field label="Title"><input className={inputCls} value={post.title} onChange={e => update(post.id, 'title', e.target.value)} /></Field>
                <Field label="Slug"><input className={inputCls} value={post.slug} onChange={e => update(post.id, 'slug', e.target.value.toLowerCase().replace(/\s+/g, '-'))} /></Field>
                <Field label="Published Date"><input type="date" className={inputCls} value={post.publishedAt} onChange={e => update(post.id, 'publishedAt', e.target.value)} /></Field>
                <Field label="Cover Image URL"><input className={inputCls} value={post.coverImage} onChange={e => update(post.id, 'coverImage', e.target.value)} placeholder="https://..." /></Field>
              </div>
              {post.coverImage && (
                <div className="rounded-xl overflow-hidden h-40">
                  <img src={post.coverImage} alt="Cover" className="w-full h-full object-cover" />
                </div>
              )}
              <Field label="Excerpt"><textarea className={textareaCls} style={{ minHeight: 60 }} value={post.excerpt} onChange={e => update(post.id, 'excerpt', e.target.value)} /></Field>
              <Field label="Content (Markdown)">
                <textarea
                  className={textareaCls}
                  style={{ minHeight: 240, fontFamily: 'JetBrains Mono, monospace', fontSize: '0.8rem' }}
                  value={post.content}
                  onChange={e => update(post.id, 'content', e.target.value)}
                />
              </Field>
              <Field label="Tags">
                <div className="flex flex-wrap gap-2 mb-2">
                  {post.tags.map(t => (
                    <span key={t} className="flex items-center gap-1.5 bg-[#AB4AFF]/10 text-[#AB4AFF] px-2.5 py-1 rounded-full text-xs">
                      {t}
                      <button onClick={() => removeTag(post.id, t)} className="hover:text-red-400"><X size={10} /></button>
                    </span>
                  ))}
                </div>
                <div className="flex gap-2">
                  <input
                    className={inputCls}
                    placeholder="Add tag..."
                    value={tagInput[post.id] || ''}
                    onChange={e => setTagInput(prev => ({ ...prev, [post.id]: e.target.value }))}
                    onKeyDown={e => e.key === 'Enter' && addTag(post.id)}
                  />
                  <button onClick={() => addTag(post.id)} className="bg-[#AB4AFF] hover:bg-[#9933EE] text-white px-4 rounded-xl transition-colors shrink-0 text-sm">Add</button>
                </div>
              </Field>
            </div>
          )}
        </Card>
      ))}
      {items.length === 0 && (
        <div className="text-center py-12 text-[#8A8A93] bg-[#13131A] border border-dashed border-[#1A1A22] rounded-2xl">
          No blog posts yet. Click "New Post" to get started.
        </div>
      )}
    </div>
  );
}
