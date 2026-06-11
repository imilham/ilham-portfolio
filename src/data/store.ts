export interface Education {
  id: string;
  degree: string;
  school: string;
  year: string;
  description: string;
}

export interface Experience {
  id: string;
  role: string;
  company: string;
  period: string;
  description: string;
  technologies: string[];
}

export interface Project {
  id: string;
  title: string;
  description: string;
  tags: string[];
  liveUrl: string;
  githubUrl: string;
  featured: boolean;
  image: string;
}

export interface GalleryPhoto {
  id: string;
  url: string;
  caption: string;
  category: string;
}

export interface BlogPost {
  id: string;
  title: string;
  slug: string;
  excerpt: string;
  content: string;
  tags: string[];
  coverImage: string;
  publishedAt: string;
  published: boolean;
}

export interface Profile {
  name: string;
  tagline: string;
  bio: string;
  location: string;
  email: string;
  github: string;
  linkedin: string;
  twitter: string;
  heroPhoto: string;
  siteTitle: string;
  cvUrl: string;
  enableCarousel?: boolean;
  carouselTexts?: string[];
  skills: string[];
  stats: { label: string; value: string }[];
}

export interface SiteData {
  profile: Profile;
  education: Education[];
  experience: Experience[];
  projects: Project[];
  gallery: GalleryPhoto[];
  blog: BlogPost[];
}

const STORAGE_KEY = 'portfolio_data';

export const defaultData: SiteData = {
  profile: {
    name: 'Ilham',
    tagline: "I build things for the web.",
    bio: "I'm a passionate full-stack developer who loves crafting beautiful, performant web experiences. I specialize in React, TypeScript, and modern web technologies.",
    location: 'Colombo, Sri Lanka',
    email: 'hello@example.com',
    github: 'https://github.com',
    linkedin: 'https://linkedin.com',
    twitter: 'https://twitter.com',
    heroPhoto: '',
    siteTitle: 'My Portfolio',
    cvUrl: '',
    enableCarousel: true,
    carouselTexts: ['Ilham', 'a Developer', 'a Designer'],
    skills: ['React', 'TypeScript', 'Node.js', 'Next.js', 'Tailwind CSS', 'PostgreSQL', 'Docker', 'AWS'],
    stats: [
      { label: 'Projects', value: '20+' },
      { label: 'Years Exp.', value: '3+' },
      { label: 'Happy Clients', value: '15+' },
    ],
  },
  education: [
    {
      id: '1',
      degree: 'BSc in Computer Science',
      school: 'University of Colombo',
      year: '2020 – 2024',
      description: 'Specialized in Software Engineering and Artificial Intelligence.',
    },
  ],
  experience: [
    {
      id: '1',
      role: 'Frontend Developer',
      company: 'Tech Company',
      period: 'Jan 2024 – Present',
      description: 'Building modern web applications with React and TypeScript.',
      technologies: ['React', 'TypeScript', 'Tailwind CSS'],
    },
  ],
  projects: [
    {
      id: '1',
      title: 'Portfolio Website',
      description: 'A modern portfolio website built with React and Tailwind CSS.',
      tags: ['React', 'TypeScript', 'Tailwind'],
      liveUrl: '#',
      githubUrl: '#',
      featured: true,
      image: 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=600&q=80',
    },
  ],
  gallery: [
    {
      id: '1',
      url: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=600&q=80',
      caption: 'Mountain sunrise',
      category: 'Nature',
    },
    {
      id: '2',
      url: 'https://images.unsplash.com/photo-1519501025264-65ba15a82390?w=600&q=80',
      caption: 'City lights',
      category: 'Urban',
    },
  ],
  blog: [
    {
      id: '1',
      title: 'Getting Started with React and TypeScript',
      slug: 'getting-started-react-typescript',
      excerpt: 'A beginner-friendly guide to setting up a React project with TypeScript.',
      content: `# Getting Started with React and TypeScript

TypeScript brings static typing to JavaScript, making your React apps more robust and maintainable.

## Why TypeScript?

TypeScript helps catch bugs at compile time, improves IDE autocomplete, and makes refactoring safer.

## Setting Up

\`\`\`bash
npx create-react-app my-app --template typescript
\`\`\`

## Your First Component

\`\`\`tsx
interface Props {
  name: string;
  age?: number;
}

const Greeting = ({ name, age }: Props) => (
  <div>
    <h1>Hello, {name}!</h1>
    {age && <p>You are {age} years old.</p>}
  </div>
);
\`\`\`

That's all you need to get started!`,
      tags: ['React', 'TypeScript', 'Tutorial'],
      coverImage: 'https://images.unsplash.com/photo-1633356122102-3fe601e05bd2?w=800&q=80',
      publishedAt: '2026-05-15',
      published: true,
    },
  ],
};

import { doc, getDoc, setDoc } from 'firebase/firestore';
import { db } from '../lib/firebase';

const DOC_ID = 'main';
const COLLECTION = 'portfolio';

export async function loadData(): Promise<SiteData> {
  try {
    const docRef = doc(db, COLLECTION, DOC_ID);
    const docSnap = await getDoc(docRef);
    
    if (docSnap.exists()) {
      return { ...defaultData, ...(docSnap.data() as SiteData) };
    } else {
      // Initialize with default data if it doesn't exist
      await setDoc(docRef, defaultData);
      return defaultData;
    }
  } catch (error) {
    console.error("Error loading data from Firestore:", error);
    return defaultData;
  }
}

export async function saveData(data: SiteData): Promise<void> {
  try {
    const docRef = doc(db, COLLECTION, DOC_ID);
    await setDoc(docRef, data);
  } catch (error) {
    console.error("Error saving data to Firestore:", error);
    throw error;
  }
}

// Keep getData for backwards compatibility but it returns a promise now
export async function getData(): Promise<SiteData> {
  return loadData();
}

export async function updateData(partial: Partial<SiteData>): Promise<void> {
  const current = await loadData();
  await saveData({ ...current, ...partial });
}
