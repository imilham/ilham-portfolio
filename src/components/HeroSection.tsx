import { useState, useEffect } from 'react';
import { ArrowRight, Download } from 'lucide-react';
import { motion, AnimatePresence } from 'motion/react';
import { Profile } from '../data/store';
import { getDriveViewUrl, getDriveDownloadUrl } from '../lib/drive';
import { ImageLoader } from './ImageLoader';

interface HeroSectionProps {
  profile: Profile;
}

export function HeroSection({ profile }: HeroSectionProps) {
  const [currentTextIndex, setCurrentTextIndex] = useState(0);

  useEffect(() => {
    if (!profile.enableCarousel || !profile.carouselTexts || profile.carouselTexts.length <= 1) return;
    const interval = setInterval(() => {
      setCurrentTextIndex(prev => (prev + 1) % profile.carouselTexts!.length);
    }, 3000);
    return () => clearInterval(interval);
  }, [profile.enableCarousel, profile.carouselTexts]);

  const downloadUrl = getDriveDownloadUrl(profile.cvUrl);
  const heroPhotoUrl = getDriveViewUrl(profile.heroPhoto);

  return (
    <section className="min-h-screen flex items-center justify-center px-6 py-20">
      <div className="max-w-7xl mx-auto w-full">
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
          {/* Left Content */}
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6 }}
            className="space-y-6"
          >
            <div className="space-y-4">
              <h1 className="text-5xl lg:text-7xl font-bold leading-tight">
                Hi, I'm <span className="text-[#AB4AFF]">{profile.name}</span>
              </h1>
              
              {profile.enableCarousel && profile.carouselTexts && profile.carouselTexts.length > 0 && (
                <div className="text-2xl lg:text-4xl font-semibold text-[#C4C4CC] relative h-[1.2em] flex items-center mt-2">
                  <AnimatePresence mode="wait">
                    <motion.div
                      key={currentTextIndex}
                      initial={{ opacity: 0, x: -30 }}
                      animate={{ opacity: 1, x: 0 }}
                      exit={{ opacity: 0, x: 30 }}
                      transition={{ duration: 0.4, ease: "easeInOut" }}
                      className="absolute left-0 whitespace-nowrap"
                    >
                      {profile.carouselTexts[currentTextIndex]}
                    </motion.div>
                  </AnimatePresence>
                </div>
              )}
              
              <p className="text-2xl lg:text-3xl text-[#8A8A93] pt-2">
                {profile.tagline}
              </p>
            </div>

            <p className="text-lg text-[#8A8A93] leading-relaxed max-w-xl whitespace-pre-line">
              {profile.bio}
            </p>

            <div className="flex flex-wrap gap-4">
              <button className="px-6 py-3 bg-[#AB4AFF] text-white rounded-lg hover:bg-[#9A3FEE] transition-all flex items-center gap-2 shadow-lg shadow-[#AB4AFF]/25">
                Hire Me
                <ArrowRight className="w-5 h-5" />
              </button>
              {profile.cvUrl ? (
                <a href={downloadUrl} download="CV.pdf" className="px-6 py-3 bg-[#1A1A22] text-white rounded-lg hover:bg-[#252530] transition-all flex items-center gap-2 border border-[#1A1A22]">
                  <Download className="w-5 h-5" />
                  Download CV
                </a>
              ) : (
                <button className="px-6 py-3 bg-[#1A1A22] text-[#8A8A93] rounded-lg flex items-center gap-2 border border-[#1A1A22] cursor-not-allowed opacity-50" title="CV not available yet">
                  <Download className="w-5 h-5" />
                  Download CV
                </button>
              )}
            </div>

            {/* Stats */}
            <div className="grid grid-cols-3 gap-6 pt-8">
              {profile.stats.map((stat, i) => (
                <div key={i}>
                  <div className="text-3xl font-bold text-[#AB4AFF]">{stat.value}</div>
                  <div className="text-[#8A8A93]">{stat.label}</div>
                </div>
              ))}
            </div>
          </motion.div>

          {/* Right - Profile Image */}
          <motion.div
            initial={{ opacity: 0, scale: 0.95 }}
            animate={{ opacity: 1, scale: 1 }}
            transition={{ duration: 0.6, delay: 0.2 }}
            className="flex justify-center lg:justify-end"
          >
            <div className="relative">
              <div className="absolute inset-0 bg-gradient-to-br from-[#AB4AFF] to-[#7B2FBF] rounded-3xl blur-3xl opacity-30" />
              {profile.heroPhoto ? (
                <ImageLoader
                  src={heroPhotoUrl}
                  alt={profile.name}
                  containerClassName="relative w-80 h-80 lg:w-96 lg:h-96 rounded-3xl border-4 border-[#1A1A22] shadow-2xl"
                  className="w-full h-full object-cover"
                />
              ) : (
                <div className="relative w-80 h-80 lg:w-96 lg:h-96 rounded-3xl border-4 border-[#1A1A22] bg-[#121216] shadow-2xl flex items-center justify-center">
                  <span className="text-[#8A8A93]">No Photo</span>
                </div>
              )}
            </div>
          </motion.div>
        </div>
      </div>
    </section>
  );
}
