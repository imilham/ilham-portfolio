import { useState } from 'react';
import Link from 'next/link';
import { ArrowLeft, Calendar, Tag, ArrowRight, Search } from 'lucide-react';
import { getData } from '../data/store';
import type { BlogPost as BlogPostType } from '../data/store';

export function Blog() {
  const data = getData();
  const published = data.blog.filter(p => p.published);
  const [search, setSearch] = useState('');
  const [activeTag, setActiveTag] = useState('All');

  const allTags = ['All', ...Array.from(new Set(published.flatMap(p => p.tags)))];

  const filtered = published.filter(post => {
    const matchSearch =
      post.title.toLowerCase().includes(search.toLowerCase()) ||
      post.excerpt.toLowerCase().includes(search.toLowerCase());
    const matchTag = activeTag === 'All' || post.tags.includes(activeTag);
    return matchSearch && matchTag;
  });

  return (
    <div className="min-h-screen bg-[#0A0A0C] text-[#F4F4F6]">
      {/* Header */}
      <header className="sticky top-0 z-50 border-b border-[#1A1A22] bg-[#0A0A0C]/90 backdrop-blur-md">
        <div className="max-w-5xl mx-auto px-6 h-16 flex items-center justify-between">
          <Link href="/" className="flex items-center gap-2 text-[#8A8A93] hover:text-[#AB4AFF] transition-colors text-sm">
            <ArrowLeft size={16} />
            Back to Portfolio
          </Link>
          <span className="font-semibold text-[#F4F4F6]" style={{ fontFamily: 'Plus Jakarta Sans, sans-serif' }}>
            Blog
          </span>
        </div>
      </header>

      <main className="max-w-5xl mx-auto px-6 py-16">
        {/* Hero */}
        <div className="mb-12 text-center">
          <h1 className="mb-4 text-[#F4F4F6]" style={{ fontFamily: 'Plus Jakarta Sans, sans-serif', fontSize: '2.5rem', fontWeight: 700 }}>
            Thoughts & Articles
          </h1>
          <p className="text-[#8A8A93] max-w-xl mx-auto">
            I write about web development, design, and things I find interesting.
          </p>
        </div>

        {/* Search */}
        <div className="relative mb-6">
          <Search size={16} className="absolute left-4 top-1/2 -translate-y-1/2 text-[#8A8A93]" />
          <input
            value={search}
            onChange={e => setSearch(e.target.value)}
            placeholder="Search articles..."
            className="w-full bg-[#13131A] border border-[#1A1A22] rounded-xl pl-10 pr-4 py-3 text-sm text-[#F4F4F6] placeholder-[#8A8A93] focus:outline-none focus:border-[#AB4AFF] transition-colors"
          />
        </div>

        {/* Tags */}
        <div className="flex flex-wrap gap-2 mb-10">
          {allTags.map(tag => (
            <button
              key={tag}
              onClick={() => setActiveTag(tag)}
              className={`px-4 py-1.5 rounded-full text-sm transition-all ${
                activeTag === tag
                  ? 'bg-[#AB4AFF] text-white'
                  : 'bg-[#13131A] text-[#8A8A93] hover:text-[#F4F4F6] border border-[#1A1A22]'
              }`}
            >
              {tag}
            </button>
          ))}
        </div>

        {/* Posts */}
        {filtered.length === 0 ? (
          <div className="text-center py-20 text-[#8A8A93]">No articles found.</div>
        ) : (
          <div className="grid gap-6">
            {filtered.map(post => (
              <PostCard key={post.id} post={post} />
            ))}
          </div>
        )}
      </main>
    </div>
  );
}

function PostCard({ post }: { post: BlogPostType }) {
  return (
    <Link href={`/blog/${post.slug}`} className="block">
      <article className="flex flex-col md:flex-row gap-6 bg-[#13131A] border border-[#1A1A22] rounded-2xl overflow-hidden hover:border-[#AB4AFF]/40 transition-all duration-300 hover:shadow-[0_0_30px_rgba(171,74,255,0.08)]">
        {post.coverImage && (
          <div className="md:w-64 h-48 md:h-auto shrink-0 overflow-hidden">
            <img
              src={post.coverImage}
              alt={post.title}
              className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
            />
          </div>
        )}
        <div className="flex flex-col justify-between p-6">
          <div>
            <div className="flex items-center gap-4 mb-3 text-xs text-[#8A8A93]">
              <span className="flex items-center gap-1.5">
                <Calendar size={12} />
                {new Date(post.publishedAt).toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' })}
              </span>
            </div>
            <h2 className="mb-2 text-[#F4F4F6] group-hover:text-[#AB4AFF] transition-colors" style={{ fontFamily: 'Plus Jakarta Sans, sans-serif', fontSize: '1.2rem', fontWeight: 600 }}>
              {post.title}
            </h2>
            <p className="text-[#8A8A93] text-sm leading-relaxed line-clamp-2">{post.excerpt}</p>
          </div>
          <div className="flex items-center justify-between mt-4">
            <div className="flex flex-wrap gap-2">
              {post.tags.slice(0, 3).map(tag => (
                <span key={tag} className="flex items-center gap-1 text-xs bg-[#AB4AFF]/10 text-[#AB4AFF] px-2.5 py-1 rounded-full">
                  <Tag size={10} />
                  {tag}
                </span>
              ))}
            </div>
            <span className="flex items-center gap-1 text-xs text-[#AB4AFF] group-hover:gap-2 transition-all">
              Read more <ArrowRight size={12} />
            </span>
          </div>
        </div>
      </article>
    </Link>
  );
}
