"use client";

import Link from 'next/link';
import { useParams } from 'next/navigation';
import { ArrowLeft, Calendar, Tag } from 'lucide-react';
import { useSiteData } from '../hooks/useSiteData';
import { SiteData } from '../data/store';

export function BlogPost({ initialData, slug: propSlug }: { initialData?: SiteData, slug?: string }) {
  const params = useParams();
  const slug = propSlug || (params?.slug as string);
  const { data, loading, error } = useSiteData(initialData);
  
  if (loading) {
    return (
      <div className="min-h-screen bg-[#0A0A0C] flex items-center justify-center">
        <div className="w-8 h-8 border-4 border-[#1A1A22] border-t-[#AB4AFF] rounded-full animate-spin"></div>
      </div>
    );
  }

  const post = data?.blog.find(p => p.slug === slug && p.published);

  if (!post) {
    return (
      <div className="min-h-screen bg-[#0A0A0C] text-[#F4F4F6] flex flex-col items-center justify-center gap-4">
        <p className="text-[#8A8A93]">Post not found.</p>
        <Link href="/blog" className="text-[#AB4AFF] hover:underline text-sm">Back to Blog</Link>
      </div>
    );
  }

  // Very simple markdown-like renderer
  const renderContent = (md: string) => {
    const lines = md.split('\n');
    const elements: React.ReactNode[] = [];
    let codeBlock = false;
    let codeLines: string[] = [];
    let keyIdx = 0;

    for (let i = 0; i < lines.length; i++) {
      const line = lines[i];
      if (line.startsWith('```')) {
        if (codeBlock) {
          elements.push(
            <pre key={keyIdx++} className="bg-[#0D0D14] border border-[#1A1A22] rounded-xl p-4 overflow-x-auto my-4">
              <code className="text-[#AB4AFF] text-sm" style={{ fontFamily: 'JetBrains Mono, monospace' }}>
                {codeLines.join('\n')}
              </code>
            </pre>
          );
          codeLines = [];
          codeBlock = false;
        } else {
          codeBlock = true;
        }
      } else if (codeBlock) {
        codeLines.push(line);
      } else if (line.startsWith('# ')) {
        elements.push(<h1 key={keyIdx++} className="text-[#F4F4F6] mt-8 mb-4" style={{ fontFamily: 'Plus Jakarta Sans, sans-serif', fontSize: '2rem', fontWeight: 700 }}>{line.slice(2)}</h1>);
      } else if (line.startsWith('## ')) {
        elements.push(<h2 key={keyIdx++} className="text-[#F4F4F6] mt-6 mb-3" style={{ fontFamily: 'Plus Jakarta Sans, sans-serif', fontSize: '1.4rem', fontWeight: 600 }}>{line.slice(3)}</h2>);
      } else if (line.startsWith('### ')) {
        elements.push(<h3 key={keyIdx++} className="text-[#F4F4F6] mt-4 mb-2" style={{ fontFamily: 'Plus Jakarta Sans, sans-serif', fontSize: '1.1rem', fontWeight: 600 }}>{line.slice(4)}</h3>);
      } else if (line.trim() === '') {
        elements.push(<div key={keyIdx++} className="h-2" />);
      } else {
        elements.push(<p key={keyIdx++} className="text-[#C4C4CC] leading-relaxed mb-2">{line}</p>);
      }
    }
    return elements;
  };

  return (
    <div className="min-h-screen bg-[#0A0A0C] text-[#F4F4F6]">
      {/* Header */}
      <header className="sticky top-0 z-50 border-b border-[#1A1A22] bg-[#0A0A0C]/90 backdrop-blur-md">
        <div className="max-w-3xl mx-auto px-6 h-16 flex items-center justify-between">
          <Link href="/blog" className="flex items-center gap-2 text-[#8A8A93] hover:text-[#AB4AFF] transition-colors text-sm">
            <ArrowLeft size={16} />
            All Articles
          </Link>
          <Link href="/" className="text-[#8A8A93] hover:text-[#F4F4F6] transition-colors text-sm">Portfolio</Link>
        </div>
      </header>

      {/* Cover Image */}
      {post.coverImage && (
        <div className="w-full h-72 overflow-hidden">
          <img src={post.coverImage} alt={post.title} className="w-full h-full object-cover" />
        </div>
      )}

      <main className="max-w-3xl mx-auto px-6 py-12">
        {/* Meta */}
        <div className="flex items-center gap-4 mb-4 text-sm text-[#8A8A93]">
          <span className="flex items-center gap-1.5">
            <Calendar size={14} />
            {new Date(post.publishedAt).toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' })}
          </span>
        </div>

        <h1 className="mb-4 text-[#F4F4F6]" style={{ fontFamily: 'Plus Jakarta Sans, sans-serif', fontSize: '2.2rem', fontWeight: 700, lineHeight: '1.2' }}>
          {post.title}
        </h1>

        <p className="text-[#8A8A93] mb-6 text-lg">{post.excerpt}</p>

        {/* Tags */}
        <div className="flex flex-wrap gap-2 mb-10 pb-10 border-b border-[#1A1A22]">
          {post.tags.map(tag => (
            <span key={tag} className="flex items-center gap-1 text-xs bg-[#AB4AFF]/10 text-[#AB4AFF] px-3 py-1.5 rounded-full">
              <Tag size={10} />
              {tag}
            </span>
          ))}
        </div>

        {/* Content */}
        <div>{renderContent(post.content)}</div>
      </main>
    </div>
  );
}
