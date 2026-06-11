import { useState } from 'react';
import { motion } from 'motion/react';
import { Profile, Education } from '../data/store';

interface AboutSectionProps {
  profile: Profile;
  education: Education[];
}

export function AboutSection({ profile, education }: AboutSectionProps) {
  const [activeTab, setActiveTab] = useState<'skills' | 'education' | 'certifications'>('skills');

  const certifications = profile.certifications || [];

  return (
    <section id="about" className="py-20 px-6">
      <div className="max-w-7xl mx-auto">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6 }}
        >
          <h2 className="text-4xl lg:text-5xl font-bold mb-6">
            About <span className="text-[#AB4AFF]">Me</span>
          </h2>

          <div className="grid grid-cols-1 lg:grid-cols-2 gap-12">
            {/* Left - Description */}
            <div className="space-y-4 text-[#8A8A93] leading-relaxed">
              <p className="whitespace-pre-line">{profile.bio}</p>

              <div className="pt-4">
                <h3 className="text-xl font-bold text-[#F4F4F6] mb-4">Core Values</h3>
                <ul className="space-y-2">
                  <li className="flex items-start gap-2">
                    <span className="text-[#AB4AFF] mt-1">▸</span>
                    <span>Performance-first mindset with focus on optimization</span>
                  </li>
                  <li className="flex items-start gap-2">
                    <span className="text-[#AB4AFF] mt-1">▸</span>
                    <span>Clean, maintainable code that scales</span>
                  </li>
                  <li className="flex items-start gap-2">
                    <span className="text-[#AB4AFF] mt-1">▸</span>
                    <span>User-centric design and seamless experiences</span>
                  </li>
                </ul>
              </div>
            </div>

            {/* Right - Tabs */}
            <div>
              <div className="flex gap-4 border-b border-[#1A1A22] mb-6">
                <button
                  onClick={() => setActiveTab('skills')}
                  className={`pb-3 px-4 font-medium transition-all ${
                    activeTab === 'skills'
                      ? 'text-[#AB4AFF] border-b-2 border-[#AB4AFF]'
                      : 'text-[#8A8A93] hover:text-[#F4F4F6]'
                  }`}
                >
                  Skills
                </button>
                <button
                  onClick={() => setActiveTab('education')}
                  className={`pb-3 px-4 font-medium transition-all ${
                    activeTab === 'education'
                      ? 'text-[#AB4AFF] border-b-2 border-[#AB4AFF]'
                      : 'text-[#8A8A93] hover:text-[#F4F4F6]'
                  }`}
                >
                  Education
                </button>
                <button
                  onClick={() => setActiveTab('certifications')}
                  className={`pb-3 px-4 font-medium transition-all ${
                    activeTab === 'certifications'
                      ? 'text-[#AB4AFF] border-b-2 border-[#AB4AFF]'
                      : 'text-[#8A8A93] hover:text-[#F4F4F6]'
                  }`}
                >
                  Certifications
                </button>
              </div>

              {/* Tab Content */}
              {activeTab === 'skills' && (
                <div className="flex flex-wrap gap-3">
                  {profile.skills.map((skill) => (
                    <span
                      key={skill}
                      className="px-4 py-2 bg-[#121216] border border-[#1A1A22] rounded-lg text-[#F4F4F6] hover:border-[#AB4AFF] transition-colors"
                    >
                      {skill}
                    </span>
                  ))}
                  {profile.skills.length === 0 && (
                    <span className="text-[#8A8A93]">No skills added yet.</span>
                  )}
                </div>
              )}

              {activeTab === 'education' && (
                <div className="space-y-6">
                  {education.map((edu) => (
                    <div key={edu.id} className="bg-[#121216] border border-[#1A1A22] rounded-lg p-6">
                      <h4 className="font-bold text-[#F4F4F6] mb-2">{edu.degree}</h4>
                      <p className="text-[#8A8A93]">{edu.school}</p>
                      <p className="text-[#AB4AFF] text-sm mt-2">{edu.year}</p>
                      {edu.description && <p className="text-[#8A8A93] mt-3 text-sm">{edu.description}</p>}
                    </div>
                  ))}
                  {education.length === 0 && (
                    <span className="text-[#8A8A93]">No education added yet.</span>
                  )}
                </div>
              )}

              {activeTab === 'certifications' && (
                <div className="space-y-3">
                  {certifications.map((cert, index) => (
                    <div
                      key={index}
                      className="bg-[#121216] border border-[#1A1A22] rounded-lg p-4 hover:border-[#AB4AFF] transition-colors"
                    >
                      <p className="text-[#F4F4F6]">{cert}</p>
                    </div>
                  ))}
                </div>
              )}
            </div>
          </div>
        </motion.div>
      </div>
    </section>
  );
}
