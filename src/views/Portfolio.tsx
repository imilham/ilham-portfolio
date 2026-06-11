"use client";

import Link from 'next/link';
import { Navigation } from '../components/Navigation';
import { HeroSection } from '../components/HeroSection';
import { AboutSection } from '../components/AboutSection';
import { ProjectsSection } from '../components/ProjectsSection';
import { GallerySection } from '../components/GallerySection';
import { ContactSection } from '../components/ContactSection';
import { useSiteData } from '../hooks/useSiteData';

import { SiteData } from '../data/store';

export function Portfolio({ initialData }: { initialData?: SiteData }) {
  const { data, loading, error } = useSiteData(initialData);

  if (loading) {
    return (
      <div className="min-h-screen bg-[#0A0A0C] flex items-center justify-center">
        <div className="w-12 h-12 border-4 border-[#1A1A22] border-t-[#AB4AFF] rounded-full animate-spin"></div>
      </div>
    );
  }

  if (error || !data) {
    return (
      <div className="min-h-screen bg-[#0A0A0C] text-white flex items-center justify-center">
        Error loading portfolio data. Please try again later.
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-[#0A0A0C] text-[#F4F4F6]">
      <Navigation />
      <main className="pt-16">
        <HeroSection profile={data.profile} />
        <AboutSection profile={data.profile} education={data.education} />
        <ProjectsSection projects={data.projects} />
        <GallerySection gallery={data.gallery} />
        <ContactSection profile={data.profile} />
      </main>
      <footer className="border-t border-[#1A1A22] py-8">
        <div className="max-w-7xl mx-auto px-6">
          <div className="flex flex-col md:flex-row items-center justify-between gap-4 text-[#8A8A93] text-sm">
            <p>© 2026 {data.profile.name} — All rights reserved</p>
            <div className="flex items-center gap-4">
              <Link href="/blog" className="hover:text-[#AB4AFF] transition-colors">Blog</Link>
            </div>
          </div>
        </div>
      </footer>
    </div>
  );
}
