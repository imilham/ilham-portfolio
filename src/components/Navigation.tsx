import { useState } from 'react';
import Link from 'next/link';
import { Menu, X } from 'lucide-react';

export function Navigation() {
  const [isOpen, setIsOpen] = useState(false);

  const scrollToSection = (id: string) => {
    const element = document.getElementById(id);
    if (element) {
      element.scrollIntoView({ behavior: 'smooth' });
      setIsOpen(false);
    }
  };

  return (
    <nav className="fixed top-0 left-0 right-0 z-50 bg-[#0A0A0C]/80 backdrop-blur-xl border-b border-[#1A1A22]">
      <div className="max-w-7xl mx-auto px-6 py-4">
        <div className="flex items-center justify-between">
          {/* Logo */}
          <a href="#" className="text-2xl font-bold">
            imilham<span className="text-[#AB4AFF]">.</span>
          </a>

          {/* Desktop Navigation */}
          <div className="hidden md:flex items-center gap-8">
            <button
              onClick={() => scrollToSection('about')}
              className="text-[#F4F4F6] hover:text-[#AB4AFF] transition-colors"
            >
              About
            </button>
            <button
              onClick={() => scrollToSection('projects')}
              className="text-[#F4F4F6] hover:text-[#AB4AFF] transition-colors"
            >
              Projects
            </button>
            <button
              onClick={() => scrollToSection('gallery')}
              className="text-[#F4F4F6] hover:text-[#AB4AFF] transition-colors"
            >
              Gallery
            </button>
            <Link
              href="/blog"
              className="text-[#F4F4F6] hover:text-[#AB4AFF] transition-colors"
            >
              Blog
            </Link>
            <button
              onClick={() => scrollToSection('contact')}
              className="px-4 py-2 bg-[#AB4AFF] text-white rounded-lg hover:bg-[#9A3FEE] transition-colors"
            >
              Contact
            </button>
          </div>

          {/* Mobile Menu Button */}
          <button
            onClick={() => setIsOpen(!isOpen)}
            className="md:hidden text-[#F4F4F6]"
          >
            {isOpen ? <X className="w-6 h-6" /> : <Menu className="w-6 h-6" />}
          </button>
        </div>

        {/* Mobile Menu */}
        {isOpen && (
          <div className="md:hidden mt-4 py-4 space-y-4 border-t border-[#1A1A22]">
            <button
              onClick={() => scrollToSection('about')}
              className="block w-full text-left text-[#F4F4F6] hover:text-[#AB4AFF] transition-colors"
            >
              About
            </button>
            <button
              onClick={() => scrollToSection('projects')}
              className="block w-full text-left text-[#F4F4F6] hover:text-[#AB4AFF] transition-colors"
            >
              Projects
            </button>
            <button
              onClick={() => scrollToSection('gallery')}
              className="block w-full text-left text-[#F4F4F6] hover:text-[#AB4AFF] transition-colors"
            >
              Gallery
            </button>
            <Link
              href="/blog"
              onClick={() => setIsOpen(false)}
              className="block w-full text-left text-[#F4F4F6] hover:text-[#AB4AFF] transition-colors"
            >
              Blog
            </Link>
            <button
              onClick={() => scrollToSection('contact')}
              className="block w-full text-left px-4 py-2 bg-[#AB4AFF] text-white rounded-lg hover:bg-[#9A3FEE] transition-colors"
            >
              Contact
            </button>
          </div>
        )}
      </div>
    </nav>
  );
}
